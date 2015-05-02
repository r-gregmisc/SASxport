/*******
 *
 *    writeSAS.c: Routines for writing SAS XPT formatted files
 *
 *    Author:  Gregory R. Warnes <greg@warnes.net>
 *
 *    Copyright (C) 2007-2013  Gregory R. Warnes <greg@warnes.net>
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

#include <stdio.h>
#include <string.h>

#include <R.h>
#include <Rinternals.h>

#include "writeSAS.h"


/* Fill <target> buffer with <len> blanks without any terminating nulls */
void blankFill(char *target, int len)
{
  int i;

  for(i=0; i<(len); i++)
    target[i]=' ';
}

/* Copy at most <len> characters from the null-terminated string in <source> to the
   <target> buffer and space-fill the remainder. No terminating null. */
void blankCopy(char *target, int len, char *source)
{
  int sourceLen = strlen(source);
  int copyLen = MIN(sourceLen,len);

  int i;
  for(i=0; i<copyLen; i++)
    target[i] = source[i];
  for(;i<len;i++)  /* Pick up the existing value if i */
    target[i] = ' ';
}


/* Fill <target> buffer with <len> blanks without any terminating nulls */
void zeroFill(char *target, int len)
{
  int i;

  for(i=0; i<(len); i++)
    target[i]=0;
}

/* Copy at most <len> characters from the null-terminated string in <source> to the
   <target> buffer and space-fill the remainder. No terminating null. */
void zeroCopy(char *target, int len, char *source)
{
  int sourceLen = strlen(source);
  int copyLen = MIN(sourceLen,len);

  int i;
  for(i=0; i<copyLen; i++)
    target[i] = source[i];
  for(;i<len;i++)   /* Pick up the existing value if i */
    target[i] = 0;
}





/*
 * This function is used to retreive the filled buffer as an R 'raw'
 * object.  This is necessary because the buffer legitimately contains
 * embedded nulls and R currently does not permit raw buffers to be
 * passed via .C .
 */

#define MYBUFSIZE 1024 /* plenty big */
char raw_buffer[MYBUFSIZE];
int  raw_buffer_used=10;

SEXP getRawBuffer()
{
  SEXP rawVec;

  /* create the raw vector */
  rawVec = allocVector(RAWSXP, raw_buffer_used);

  /* copy the appropriate number of bytes */
  memcpy( RAW(rawVec), raw_buffer, raw_buffer_used);

  return rawVec;
}




void fill_file_header(
		      char **cDate,   /* creation date                    */
		      char **mdate,   /* modification date                */
		      char **sasVer,  /* SAS version number               */
		      char **osType   /* operating system                 */
		      )
{
  struct FILE_HEADER file_header;

  /* Line 1 */
  blankCopy( file_header.h1, 80, "HEADER RECORD*******LIBRARY HEADER RECORD!!!!!!!000000000000000000000000000000  ");

  /* Line 2*/
  blankCopy( file_header.sas_symbol1,  8,  "SAS      ");
  blankCopy( file_header.sas_symbol2,  8,  "SAS      ");
  blankCopy( file_header.saslib,       8,  "SASLIB   ");
  blankCopy( file_header.sasver,       8,  sasVer[0]     );
  zeroCopy ( file_header.sas_os,       8,  osType[0]     );
  blankFill( file_header.blanks,       24);
  blankCopy( file_header.sas_create,   16, cDate[0]      );

  /* Line 3 */
  blankCopy( file_header.sas_modified, 16, mdate[0]      );
  blankFill( file_header.blanks2,      64);

  /* Copy over for return */
  memcpy( raw_buffer, &file_header, sizeof(file_header) );

  /* Set size for return */
  raw_buffer_used = 240;

  return;
}


