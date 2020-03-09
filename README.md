# SASxport - Read and Write SAS XPORT Files

[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Linux Build Status](https://travis-ci.org/warnes/SASxport.svg)](https://travis-ci.org/warnes/SASxport)
[![Windows Build status](https://ci.appveyor.com/api/projects/status/github/warnes/SASxport?svg=true&passingText=Windows%20build%20-%20passing&pendingText=Windows%20build%20-%20pending&failingText=Windows%20build%20-%20failing)](https://ci.appveyor.com/project/warnes/SASxport)
[![](http://www.r-pkg.org/badges/version/SASxport)](http://www.r-pkg.org/pkg/SASxport)
[![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/SASxport)](http://www.r-pkg.org/pkg/SASxport)
[![Coverage Status](https://codecov.io/gh/warnes/SASxport/branch/master/graph/badge.svg)](https://codecov.io/gh/warnes/SASxport)

<!--- The current version of Pandoc used with RStudio doesn't handle this properly.  Try again in the next version. ---!>
<!--- [![Linux Build Status](https://img.shields.io/travis/warnes/SASxport.svg?label=Linux)](https://travis-ci.org/warnes/SASxport)
--->

This package provides functions for reading, listing
the contents of, and writing SAS xport format files.
The functions support reading and writing of either
individual data frames or sets of data frames.  Further,
a mechanism has been provided for customizing how
variables of different data types are stored.

## Installation

### From CRAN

```r
install.packages("SASxport")
```

### From GitHub 

```r
devtools::install_github("warnes/SASxport")
```

## Usage

```r
library(SASxport)
```

### Writing SAS XPORT files

`write.xport` writes one or more data frames into a SAS XPORT format
library file.

The function creates a SAS XPORT data file (see reference) from
one or more data frames.  This file format imposes a number of
constraints:
* Data set and variable names are truncated to 8 characters and
  converted to upper case.  All characters outside of the set
  A-Z, 0-9, and '\_' are converted to '\_'.
* Character variables are stored as characters.
* If `autogen.formats = TRUE` (the default), factor variables are
  stored as numeric with an appropriate SAS format
  specification. If `autogen.formats = FALSE`, factor variables
  are stored as characters.
* All numeric variables are stored as double-precision floating
  point values utilizing the IBM mainframe double precision
  floating point format (see the reference).
* Date and time variables are either converted to number of
  days since 1960-01-01 (date only), or number of seconds since
  1960-01-01:00:00:00 GMT (date-time variables).
* Missing values are converted to the standard SAS missing
  value `.`

The SAS XPORT format allows each dataset to have a label and a
type (set via the `label` and `SAStype` functions).  In addition,
each variable may have a corresponding label, display format, and
input format.  To set these values, add the attribute `label`,
`SASformat`, or `SASiformat` to individual data frame.  These
attributes may be set using the `label`, `SASformat`, and
`SASiformat` functions. (See examples in the package.)

The actual translation of R objects to objects appropriate for SAS
is handled by the `toSAS` generic and associated methods, which
can be (re)defined by the user to provide fine-grained control.

### Reading SAS XPORT files

`read.xport` reads a file as a SAS XPORT format library and returns a list
of data frames:
* SAS date, time, and date/time variables are converted
  respectively to `Date`, POSIX, or `chron` objects.
* SAS labels are stored in `label` attributes on each variable,
  and are accessible using the `label` function.
* SAS formats are stored in `SASformat` attributes on each
  variable, and are accessible using `SASformat`.
* SAS iformats are stored in `SASiformat` attributes on each
  variable, and are accessible using `SASiformat`.
* SAS integer variables are stored as integers unless
  `force.integer` is `FALSE`.

If the file includes the output of `PROC FORMAT CNTLOUT=`,
variables having customized label formats will be converted to
`factor` objects with appropriate labels.

If a datasets in the original file has a label or type, these will
be stored in the corresponding `label` and `SAStype` attributes,
which can be accessed by the `label` and `SAStype` functions.

## License

GPL 2.1 © Gregory R. Warnes, United States Government, Frank E. Harrell,
          Jr., Douglas M. Bates, Mango Solutions
