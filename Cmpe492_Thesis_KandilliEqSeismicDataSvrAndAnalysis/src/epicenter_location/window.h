/** Window class. It is used for storing picks in a time interval. */
#ifndef WINDOW_H_
#define WINDOW_H_

#include <string>
#include <list>

using namespace std;

class window
{
	public:
	/** List of picks as they are seen on the output file (1). */
	list <string> pickList;
	/** List of picks in a comparable format. */
	list <double> timeList;
	/** List of pick start indices */
	list <long> ndxpk;
	/** Default constructor */
	window();
	/** Adds a new pick to the window. */
	void addPick(string newPick, double newPickTime, long newNdxpk); 
};

#endif /*WINDOW_H_*/
