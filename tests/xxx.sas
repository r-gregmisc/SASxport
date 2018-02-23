libname xxx xport '.\xxx.xpt';

data temp;
  input x y $ @@;
  cards;
    1 a
    2 B
    . .
    .a *
	-1 abcdefgh
  run;

data temp;
  set temp;
  format x date7.; label y='character variable';
  run;

proc print data=temp;
  format x y ;
  run;

proc print data=temp;
  run;

proc contents;
  run;

data xxx.abc;
  set;
  run;

options ls=132;
data _null_;
  infile 'xxx.xpt' recfm=f lrecl=80;
  input x $char80.;
  list;
  run;
