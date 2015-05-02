#include <stdio.h>
#include <R.h>
#include <Rmath.h>
// #define MATHLIB_STANDALONE

int main()
{
	double a;

	// a = Rf_lchoose(100.000, 50.0);
	a = lchoose(100.000, 50.0);
	printf("%lf \n", a);

	system("PAUSE");
    return 1;
}
