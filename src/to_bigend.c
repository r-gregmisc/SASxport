#include "writeSAS.h"

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>
#include <sys/types.h>

/* to_bigend: convert current host byte order to big endian */
void to_bigend( unsigned char *intp, size_t size)
{
  size_t i;
  unsigned char tmp;

  short twobytes = 0x0001;
  char  onebyte  = *(char*) &twobytes;

  /* Test if we are on a big endian or little endian platform */
  if (onebyte == 1)
   {
     /* Native byte order is little endian, so swap bytes */
     /* printf("Little Endian Machine!\n"); */

      for(i=0; i < size/2; i++)
        {
          tmp = (unsigned char) intp[i];
          intp[i] = intp[size-i-1];
          intp[size-i-1] = tmp;
        }
    }
  else
    {
      /* The native byte order is big endian, so do nothing */
      /* printf("Big Endian Machine!\n");  */
    }

  return;
}

/* test code */
long init_value(size_t value_sz, unsigned char *num_pattern)
  {
    long value = 0;
    for (size_t x = 0, ls = 0; x < value_sz; x++, ls += 8)
    {
        value += (long)num_pattern[value_sz - 1 - x] << ls;
    }
    return value;
  }

void test_to_bigend()
{
    
  unsigned char num_pattern[sizeof(long)];
  for (size_t x = 0; x < sizeof(long); x++)
    {
       num_pattern[x] = sizeof(long) - 1 - x;
    }

  unsigned char *byte_pattern = num_pattern + sizeof(long) - sizeof(unsigned char);
  unsigned char byte_value = init_value(sizeof byte_value, byte_pattern);

  unsigned char *short_pattern = num_pattern + sizeof(long) - sizeof(short);
  short   short_value      = init_value(sizeof short_value, short_pattern);

  unsigned char *int_pattern = num_pattern + sizeof(long) - sizeof(int);
  int     int_value        = init_value(sizeof int_value, int_pattern);

  unsigned char *long_pattern = num_pattern;
  long    long_value       = init_value(sizeof long_value, num_pattern);  
  /* Do the to_bigend, then test */

  /* byte */
  to_bigend( &byte_value, sizeof(unsigned char) );
  ASSERT( (unsigned char) *byte_pattern == byte_value );

  /* short */
  to_bigend( (unsigned char*) &short_value, sizeof(short) );
  ASSERT( *((short *) short_pattern) == short_value );

  /* int */
  to_bigend( (unsigned char*) &int_value, sizeof(int) );
  ASSERT( *((int *) int_pattern) == int_value );

  /* long */
  to_bigend( (unsigned char*) &long_value, sizeof(long) );
  ASSERT( *((long*) long_pattern) == long_value );

}

#ifdef DO_TEST
int main(int argc, char **argv)
{
  test_to_bigend();
}
#endif
