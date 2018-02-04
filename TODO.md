# To-do List

## Tests
- Write test routines for very large files, particulary very large
  files with columns contiaining almost all missing values.
- Move variable attribute tests from dfAttributes.R to a new test file and
  (re-)enable SASformat and SASiformat tests.
- Convert .Rout.save tests to proper unit tests.
- Set locale to 'C' in test files so factor order doesn't come up in diffs.

## Features
- Enable and test code in makeSASNames.R to force ASCII and remove whitespace.
- Add support for v8 xport format files.

## Other
- Add Authors@R to encode authors and contributors.
