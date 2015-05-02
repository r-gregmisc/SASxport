/*
 * File: SASxport/src/ibm2ieee.c
 *
 * Originally from BRL-CAD file /brlcad/src/libbu/htond.c
 *
 * Copyright (c) 2004-2007 United States Government as represented by
 * the U.S. Army Research Laboratory.
 *
 *  * Minor changes (c) 2007 by Gregory R. Warnes <greg@warnes.net>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public License
 * version 2.1 as published by the Free Software Foundation.
 *
 * This library is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this file; see the file named COPYING for more
 * information.
 */

#include <stdio.h>
#include "ibm2ieee.h"

/****************************
 * ibm2ieee
 *
 *  Convert an array of IBM/360 format double precision values of at *in
 *  of length 'count' to BIG-ENDIAN IEEE double precision value at *out.
 *
 *  This code was extracted from the "ntohd" function, original author
 *  Michael John Muuss
 *
 *  Note that neither the input or output buffers need be word aligned,
 *  for greatest flexability in converting data, even though this
 *  imposes a speed penalty here.
 *
 ***************************/

void ibm2ieee(register unsigned char *out,
	      register const unsigned char *in,
	      int count)
{
	/*
	 *  IBM Format.
	 *  7-bit exponent, base 16.
	 *  No hidden bits in mantissa (56 bits).
	 */
	register int	i;
	int loop = 0;

	static char numeric_NA[8] = {0x2e,0x00,0x00,0x00,0x00,0x00,0x00,0x00};

	for( i=count-1; i >= 0; i-- )  {
		register unsigned int left, right, signbit;
		register int exp;

		left  = ( (unsigned int) in[0]<<24) |
                        ( (unsigned int) in[1]<<16) |
                        ( (unsigned int) in[2]<<8) |
                        in[3];
		right = ( (unsigned int) in[4]<<24) |
                        ( (unsigned int) in[5]<<16) |
                        ( (unsigned int) in[6]<<8)  |
                        in[7];
		in += 8;

		exp = (left>>24) & 0x7F;	/* excess 64, base 16 */
		if( left == 0 && right == 0 )
			OUT_IEEE_ZERO;

		signbit = left & 0x80000000;
		left &= 0x00FFFFFF;

		/*if( signbit )  {*/
		if( 0 )  {
			/* The IBM uses 2's compliment on the mantissa,
			 * and IEEE does not.
			 */
			left  ^= 0xFFFFFFFF;
			right ^= 0xFFFFFFFF;
			if( right & 0x80000000 )  {
				/* There may be a carry */
				right += 1;
				if( (right & 0x80000000) == 0 )  {
					/* There WAS a carry */
					left += 1;
				}
			} else {
				/* There will be no carry to worry about */
				right += 1;
			}
			left &= 0x00FFFFFF;
			exp = (~exp) & 0x7F;
		}
		exp -= (64-32+1);		/* excess 32, base 16, + fudge */
		exp *= 4;			/* excess 128, base 2 */
ibm_normalized:
		if( left & 0x00800000 )  {
			/* fix = 0; */
			exp += 1023-129+1+ 3-0;/* fudge, slide hidden bit */
		} else if( left & 0x00400000 ) {
			/* fix = 1; */
			exp += 1023-129+1+ 3-1;
			left = ( (unsigned int) left<<1) |
				( (right>>(32-1)) & (0x7FFFFFFF>>(31-1)) );
			right <<= 1;
		} else if( left & 0x00200000 ) {
			/* fix = 2; */
			exp += 1023-129+1+ 3-2;
			left = ( (unsigned int) left<<2) |
				( (right>>(32-2)) & (0x7FFFFFFF>>(31-2)) );
			right <<= 2;
		} else if( left & 0x00100000 ){
			/* fix = 3; */
			exp += 1023-129+1+ 3-3;
			left = ( (unsigned int) left<<3) |
				( (right>>(32-3)) & (0x7FFFFFFF>>(31-3)) );
			right <<= 3;
		} else {
			/*  Encountered 4 consecutive 0 bits of mantissa,
			 *  attempt to normalize, and loop.
			 *  This case was not expected, but does happen,
			 *  at least on the Gould.
			 */
		        if(loop)
			  {
			    warning("IBM exponent overflow, generating NA\n");
			    memcpy(out, numeric_NA, 8);
			    out+= 8;
			    continue;
			  }
			else
			  loop = 1;

			exp -= 4;
			left = ( (unsigned int) left<<4) | (right>>(32-4));
			right <<= 4;
			goto ibm_normalized;
		}

		/* After suitable testing, this check can be deleted */
		if( (left & 0x00800000) == 0 )  {
		  //fprintf(stderr,
		  error("ibm->ieee missing 1, left=x%x\n", left);
			left = ( (unsigned int) left<<1) | (right>>31);
			right <<= 1;
			goto ibm_normalized;
		}

		/* Having nearly VAX format, shift to IEEE, rounding. */
#		ifdef ROUNDING
			right = ( (unsigned int) left<<(32-3)) | ((right+4)>>3);
#		else
			right = ( (unsigned int) left<<(32-3)) | (right>>3);
#		endif
		left =  ((left & 0x007FFFFF)>>3) | signbit | (exp<<20);

		*out++ = left>>24;
		*out++ = left>>16;
		*out++ = left>>8;
		*out++ = left;
		*out++ = right>>24;
		*out++ = right>>16;
		*out++ = right>>8;
		*out++ = right;
	}
	return;
}
