#ifndef BASHSCRIPT_H_
#define BASHSCRIPT_H_
#include <string>

using namespace std;

/** bashScript class. It is used for copying the data from grid to the local computer. 
 *  It creates a bash command to copy the data. For example a command which is produced from this class can be as follows: 
 *  for i in `lfc-ls /grid/trgridd/kandilli/barbar.koeri.boun.edu.tr/wData/2007/05/20/12/`; do lcg-cp --vo trgridd lfn:/grid/trgridd/kandilli/barbar.koeri.boun.edu.tr/wData/2007/05/20/12/$i file:`pwd`/$i ; done 
 */
class bashScript
{
	public:
	/** Returns the bash command which can be used to copy the seismic data from the grid to a given directory name. */
	string getDataFiles(string destDir);
	/** Returns the bash command which can be used to copy the seismic data from the grid to a given directory name. */
	string getDataFiles(string destDir,string *dateList);
	/** Returns the current year, month, day and the hour before the current hour. */
	void getTime(string* dateList);
};
#endif /*BASHSCRIPT_H_*/
