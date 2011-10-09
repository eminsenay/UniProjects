#ifndef SAC_H_
#define SAC_H_
#include <string>
#include "window.h"
using namespace std;

/** sac header struct. Used while reading a SAC file. */
struct sac_header {
	float	delta,     depmin,    depmax,    scale,     odelta;    
	float	b,         e,         o,         a,         internal1; 
	float	t0,        t1,        t2,        t3,        t4;        
	float	t5,        t6,        t7,        t8,        t9;        
	float	f,         resp0,     resp1,     resp2,     resp3;     
	float	resp4,     resp5,     resp6,     resp7,     resp8;     
	float	resp9,     stla,      stlo,      stel,      stdp;      
	float	evla,      evlo,      evel,      evdp,      unused1;   
	float	user0,     user1,     user2,     user3,     user4;     
	float	user5,     user6,     user7,     user8,     user9;     
	float	dist,      az,        baz,       gcarc,     internal2; 
	float	internal3, depmen,    cmpaz,     cmpinc,    unused2;   
	float	unused3,   unused4,   unused5,   unused6,   unused7;   
	float	unused8,   unused9,   unused10,  unused11,  unused12;  
	long	nzyear,    nzjday,    nzhour,    nzmin,     nzsec;     
	long	nzmsec,    internal4, internal5, internal6, npts;      
	long	internal7, internal8, unused13,  unused14,  unused15;  
	long	iftype,    idep,      iztype,    unused16,  iinst;     
	long	istreg,    ievreg,    ievtyp,    iqual,     isynth;    
	long	unused17,  unused18,  unused19,  unused20,  unused21;  
	long	unused22,  unused23,  unused24,  unused25,  unused26;  
	long	leven,     lpspol,    lovrok,    lcalda,    unused27;  
	char	kstnm[8],  kevnm[16];           
	char	khole[8],  ko[8],     ka[8];               
	char	kt0[8],    kt1[8],    kt2[8];              
	char	kt3[8],    kt4[8],    kt5[8];              
	char	kt6[8],    kt7[8],    kt8[8];              
	char	kt9[8],    kf[8],     kuser0[8];           
	char	kuser1[8], kuser2[8], kcmpnm[8];           
	char	knetwk[8], kdatrd[8], kinst[8];            
};

/** Empty sac header struct. All members are initialized to a value which shows that it is null */	
static struct sac_header sac_null = {
	-12345., -12345., -12345., -12345., -12345.,
	-12345., -12345., -12345., -12345., -12345.,
	-12345., -12345., -12345., -12345., -12345.,
	-12345., -12345., -12345., -12345., -12345.,
	-12345., -12345., -12345., -12345., -12345.,
	-12345., -12345., -12345., -12345., -12345.,
	-12345., -12345., -12345., -12345., -12345.,
	-12345., -12345., -12345., -12345., -12345.,
	-12345., -12345., -12345., -12345., -12345.,
	-12345., -12345., -12345., -12345., -12345.,
	-12345., -12345., -12345., -12345., -12345.,
	-12345., -12345., -12345., -12345., -12345.,
	-12345., -12345., -12345., -12345., -12345.,
	-12345., -12345., -12345., -12345., -12345.,
	-12345, -12345, -12345, -12345, -12345,
	-12345, -12345, -12345, -12345, -12345,
	-12345, -12345, -12345, -12345, -12345,
	-12345, -12345, -12345, -12345, -12345,
	-12345, -12345, -12345, -12345, -12345,
	-12345, -12345, -12345, -12345, -12345,
	-12345, -12345, -12345, -12345, -12345,
	-12345, -12345, -12345, -12345, -12345,
	{ '-','1','2','3','4','5',' ',' ' },
	{ '-','1','2','3','4','5',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ' },
	{ '-','1','2','3','4','5',' ',' ' }, { '-','1','2','3','4','5',' ',' ' },
	{ '-','1','2','3','4','5',' ',' ' }, { '-','1','2','3','4','5',' ',' ' },
	{ '-','1','2','3','4','5',' ',' ' }, { '-','1','2','3','4','5',' ',' ' },
	{ '-','1','2','3','4','5',' ',' ' }, { '-','1','2','3','4','5',' ',' ' },
	{ '-','1','2','3','4','5',' ',' ' }, { '-','1','2','3','4','5',' ',' ' },
	{ '-','1','2','3','4','5',' ',' ' }, { '-','1','2','3','4','5',' ',' ' },
	{ '-','1','2','3','4','5',' ',' ' }, { '-','1','2','3','4','5',' ',' ' },
	{ '-','1','2','3','4','5',' ',' ' }, { '-','1','2','3','4','5',' ',' ' },
	{ '-','1','2','3','4','5',' ',' ' }, { '-','1','2','3','4','5',' ',' ' },
	{ '-','1','2','3','4','5',' ',' ' }, { '-','1','2','3','4','5',' ',' ' },
	{ '-','1','2','3','4','5',' ',' ' }
};

/** sac class. Used in operations related to SAC data. */	
class sac
{
	public:
	/** Reads the input parameters from the given input file and calculates the pick time */
	void calculatePickValue(string fileName, window windowList[], int windowSec, 
			int windowSlideSec);
	/** This function calculates the time (year, day of year, hour, minutes, seconds and milliseconds) of the pick.*/
	void calculatePickTime(long nzyear, long nzjday, long nzhour,
							long nzmin, long nzsec, long nzmsec, 
							long ndxpk, float delta,
							int windowNumber, int windowSize, window windowList[]); 
	/** Given the window size (in seconds) and the amount of time between two successive windows (in seconds), this function sets the appropriate index values of both. */
	void setWindow(int windowSec, int windowSlideSec);
	/** Calculates and returns the length of the window array. */
	int  getWindowListSize(int windowSlideSec);
	/** Creates the header for input file of the earthquake location algorithm. */
	void createHypoHeader(std::ofstream& out);
	/** Creates the footer for input file of the earthquake location algorithm. */
	void createHypoFooter(std::ofstream& out);
	/** Reads the SAC file and initializes necessary parameters which will be used in other functions. */
	void readFile(string fileName);
	/** Calls HYP02d fortran function. This function is used for locating the earthquake. */
	void callHYP02d();
	
