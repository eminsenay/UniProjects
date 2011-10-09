#ifndef EQDB_H_
#define EQDB_H_

#include <string>

using namespace std;
/** eqDb class. Functions located in this class constitute a part of the database module of the program.
 *  The other parts are called from bashScript files before the program is initialized. 
 */
class eqDb
{
	public:
	/** Inserts the earthquakes found by earthquake location algorithm to a database. */
	void insertLocation();
	/** Updates the database table startdates. Sets the successful value to 1 for a given hour. */
	void updateHour(string year, string month, string day, string hour);
};
#endif /*EQDB_H_*/
