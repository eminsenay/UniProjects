#ifndef STRINGOP_H_
#define STRINGOP_H_
#include <string>
using namespace std;

/** This class is used for converting integers, long integers and floats to their string representations. */
class stringop
{
	public:
	
	/** Converts the given integer of given base to a string. */
	string itoa(int value, int base);
	/** Converts the given long of given base to a string. */
	string ltoa(long value, int base);
	/** Converts the given float to a string. Number of significant figures of the string value must be given. */
	char* ftoa( double f, double sigfigs );
};
#endif /*STRINGOP_H_*/
