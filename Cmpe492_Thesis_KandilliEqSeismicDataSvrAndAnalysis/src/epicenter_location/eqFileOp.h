#ifndef EQFILEOP_H_
#define EQFILEOP_H_
#include <string>
using namespace std;

/** eqFileOp class. This class is about the seismic file operations.
 *  It can be used for extracting compressed seismic files and returning the names of the seismic files.
 */
class eqFileOp
{
	public:
	/** Extracts the compressed seismic files located in a given source directory. The destination directory is also given. */
	void extract (const char* sourceDir, const char* destinationDir, const char* type1, const char* type2);
	/** Returns an array of file names which are located in the given source directory. The number of elements in the array is also returned. */
	string* listFiles (const char* dirName, const char* type1, const char* type2, int& numberOfElements);
};

#endif /*EQFILEOP_H_*/
