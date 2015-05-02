/*******
 *
 *    init.c: Routines to register SASxport C routines with R
 *
 *    Author:  Gregory R. Warnes <greg@warnes.net>
 *
 *    Copyright (C) 2007 Gregory R. Warnes
 * 
 *    This program is free software; you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation; either version 2 of the License, or
 *    (at your option) any later version.
 *
 *    This program is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with this program; if not, write to the Free Software
 *    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
 *    02110-1301, USA
 *
 *******/

#include <R.h>
#include <Rinternals.h>
#include <R_ext/Rdynload.h>
#include "writeSAS.h"

#define ARGTYPE static R_NativePrimitiveArgType

ARGTYPE fill_file_header_args[]    = { STRSXP, STRSXP, STRSXP, STRSXP };
ARGTYPE fill_member_header_args[]  = { STRSXP, STRSXP, STRSXP, STRSXP, STRSXP, STRSXP, 
				       STRSXP };
ARGTYPE fill_namestr_args[]        = { INTSXP, INTSXP, INTSXP, STRSXP, STRSXP, 
				       STRSXP, INTSXP, INTSXP, INTSXP, STRSXP, 
				       INTSXP, INTSXP, INTSXP };
ARGTYPE fill_namestr_header_args[] = { STRSXP };
ARGTYPE fill_numeric_field_args[]  = { REALSXP };
ARGTYPE fill_character_field_args[]= { STRSXP, INTSXP };
ARGTYPE fill_space_args[]          = { INTSXP, INTSXP };

#define CDEF(name, narg, argVec)  { #name, (DL_FUNC) &name, narg, argVec }
static const R_CMethodDef CEntries[]  = {
  CDEF(fill_file_header,     4, fill_file_header_args    ),
  CDEF(fill_member_header,   7, fill_member_header_args  ),
  CDEF(fill_namestr,        13, fill_namestr_args        ),
  CDEF(fill_namestr_header,  1, fill_namestr_header_args ),
  CDEF(fill_obs_header,      0, 0                        ),
  CDEF(fill_numeric_field,   1, fill_numeric_field_args  ),
  CDEF(fill_character_field, 2, fill_character_field_args),
  CDEF(fill_numeric_NA,      0, 0                        ),
  CDEF(fill_space,           2, fill_space_args          ),
  CDEF(doTest,               0, fill_space_args          ),
  { NULL, NULL, 0}
};

SEXP xport_info(SEXP xportFile);
SEXP xport_read(SEXP xportFile, SEXP xportInfo);

#define CALLDEF(name, n)  {#name, (DL_FUNC) &name, n}
static const R_CallMethodDef CallEntries[] = {
    CALLDEF(getRawBuffer, 0), 
    CALLDEF(xport_info, 1),
    CALLDEF(xport_read, 2),
    {NULL, NULL, 0}
};

void R_init_SASxport(DllInfo *dll)
{
  R_registerRoutines(dll, CEntries, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
