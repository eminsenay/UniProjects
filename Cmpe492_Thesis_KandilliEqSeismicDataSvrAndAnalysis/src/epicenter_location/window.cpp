/** Contains implementations of the functions of the window class. */

#include "window.h"
#include <string>
#include <iostream>
#include <list>

using namespace std;

/** Default constructor */
window::window() {
}

/** Adds a new pick to the window. */
void window::addPick(string newPick, double newPickTime, long newNdxpk)
{
	ndxpk.push_back(newNdxpk);
	pickList.push_back(newPick);
	timeList.push_back(newPickTime);
}