	private:
	
	/** Takes the year and the day of the year (for example 101), and returns the month which contains this day of the year. */
	int calculateMonth(int year, int &day);
	/** Calls aPicker fortran function. This function is used for finding the pick, i.e. starting point of the earthquake in the SAC data. */
	void callAPicker(float *tempData, float windowSize);
	/** Takes the number and number of digits as input. 
 	 *  If it is necessary, it adds some zeros to the left side of the number to make the number appear as the desired number of digits and returns the formatted output as string.
 	 */
	string formattedString(int number, int digits);
};

/* defines for logical data types */
#define TRUE    1
#define FALSE   0

/* defines for enumerated data types */
#define IREAL   0 
#define ITIME   1 
#define IRLIM   2 
#define IAMPH   3 
#define IXY     4 
#define IUNKN   5 
#define IDISP   6 
#define IVEL    7 
#define IACC    8 
#define IB      9 
#define IDAY   10 
#define IO     11 
#define IA     12 
#define IT0    13 
#define IT1    14 
#define IT2    15 
#define IT3    16 
#define IT4    17 
#define IT5    18 
#define IT6    19 
#define IT7    20 
#define IT8    21 
#define IT9    22 
#define IRADNV 23 
#define ITANNV 24 
#define IRADEV 25 
#define ITANEV 26 
#define INORTH 27 
#define IEAST  28 
#define IHORZA 29 
#define IDOWN  30 
#define IUP    31 
#define ILLLBB 32 
#define IWWSN1 33 
#define IWWSN2 34 
#define IHGLP  35 
#define ISRO   36 
#define INUCL  37 
#define IPREN  38 
#define IPOSTN 39 
#define IQUAKE 40 
#define IPREQ  41 
#define IPOSTQ 42 
#define ICHEM  43 
#define IOTHER 44 
#define IGOOD  45 
#define IGLCH  46 
#define IDROP  47 
#define ILOWSN 48 
#define IRLDTA 49 
#define IVOLTS 50 
#define INIV51 51 
#define INIV52 52 
#define INIV53 53 
#define INIV54 54 
#define INIV55 55 
#define INIV56 56 
#define INIV57 57 
#define INIV58 58 
#define INIV59 59 
#define INIV60 60

#define TEST "%12.5f%12.5f%12.5f%12.5f%12.5f\n"
#define FCS "%15.7f%15.7f%15.7f%15.7f%15.7f\n"
#define ICS "%10d%10d%10d%10d%10d\n"
#define CCS1 "%-8.8s%-8.8s%-8.8s\n"
#define CCS2 "%-8.8s%-16.16s\n"


#endif /*SAC_H_*/
