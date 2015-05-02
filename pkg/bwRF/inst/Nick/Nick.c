#include <RFr3.h>
/* unif_rand */ 
static unsigned int I1, I2;      
void set_seed(unsigned int i1, unsigned int i2)
{
    I1 = i1; I2 = i2;
}
double unif_rand(void)
{
    I1= 36969*(I1 & 0177777) + (I1>>16);
    I2= 18000*(I2 & 0177777) + (I2>>16);
    return ((I1 << 16)^(I2 & 0177777)) * 2.328306437080797e-10; /* in [0,1) */
}

/* main function */
int main(){
    char xfile[120], yfile[120];
    int mdim=3500, nsample=140, m, n;
    int *ycl, nclass=2;
    double *x;
    FILE *xp, *yp;
	
    int ntree=5000, mtry=60, ndsize=1;
    int nbs=120, nreplace=1, mreplace=0, nrnodes;
    int its=0, nts=0, jints=0;
    double classwt[2]={0.5, 0.5}, xts=0;
	int nc[2]={70, 70}, Vote=3, wGini=1;
    int ilook=1, nlook=850;
    int iprox=0, iimp=0, ikeepft=0;
	
    double *counttr;
    int *out;
    double countts=0, prox=0;
    double tmiss[2], tmissimp=0, diffmarg=0;
    double *minbgini, *moobgini;
    int *treemap, *bestvar;
    double *xbestsplit;
    int *nodeclass, *nodestatus;
	
    /* sample information input: x, y   */
    printf("File name for input x data: ");
    scanf("%s", xfile);
    printf("File name for input y data: ");
    scanf("%s", yfile);
	
    xp = fopen(xfile, "r");
    if( xp == NULL )  error( "File can't be opened! \n" );
    yp = fopen(yfile, "r");
    if( yp == NULL )  error( "File can't be opened! \n" );
	
    x = (double *) calloc(mdim*nsample, sizeof(double));
    ycl = (int *) calloc(nsample, sizeof(int));
	    
    while(!feof(xp)){
    	for(m=0; m < mdim; m++){
        	for(n=0; n < nsample; n++){
                fscanf(xp, "%lf", x + n*mdim + m);
			}
		}
	}
    fclose(xp);
    
    while(!feof(yp)){
        for(n=0; n < nsample; n++){
            fscanf(yp, "%d", ycl+n);
        }
    }
    fclose(yp);
	
    counttr = (double *) calloc(nclass*nsample, sizeof(double));
    out = (int *) calloc(nsample, sizeof(int));
    
    minbgini = (double *) calloc(mdim, sizeof(double));
    moobgini = (double *) calloc(mdim, sizeof(double));
    
    nrnodes = 2*nsample/ndsize + 1;
    treemap  = (int *) calloc(2*nrnodes, sizeof(int));
    bestvar  = (int *) calloc(nrnodes, sizeof(int));
    xbestsplit = (double *) calloc(nrnodes, sizeof(double));
    nodeclass  = (int *) calloc(nrnodes, sizeof(int));
    nodestatus = (int *) calloc(nrnodes, sizeof(int));
    
	set_seed(123, 45);
	/*
	 printf("%lf \n", unif_rand());
	 printf("%lf \n", Rf_beta(5.6, 3.9));
	*/
	
    bw_RF(ycl, &nclass, nc, classwt, &Vote,
          x,   &mdim,   &nsample,
          &mtry,  &ntree,  &ndsize,
		  &nbs,   &nreplace,  &mreplace,
          &its,   &xts,    &nts,    &jints,
          &ilook, &nlook,
          &iprox, &iimp,   &ikeepft,
          counttr, out,    &countts,
          &prox,   tmiss,
		  &tmissimp,  &diffmarg,
		  minbgini,	  moobgini,  &wGini,
          treemap,    bestvar,   xbestsplit,  nodeclass,  nodestatus
          );
    
    system("PAUSE");
    return 1;
	
}
