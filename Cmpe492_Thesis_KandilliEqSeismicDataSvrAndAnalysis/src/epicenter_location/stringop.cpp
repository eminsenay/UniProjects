/** Contains implementations of the functions of the stringop class. */

#include <string>
#include <math.h>
#include "stringop.h"

using namespace std;

/** Converts the given integer of given base to a string. */
string stringop::itoa(int value, int base) {
	return ltoa((long)value,base);
}

/** Converts the given long of given base to a string. */
string stringop::ltoa(long value, int base) {
	enum { kMaxDigits = 35 };
	std::string buf;
	
	buf.reserve( kMaxDigits ); // Pre-allocate enough space.
	// check that the base if valid
	if (base < 2 || base > 16) return buf;
	int quotient = value;
	// Translating number to string with base:
	do {
		buf += "0123456789abcdef"[ std::abs( quotient % base ) ];
		quotient /= base;
	} while ( quotient );
	// Append the negative sign for base 10
	if ( value < 0 && base == 10) buf += '-';
	std::reverse( buf.begin(), buf.end() );
	return buf;
}

/** Converts the given float to a string. Number of significant figures of the string value must be given. */
char* stringop::ftoa( double f, double sigfigs )
{
	char a[81];
	int prec, width, front;

	front = (f==0)? 1 : (int)log10(fabs(f))+1;
	if ( sigfigs < 1.0 && sigfigs >= 0.0 )  // fit number to tolerance
	{
		double rem = fabs(f) - int(f);
		prec=0;
		int num = (int)rem;
		while ( rem*pow(10,prec) - num > sigfigs )
			num = int(rem*pow(10,++prec));
		width = front;
		sprintf(a, "%#*.*f", width, prec, f );
	}
	else
	{
		if ( sigfigs < 2.0 ) sigfigs = 2.0;
         
		if ( front > (int)sigfigs )
		{
			sprintf( a, "%#.*e", (int)sigfigs-1, f );
		}
		else
		{
			prec = (int)sigfigs - front;
			if ( f==0.0 ) width = 2;
			else width = front + prec + 1;
			sprintf( a, "%#*.*f", width, prec, f );
		}
	}
	return strdup(a);
}
