#ifndef PICKFILTER_H_
#define PICKFILTER_H_
#include <list>
#include "window.h"

/** PickFilter class. It introduces some functions about filtering picks in windows. */
class pickFilter 
{
	public:
	/** Deletes false picks in windows due to the noise in the data. */
	void filterData (window windowList[], int size);
	/** Deletes picks from given window list based on given sub-window size. */
	void filterWindow(window windowList[], int size, int sec);
};
#endif /*PICKFILTER_H_*/
