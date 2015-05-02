/*
 * File: SASxport/src/ibm2ieee.h
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
#ifndef IBM2IEEE_H
#define IBM2IEEE_H

#include <R.h>
#include <Rinternals.h>

#define	OUT_IEEE_ZERO	{ \
	*out++ = 0; \
	*out++ = 0; \
	*out++ = 0; \
	*out++ = 0; \
	*out++ = 0; \
	*out++ = 0; \
	*out++ = 0; \
	*out++ = 0; \
	continue; } \

#define	OUT_IEEE_NAN	{ /* Signaling NAN */ \
	*out++ = 0xFF; \
	*out++ = 0xF0; \
	*out++ = 0x0B; \
	*out++ = 0xAD; \
	*out++ = 0x0B; \
	*out++ = 0xAD; \
	*out++ = 0x0B; \
	*out++ = 0xAD; \
	continue; } \


void ieee2ibm(register unsigned char *out,
	      register const unsigned char *in,
	      int count);

void ibm2ieee(register unsigned char *out,
	      register const unsigned char *in,
	      int count);


#endif /* IBM2IEEE_H */