void fill_member_header(
			char **dfName,  /* Name of data set   */
  		        char **sasVer,  /* SAS version number */
			char **osType,  /* Operating System   */
			char **cDate,   /* Creation date      */
			char **mDate,   /* Modification date  */
			char **dfLabel, /* Label of data set  */
			char **dfType   /* Type of data set   */
			)
{
  struct MEMBER_HEADER member_header;

  /* Line 1 */
  blankCopy( member_header.l1, 80,  "HEADER RECORD*******MEMBER  HEADER RECORD!!!!!!!000000000000000001600000000140  ");

  /* Line 2 */
  blankCopy( member_header.l2, 80,  "HEADER RECORD*******DSCRPTR HEADER RECORD!!!!!!!000000000000000000000000000000  ");

  /* Line 3 */
  blankCopy( member_header.sas_symbol,   8,    "SAS      ");
  blankCopy( member_header.sas_dsname,   8,    dfName[0]  );
  blankCopy( member_header.sasdata,      8,    "SASDATA  ");
  blankCopy( member_header.sasver,       8,    sasVer[0]  );
  zeroCopy ( member_header.sas_osname,   8,    osType[0]  );
  blankFill( member_header.blanks,      24);
  blankCopy( member_header.sas_create,  16,    cDate[0]   );

  /* Line 4 */
  blankCopy( member_header.sas_modified,16,    mDate[0]   );
  blankFill( member_header.padding,     16);
  blankCopy( member_header.dslabel,     40,    dfLabel[0] );
  blankCopy( member_header.dstype,       8,    dfType[0]  );


  /* Copy over for return */
  memcpy( raw_buffer, &member_header, sizeof(member_header) );

  /* Set size for return */
  raw_buffer_used = 320;

  return;
}


void fill_namestr_header(
			 char **nvar    /* Number of variables as a zero filled  */
					/* character string of length 4          */
 )
{
  struct NAMESTR_HEADER namestr_header;

  blankCopy( namestr_header.l1,    54, "HEADER RECORD*******NAMESTR HEADER RECORD!!!!!!!000000");
  blankCopy( namestr_header.nvar,   4, nvar[0] );
  blankCopy( namestr_header.zeros, 22, "00000000000000000000  ");

  /* Copy over for return */
  memcpy( raw_buffer, &namestr_header, sizeof(namestr_header) );

  /* Set size for return */
  raw_buffer_used = 80;

  return;
}

