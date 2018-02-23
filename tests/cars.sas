DATA cars1;
  length MAKE $6;
  input MAKE $ PRICE MPG REP78 FOREIGN;
DATALINES;
AMC    4099 22 3 0
AMC    4749 17 3 0
AMC    3799 22 3 0
Audi   9690 17 5 1
Audi   6295 23 3 1
BMW    9735 25 4 1
Buick  4816 20 3 0
Buick  7827 15 4 0
Buick  5788 18 3 0
Buick  4453 26 3 0
Buick  5189 20 3 0
Buick 10372 16 3 0
Buick  4082 19 3 0
Cad.  11385 14 3 0
Cad.  14500 14 2 0
Cad.  15906 21 3 0
Chev.  3299 29 3 0
Chev.  5705 16 4 0
Chev.  4504 22 3 0
Chev.  5104 22 2 0
Chev.  3667 24 2 0
Chev.  3955 19 3 0
Datsun 6229 23 4 1
Datsun 4589 35 5 1
Datsun 5079 24 4 1
Datsun 8129 21 4 1
;
RUN;

PROC PRINT DATA=cars1(obs=5);
RUN;

PROC MEANS DATA=cars1;
RUN;

LIBNAME out XPORT './cars.xpt';

DATA out.cars;
  SET cars1;
RUN;

