/** Contains implementations of the functions of the pickFilter class. */

#include <list>
#include <iostream>
#include "window.h"
#include "pickFilter.h"

using namespace std;

/** Deletes false picks in windows due to the noise in the data.
 *  The starting index of the pick is stored in a variable named ndxpk. 
 *  The time passed between two samples is stored in a variable named delta. Usually, delta is a value between 0.02 and 0.05.
 *  Data is hourly taken, so there are 3600/delta possible values of ndxpk.
 *  The probability of the starting time of the pick from two stations having same value is very low. 
 *  Therefore, the picks having same ndxpk value are considered as false picks and they are deleted from the pick window.
 *  Size: Length of the window array.
 */
void pickFilter::filterData(window windowList[], int size)
{
	for (int i = 0; i < size; i++)
	{
		int arr[100];
		for (int j = 0; j < 100; j++)
			arr[j] = 0;
		
		window *nextWindow = &(windowList[i]);
		list<long> *nextNdxpkList = &(nextWindow -> ndxpk);
		list<string> *nextPickList = &(nextWindow -> pickList);
		list<double> *nextTimeList = &(nextWindow -> timeList);
		list<long>::iterator theIterator;
		for( theIterator = nextNdxpkList -> begin(); theIterator != nextNdxpkList -> end(); theIterator++ ) 
		{
			//cout << *theIterator;
			arr[(*theIterator)%100]++;
		}
//		int max = -1;
//		int maxIndex = -1;
//		for (int j = 0; j < 100; j++)
//		{
//			if (arr[j] > max)
//			{
//				max = arr[j];
//				maxIndex = j;
//			}
//		}

		// Aynı ndxpk birden fazla varsa bu ndxpk ları sil
		for ( int j = 0; j <100; j ++ )
		{ 
			if ( arr[j] > 1 )
			{			
				list<long>::iterator ndxpkIterator;
				list<string>::iterator pickIterator;
				list<double>::iterator timeIterator;
				list<long>::iterator tempNdxpkIterator;
				list<string>::iterator tempPickIterator;
				list<double>::iterator tempTimeIterator;
				
				for( ndxpkIterator = nextNdxpkList -> begin(),pickIterator = nextPickList -> begin(),timeIterator = nextTimeList -> begin();
					ndxpkIterator != nextNdxpkList -> end(),pickIterator != nextPickList -> end(),timeIterator != nextTimeList -> end();
					ndxpkIterator++,pickIterator++,timeIterator++  )  
				{
					//cout << "ndxpkIterator: " << *ndxpkIterator << " pickIterator: " << *pickIterator << " maxIndex: " << maxIndex << endl;
					//cout << "ndxpk size "<< nextNdxpkList -> size() << endl;
					//cout << "pick size " << nextPickList -> size() << endl;
					if (*ndxpkIterator % 100 == j)
					{
						
						tempNdxpkIterator = ndxpkIterator;
						tempPickIterator = pickIterator;
						tempTimeIterator = timeIterator;
						nextNdxpkList -> erase(tempNdxpkIterator);
						nextPickList -> erase(tempPickIterator);
						nextTimeList -> erase(tempTimeIterator);
						ndxpkIterator--;
						pickIterator--;
						timeIterator--;						
					}
					// TODO EZN'yi sil
				}	
			}
			
		}
		
		
	}
} 

/** Deletes picks from given window list based on given sub-window size. 
 *  Normally, if one pick is received from one station at time t, all other picks of the same earthquake must be received at most at time t+x.
 *  This function takes the x value as sec parameter. 
 *  Based on this parameter, for each member of the given window list, it finds the sub-window of x seconds which has maximum number of picks. 
 *  After that, it deletes the picks which are not in this sub-window.
 *  size: The length of the window array.
 */
void pickFilter::filterWindow(window windowList[], int size, int sec) {
	
	for ( int i = 0; i < size; i ++ )
	{
		
		window *nextWindow = &(windowList[i]);
		list<long> *nextNdxpkList = &(nextWindow -> ndxpk);
		list<string> *nextPickList = &(nextWindow -> pickList);
		list<double> *nextTimeList = &(nextWindow -> timeList);
		list<long>::iterator ndxpkIterator;
		list<string>::iterator pickIterator;
		list<double>::iterator timeIterator;
		
		// Maximum sayida pick in hangi pickTime'a sahip eleman ile başladığını bul
		int maxpickInSubWindow = 0;
		list<double>::iterator maxTimeIterator = NULL;
		for( timeIterator = nextTimeList -> begin(); timeIterator != nextTimeList -> end();
				 timeIterator++ ) 
		{
			int picksInSubWindow = 0;
			list<double>::iterator tempTimeIterator;
			for( tempTimeIterator = nextTimeList -> begin(); tempTimeIterator != nextTimeList -> end();
				 tempTimeIterator++ ) 
			{
				if (*timeIterator + sec >= *tempTimeIterator && *timeIterator <= *tempTimeIterator)
				{
					picksInSubWindow++;
					if (i == 8)
					{
						cout << "timeIterator: " << *timeIterator << " sec: " << sec << " tempTimeIterator: " << *tempTimeIterator << endl;  
					}
				}
			}
			if (picksInSubWindow > maxpickInSubWindow)
			{
				maxpickInSubWindow = picksInSubWindow;
				maxTimeIterator = timeIterator;
			}
		}
		if ( maxTimeIterator != NULL )
			cout << "window: " << i << " " << "maxpickInSubWindow: " <<  maxpickInSubWindow << " maxTimeIterator: " << *maxTimeIterator << endl; 
		
		// Yukarda bulduğun maximum sayıda pick veren elemana göre pick listesini hazırla,
		// alakasız pickleri sil
		for( ndxpkIterator = nextNdxpkList -> begin(),pickIterator = nextPickList -> begin(),timeIterator = nextTimeList -> begin();
			ndxpkIterator != nextNdxpkList -> end(),pickIterator != nextPickList -> end(),timeIterator != nextTimeList -> end();
			ndxpkIterator++,pickIterator++,timeIterator++  ) 
		{
			if (*maxTimeIterator + sec < *timeIterator || *maxTimeIterator > *timeIterator)
			{
				list<long>::iterator tempNdxpkIterator;
				list<string>::iterator tempPickIterator;
				list<double>::iterator tempTimeIterator;
				
				tempNdxpkIterator = ndxpkIterator;
				tempPickIterator = pickIterator;
				tempTimeIterator = timeIterator;
				nextNdxpkList -> erase(tempNdxpkIterator);
				nextPickList -> erase(tempPickIterator);
				nextTimeList -> erase(tempTimeIterator);
				ndxpkIterator--;
				pickIterator--;
				timeIterator--;
			}
		}		
		
	}	

	
}