void fill_namestr(
		  int  *isChar,             /* Bool: Is this a character varible   */
               // int  *nhfun,              /* HASH OF NNAME (always 0)            */
		  int  *nlng,               /* LENGTH OF VARIABLE IN OBSERVATION   */
		  int  *nvar0,              /* VARNUM                              */
		  char **nname,             /* NAME OF VARIABLE                    */
		  char **nlabel,            /* LABEL OF VARIABLE                   */

		  char **nform,             /* NAME OF FORMAT                      */
		  int  *nfl,                /* FORMAT FIELD LENGTH OR 0            */
		  int  *nfd,                /* FORMAT NUMBER OF DECIMALS           */
		  int  *nfj,                /* 0=LEFT JUSTIFICATION, 1=RIGHT JUST  */

	      //  char nfill[2],            /* (UNUSED, FOR ALIGNMENT AND FUTURE)  */

		  char **niform,            /* NAME OF INPUT FORMAT                */
		  int  *nifl,               /* INFORMAT LENGTH ATTRIBUTE           */
		  int  *nifd,               /* INFORMAT NUMBER OF DECIMALS         */
		  int  *npos                /* POSITION OF VALUE IN OBSERVATION    */

	      //  char rest[52],            /* remaining fields are irrelevant     */
		  )
{
  struct NAMESTR_RECORD namestr_record;

  namestr_record.ntype = (short) *isChar?2:1;      /* VARIABLE TYPE: 1=NUMERIC, 2=CHAR    */
  namestr_record.nhfun = (short) 0;                /* HASH OF NNAME (always 0)            */
  namestr_record.nlng  = (short) *nlng;            /* LENGTH OF VARIABLE IN OBSERVATION   */
  namestr_record.nvar0 = (short) *nvar0;           /* VARNUM                              */
  blankCopy(namestr_record.nname,   8, nname[0] ); /* NAME OF VARIABLE                    */
  blankCopy(namestr_record.nlabel, 40, nlabel[0]); /* LABEL OF VARIABLE                   */

  blankCopy(namestr_record.nform,   8, nform[0] ); /* NAME OF FORMAT                      */
  namestr_record.nfl   = (short) *nfl;             /* FORMAT FIELD LENGTH OR 0            */
  namestr_record.nfd   = (short) *nfd;             /* FORMAT NUMBER OF DECIMALS           */
  namestr_record.nfj   = (short) *nfj;             /* 0=LEFT JUSTIFICATION, 1=RIGHT JUST  */

  zeroFill(namestr_record.nfill, 2);               /* (UNUSED, FOR ALIGNMENT AND FUTURE)  */

  blankCopy(namestr_record.niform,  8, niform[0]); /* NAME OF INPUT FORMAT                */
  namestr_record.nifl  = (short) *nifl;            /* INFORMAT LENGTH ATTRIBUTE           */
  namestr_record.nifd  = (short) *nifd;            /* INFORMAT NUMBER OF DECIMALS         */
  namestr_record.npos  = (int)  *npos;             /* POSITION OF VALUE IN OBSERVATION    */

  zeroFill(namestr_record.rest, 52);               /* remaining fields are irrelevant     */


  TO_BIGEND_SHORT( namestr_record.ntype );
  TO_BIGEND_SHORT( namestr_record.nhfun );
  TO_BIGEND_SHORT( namestr_record.nlng  );
  TO_BIGEND_SHORT( namestr_record.nvar0 );
  TO_BIGEND_SHORT( namestr_record.nfl   );
  TO_BIGEND_SHORT( namestr_record.nfd   );
  TO_BIGEND_SHORT( namestr_record.nfj   );
  TO_BIGEND_SHORT( namestr_record.nifl  );
  TO_BIGEND_SHORT( namestr_record.nifd  );

  TO_BIGEND_INT  ( namestr_record.npos  );

  /* copy filled struct to return area */
  memcpy( raw_buffer, &namestr_record, sizeof(namestr_record) );

  /* Set size for return */
  raw_buffer_used = 140;

  return;
}


void fill_obs_header()
{
  struct OBS_HEADER obs_header;

  blankCopy( obs_header.l1, 80,
	     "HEADER RECORD*******OBS     HEADER RECORD!!!!!!!000000000000000000000000000000  ");

  /* copy filled struct to return area */
  memcpy( raw_buffer, &obs_header, sizeof(obs_header) );

  /* Set size for return */
  raw_buffer_used = 80;

  return;
}


void fill_numeric_field(
			double *value /* single numeric value */
			)
{
  /* convert to IBM floating point */

  /* first convert to big-endian layout */
  TO_BIGEND_DOUBLE( *value );

  /* now convert to ibm flaoting point format */
  ieee2ibm( (unsigned char *) raw_buffer, (unsigned char *) value, 1);

  //cnxptiee( (char *) value, 0, raw_buffer , 1 );

  /* Set size for return */
  raw_buffer_used = 8;

  return;
}


void fill_character_field(
			  char **value, /* single character string */
			  int *width    /* field width */
			  )
{
  /* copy to buffer */
  blankCopy(raw_buffer, *width, value[0]);

  /* Set size for return */
  raw_buffer_used = *width;

  return;
}

void fill_numeric_NA()
{
  static char numeric_NA[8] = {0x2e,0x00,0x00,0x00,0x00,0x00,0x00,0x00};

  memcpy(raw_buffer, numeric_NA, 8);
  raw_buffer_used = 8;

  return;
}

void fill_space(
		int *type, /* 0 --> zero fill, 1 --> space fill */
		int *width
		)
{
  /* fill the buffer as requested */
  if(*type)
    blankFill(raw_buffer, *width);
  else
    zeroFill(raw_buffer, *width);

  /* Set size for return */
  raw_buffer_used = *width;

  return;
}
