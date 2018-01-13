/*
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, a copy is available at
 *  http://www.r-project.org/Licenses/
 */
#ifndef TO_BIGEND_H
#define TO_BIGEND_H

void to_bigend( unsigned char *intp, size_t size);

/* Convert (if necessary) to Big-Endian  */
#define TO_BIGEND_SHORT(a)  to_bigend( (unsigned char*) &a, sizeof(short)  )
#define TO_BIGEND_INT(a)    to_bigend( (unsigned char*) &a, sizeof(int)    )
#define TO_BIGEND_DOUBLE(a) to_bigend( (unsigned char*) &a, sizeof(double) )

/* Alternative definition using system functions: */
/* #define TO_BIGEND_SHORT(a) (a) = htons( a ) */
/* #define TO_BIGEND_INT(a)   (a) = htonl( a ) */

#endif /* TO_BIGEND_H */
