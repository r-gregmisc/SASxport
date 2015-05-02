/*
 * File: SASxport/src/ibm2ieee.c
 *
 * Originally from BRL-CAD, file /brlcad/src/libbu/htond.c
 *
 * Copyright (c) 2004-2007 United States Government as represented by
 * the U.S. Army Research Laboratory.
 *
 * Minor changes (c) 2007 Gregory R. Warnes <greg@warnes.net>
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
 * ieee2ibm
 *
 *  Convert an array of BIG-ENDIAN IEEE double precision value at *in
 *  of length 'count'to IBM/360 format double precision values at *out
 *
 *  This code was extracted from the "ntohd" function, original author
 *  Michael John Muuss
 *
 *  Note that neither the input or output buffers need be word aligned,
 *  for greatest flexability in converting data, even though this
 *  imposes a speed penalty here.
 *
 ***************************/

void ieee2ibm(register unsigned char *out, register const unsigned char *in, int count)
{
  static char numeric_NA[8] = {0x2e,0x00,0x00,0x00,0x00,0x00,0x00,0x00};


  /*
   *  IBM Format.
   *  7-bit exponent, base 16.
   *  No hidden bits in mantissa (56 bits).
   */
  register int	i;
  for( i=count-1; i >= 0; i-- )
    {
      register unsigned int left, right;
      register int fix, exp, signbit;

      left  = ( (unsigned int) in[0]<<24) |
	      (	(unsigned int) in[1]<<16) |
	      ( (unsigned int) in[2]<<8 ) |
	      in[3];
      right = ( (unsigned int) in[4]<<24) |
              ( (unsigned int) in[5]<<16) |
              ( (unsigned int) in[6]<<8 ) |
	      in[7];
      in += 8;

      exp = ((left >> 20) & 0x7FF);
      signbit = (left & 0x80000000) >> 24;

      if( exp == 0 || exp == 0x7FF )
	{
	  *out++ = 0;		/* IBM zero.  No NAN */
	  *out++ = 0;
	  *out++ = 0;
	  *out++ = 0;
	  *out++ = 0;
	  *out++ = 0;
	  *out++ = 0;
	  *out++ = 0;
	  continue;
	}

      left = (left & 0x000FFFFF) | 0x00100000;/* replace "hidden" bit */

      exp += 129 - 1023 -1;	/* fudge, to make /4 and %4 work */
      fix = exp % 4;		/* 2^4 == 16^1;  get fractional exp */
      exp /= 4;		/* excess 32, base 16 */
      exp += (64-32+1);	/* excess 64, base 16, plus fudge */
      if( (exp & ~0xFF) != 0 )
	{
	  warning("IBM exponent overflow, generating NA\n");
	  memcpy(out, numeric_NA, 8);
	  out+= 8;
	  continue;
	}

      if( fix )
	{
	  left = ( (unsigned int) left<<fix) | (right >> (32-fix));
	  right <<= fix;
	}

      /* if( 0 && signbit )  { */
      if( 0 )
	{
	  /* The IBM actually uses complimented mantissa
	   * and exponent.
	   */
	  left  ^= 0xFFFFFFFF;
	  right ^= 0xFFFFFFFF;
	  if( right & 0x80000000 )
	    {
	      /* There may be a carry */
	      right += 1;
	      if( (right & 0x80000000) == 0 )
		{
		  /* There WAS a carry */
		  left += 1;
		}
	    }
	  else
	    {
	      /* There will be no carry to worry about */
	      right += 1;
	    }
	  left &= 0x00FFFFFF;
	  exp = (~exp) & 0x7F;
	}

      /*  Not actually required, but for comparison purposes,
       *  normalize the number.  Remove for production speed.
       */
      while( (left & 0x00F00000) == 0 && left != 0 )
	{
	  if( signbit && exp <= 0x41 )  break;

	  left = ( (unsigned int) left << 4) | (right >> (32-4));
	  right <<= 4;
	  if(signbit)  exp--;
	  else exp++;
	}

      *out++ = signbit | exp;
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
