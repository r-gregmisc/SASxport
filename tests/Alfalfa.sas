/*
This data is from Brian Yandell's book \emph{Practical Data Analysis
for Designed Experiments} and was downloaded from the available from
\url{http://pages.stat.wisc.edu/~yandell/pda/data/Alfalfa/alfalfa.dat}.
*/


data SPEC;
  infile DATALINES;
  length pop $3;
  input pop $ sample rep seedwt harv1 harv2;
  CARDS;
    min 0 1 64 171.7 180.3
    min 1 1 54 138.2 150.7
    min 2 1 40 145.6 129.1
    min 3 1 45 170.4 191.2
    min 4 1 64 124.8 172.6
    MAX 5 1 75 179.0 235.3
    MAX 6 1 45 166.3 173.9
    MAX 7 1 63 169.7 155.8
    MAX 8 1 65 192.9 177.6
    MAX 9 1 59 185.8 179.2
    min 0 2 59 158.8 139.7
    min 1 2 46 163.7 150.0
    min 2 2 42 120.6 131.1
    min 3 2 38 193.1 195.4
    min 4 2 54 171.5 167.6
    MAX 5 2 59 181.4 152.9
    MAX 6 2 60 165.3 167.5
    MAX 7 2 63 163.9 158.0
    MAX 8 2 70 152.5 150.2
    MAX 9 2 62 173.5 190.7
    min 0 3 60 147.9 164.9
    min 1 3 42 181.3 151.5
    min 2 3 35 124.3 134.4
    min 3 3 47 174.8 200.8
    min 4 3 59 167.8 178.3
    MAX 5 3 57 193.4 183.5
    MAX 6 3 60 150.7 147.1
    MAX 7 3 59 142.5 148.7
    MAX 8 3 59 176.4 204.8
    MAX 9 3 70 144.2 143.8
    min 0 4 61 148.4 168.8
    min 1 4 52 164.9 158.6
    min 2 4 43 141.2 158.1
    min 3 4 49 176.5 208.3
    min 4 4 60 177.5 137.1
    MAX 5 4 59 174.1 160.2
    MAX 6 4 48 155.5 185.8
    MAX 7 4 61 186.7 157.7
    MAX 8 4 64 162.4 179.4
    MAX 9 4 71 141.0 161.5
    ;
  run;


libname xportout xport '.\Alfalfa.xpt';
proc copy in=work out=xportout memtype=data;
  select SPEC;
run;
