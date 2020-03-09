Version 1.7.0 - 2020-03-08
--------------------------

Changes:

- Update for compatibility with R 4.0.0.


Version 1.6.0 -- 2018-02-23
---------------------------

Bug fixes:

- `write.xport()` no longer sets an 8 character minumum length on string
  variables.

Other changes:

- SAS-generated example xport files have been refreshed and some have modified
  to include string variables with less than 8 characters.  
- SAS code to generate all example datasets is now included.
- The manual page for the 'Alfalfa' dataset now properly attributes the 
  source of the data to Brian Yandell's book _Practical Data Analysis for
  Designed Experiments_.
- Minor improvements to settings for automatic code testing & test coverage.


Version 1.5.7 - 2018-02-03
--------------------------

- Add automated testing via TravisCI (for Linux) and AppVeyor (for Windows)
- Add code coverage info via CodeCov.io
- Update & fix badges in README.md
- Minor reformatting of README.md

Version 1.5.6 - 2018-02-02
--------------------------

- Remove package load message.

Version 1.5.5 - 2018-02-01
--------------------------

- Maintainer changed back to Gregory Warnes <greg@warnes.net>
- Integrated changes contributed by Mango Solutions (from
  https://github.com/mangothecat/SASxport)
- Updated SASxport package to work with Hmisc >= 4.1
- Code now hosted on github

Version 1.5.4 - 2016-03-25
--------------------------

Other changes:

- Updated nchar() calls to specify type="byte" for clarity.


Version 1.5.0 - 2014-07-21
--------------------------

Bug fixes:

- Now works properly on big-endian systems such as the PowerPC,
  Spark. (Reported by Brian Ripley )

- Explicitly cast left bit shifts to avoid undefined C language
  behavior. (Reported by Brian Ripley)

- Resolve problem in accessing "Hmisc::label.default<-" if
  SASxport::read.xport is called without loading SASxport.  (Reported
  by Dominic Comtois)

- 'read.xport' now preserves '$' at the beginning of SAS character
  format and iformat strings.  (Reported by Dominic Comtois)

- 'read.xport' argument names.tolower was not being honored for
   dataset names.  (Reported by Dominic Comtois)

Other changes:

- Modified several test files to display generated .xpt data so that
  issues can be more easily detected and diagnosed.

- C code cleanup and reorganization to improve clarity.


Version 1.4.0 - 2014-04-09
--------------------------

API Change:

- SASxport now relies on the 'label' methods defined by the Hmisc
  package instead of defining its own.

Bug fixes:

- The 'read.xport' and 'write.xport' functions were failing when both
  the SASxport and the Hmisc packages were loaded due to conflicts
  between the label methods defined by each package.  This has been
  resolved by removing the label methods from SASxport and using those
  from Hmisc instead.


Version 1.3.6 2013-10-09
------------------------

Bug fixes:

- In manual pages for read.xport() and lookup.xport(): Update URL for
  'test2.xpt', and use a local copy for executed example code.

Version 1.3.5 2013-06-14
------------------------

Bug fixes:

- read.xport() and write.xport() now properly handle empty
  dataset/dataframe objects.

Version 1.3.4 2013-05-31
------------------------

Bug fixes:

- Correct error in write.xport when a factor contains only NA entries.

Other Changes:

- Package test scripts now use a fixed timezone to prevent unhelpful warnings.

Version 1.3.2 2013-05-11
------------------------

New features:

- dataset label and type are now supported.  See write.xport() and
  read.xport() for examples.

Bug fixes:

- Integrate patch from foreign package to properly handle xport files
  with datasets that end exactly on an 80-byte record boundary & add
  corresponding test file.

- Replace file.path(path.package(...)) with system.file(...)

Changes:

- Remove obsolete .First.lib() function

- Replace file.path(path.package(...)) with system.file(...)

Version 1.3.1 2013-03-24
------------------------

Changes:

- Replace use of depreciated .path.package() with path.package() for R 3.0.0.

Version 1.3.0 2012-06-27
------------------------

New features:

- New function makeSASNames() to create valid and unique SAS names
  from character vectors.

Bug fixes:

- Improper handling of duplicates names in write.xport() was
  generating names longer than 8 characters, resulting in invalid
  files.  Corrected by using the new makeSASNames() function instead
  of the R make.names() function.


Version 1.2.4 2010-11-11
------------------------

Bug fixes:

- Fix bug in handling of 'as.is' argument to read.xport ('as.is=TRUE'
  was not operating as documented).


Version 1.2.3 2008-02-29
------------------------

Bug fixes:

- Fix typo in manual page for write.xport() reported by Yinlai Meng.


Version 1.2.2 2007-11-09
------------------------

Bug fixes:

-  Apply patches to fix problems on 64 bit platforms, as submitted by
   Brian Ripley.


Version 1.2.1 2007-11-05
-------------------------

Other:

- Correct warning message due to extraneous ';' characters after
  function closing braces.


Version 1.2.0 2007-11-01
-------------------------

New Features:

- SAS format and iformat information is now accessed via 'SASformat()'
  and 'SASiformat()' functions instead of 'formats' and 'iformat'.  The
  information accessed by these functions is now stored in attributes
  with the same name.  This avoids conflicts with the use of 'format'
  by chron objects.

- Copies of the code for foreign::read.xport and foreign::lookup.xport
  is now part of the SASxport package, permitting extension to these
  functions as needed, and removing the dependency on the foreign
  package.

- Overflow of SASxport numeric format values, which have a smaller
  range than IEEE 754 numeric values now standard,  now generates NAN
  instead of 0.0.


Bug Fixes:

- Fix for problem storing negative numbers.

- SAS format length and digit information is now properly captured
  by read.xport().  This is supported by an improved version of
  lookup.xport().

- SAS format information was not being properly utilized when more
  than one format was present.

- Improved handling of SAS date formats


Other:

- Test routines added to test handling of numeric values.


Version 1.1.1
-------------------------

-  Display support information at package startup


Version 1.1.0 -
-------------------------

New Features:

- Add support for auto-generation of SAS FORMAT information as a PROC
  CONTENTS fmtin= dataset.   This enables R factors to be handled
  properly on the receiving system.

Bug Fixes:


Other:

# 

Version 1.0.0
-------------

New Features:



Bug Fixes:



Other:




Beta 3 - 2007-08-10
-------------------

New features:

- read.xport's names.tolower argument now defaults to FALSE so that
  variable (and data set) names are now left as uppercase.

- Improved crediting of BRL-CAD source code

Bug fixes:

- Correct call to sprintf where printf was intended in src/ieee2ibm.c

Other:

- Augmented ieee2ibm code with corresponding ibm2ieee code for
  completeness.


Beta 2 - 2007-08-10
-------------------

New Features:

- Replaced IEEE to IBM translation code with GPL'ed version from BPL-CAD.

Bug Fixes:

- Changes to C code should correct the C99 usage errors

- Correct documentation typos, including those reported by Tim.


Beta 1 - 2007-08-10
-------------------

Initial version of the SASxport package.


