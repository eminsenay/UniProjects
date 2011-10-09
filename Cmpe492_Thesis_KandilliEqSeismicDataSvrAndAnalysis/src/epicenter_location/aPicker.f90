
subroutine aPick(arry,nlen,delta,ndxst,cAry,ndxpk,nlncda,itype,iqual,updwn)

!========================================================
!INPUT PARAMETERS:
!			arry(nlen)	: Input array to process
!			nlen		: Lenght of input array
!			delta		: Sampling interval, seconds
!			ndxst		: Index in array to start search
!========================================================
!OUTPUT PARAMETERS:
!			ndxpk		: Index in array of a valid arrival pick (=0 if no Pick)
!			nlncda	: Length of event in samples (duration) (=0 if not found)
!			itype		: Type of arrival (0:impulsive,  1:emergent
!			updwn		: Direction of first motion (0: none, 1 UP, 0.5 UP critical
!													-1: Down, -0.5 Down critical
!			iqual		: Quality of pick (1,2,3,4 for best to worst)
!========================================================
!*    KTYPE:   Type of arrival [char*1]
!*             ='I' for impulsive.
!*             ='E' for emergent.
!*    KDIR:    Direction of first motion [char*1].
!*             ='U' or '+' for up.
!*             ='D' or '-' for down.
!*             =' ' for undeterminable.
!*    KQUAL:   Quality of pick [char*1].
!*             ='0' to '3' for best to worst.
!========================================================


	!integer,	intent(in)	::ndxst,nlen
	!real,		intent(in)	::delta,arry(nlen),cAry(14)
	real,		intent(in)	::arry(nlen),cAry(14)

	integer,	intent(out)	::ndxpk,nlncda,itype,iqual
	real,		intent(out)	::updwn

	character*1 ktype,kdir,kqual
	integer	I3,I4,I6
	real	C1,C2,C3,C4,C5,C6,C7,C8,D5,D8,D9

	common /cAarry/ C1,C2,C3,C4,C5,C6,C7,C8,D5,D8,D9,I3,I4,I6

	C1 = cAry(1)
	C2 = cAry(2)
	C3 = cAry(3)
	C4 = cAry(4)
	C5 = cAry(5)
	C6 = cAry(6)
	C7 = cAry(7) 
	C8 = cAry(8)
	D5 = cAry(9)
	D8 = cAry(10)
	D9 = cAry(11) 
	I3 = INT(cAry(12)) 
	I4 = INT(cAry(13))
	I6 = INT(cAry(14))
!Emin Soner tarafından patch başlangıç
	nlen = cAry(15)
	delta= cAry(16)
	ndxst = cAry(17)
!Emin Soner tarafından patch bitti


!	C1 = 0.985 ,	C2 = 3.0 ,	C3 = 0.6 ,	C4 = 0.03 ,	C5 = 5.0 ,	C6 = 0.0039 
!	C7 = 100.  ,	C8 =-0.1 ,	D5 = 2.0 ,	D8 = 3.0  ,	D9 = 1.0 ,	I3 = 3 
!	I4 = 40    ,	I6 = 3 

!	Try to detect a valid pick.
!	write(*,*) C1
!	write(*,*) I6
!	write(*,*) nlen
!	write(*,*) delta
!	write(6,*) arry(1)
!	write(*,*) ndxst
!	write(*,*) ndxpk
!	write(*,*) nlncda 
!	write(*,*) itype
!	write(*,*) iqual
!	write(*,*) updwn

        call pkdet(arry,nlen,delta,ndxst,ndxpk)	

!	If a valid pick was detected:
        if(ndxpk.gt.0)then

!			Characterize the pick as to quality and direction of first motion.
            call pkchar(arry,nlen,delta,ndxpk,ktype,kdir,kqual)		
!            kpwave=ktype//'P'//kdir//kqual
			
			if (ktype .eq. 'I') itype=0
			if (ktype .eq. 'E') itype=1
			
			if (kdir .eq. 'U') updwn= 1.0
			if (kdir .eq. '+') updwn= 0.5
			if (kdir .eq. ' ') updwn= 0.0
			if (kdir .eq. '-') updwn=-0.5
			if (kdir .eq. 'D') updwn=-1.0

			if (kqual .eq. '0') iqual = 1
			if (kqual .eq. '1') iqual = 2
			if (kqual .eq. '2') iqual = 3
			if (kqual .eq. '3') iqual = 3

			nlncda=0

!			Evaluate the pick, determining duration, maximum amplitudes, etc.
!			call pkeval(arry,nlen,delta,ndxpk,nlncda)

        endif	
	
end subroutine aPick

!*******************************************************************

subroutine pkdet(array,ndxmx,si,ndxst,ndxpk)
!*=====================================================================
!* PURPOSE: To detect a valid arrival pick.
!*=====================================================================
!* INPUT ARGUMENTS:
!*    ARRAY:   Array containing the trace.
!*    NDXMX:   Length of ARRAY.
!*    SI   :   Sampling interval, seconds
!*    NDXST:   Index in array to start search.
!*=====================================================================
!* OUTPUT ARGUMENTS:
!*    NDXPK:   Index in array of a valid arrival pick.
!*             Set to zero if no pick was found.
!*=====================================================================
		integer ndxmx,ndxst,ndxpk
		real	array(ndxmx),si

		logical lfzc
		integer ndx,ndxend,mzc,nlzc,nsszc,ndxfzc,msszc
		real	diff,rdat,rold,eabs,esta,elta,edat,eref,eold
		real	rbig,tmax,ecrit,crtinc,rlast

		common /cAarry/ C1,C2,C3,C4,C5,C6,C7,C8,D5,D8,D9,I3,I4,I6


!* - Initialize operating parameters and flags.

		ndxpk=0
		i5=d5/si+1
		i9=d9/si+1

!* - Initialize the characteristic function and its averages.
	
		ndx=ndxst
		diff=array(ndx)
		rdat=0.
		eabs=0.
		esta=0.
		elta=0.
		edat=0.
		ndxend=ndx+i9-1
		if(ndxend.gt.ndxmx)ndxend=ndxmx
	
		do while (ndx.le.ndxend)
! 1000	if(ndx.le.ndxend)then
			rold=rdat
			call pkfilt(diff,rold,rdat,eabs)
			call pkfunc(rold,rdat,esta,elta,edat)
			ndx=ndx+1
			diff=array(ndx)-array(ndx-1)
!			go to 1000
		end do
		eref=C5*elta
		ndx=ndxend
 2000	if(ndx.lt.ndxmx)then				! Main loop on each data point:
			ndx=ndx+1
			diff=array(ndx)-array(ndx-1)	! High pass the data to remove any mean.
			eold=eref
			rold=rdat
			call pkfilt(diff,rold,rdat,eabs)

			! Compute characteristic function and its short and long term averages.
			call pkfunc(rold,rdat,esta,elta,edat)

! A pick is made when the ratio of the short term average to the
! long term average reaches a certain value.

			eref=C5*elta	! Validate the pick:

			if(eabs.le.C7 .and. esta.ge.eref)then

! Set up reference values and flags used in validation phase.

				ndxpkq=ndx
				rbig=amax1(eabs,abs(diff/3.))
				tmax=abs(rdat)
				lfzc=.true.
				ecrit=eold
				crtinc=eref/50000.
				rlast=rdat
				mzc=1
				nlzc=0
				nsszc=0

 5000			if(ndx.lt.ndxmx)then	! For each data point during validation phase:
					ndx=ndx+1			! Filter data and compute characteristic function averages.
					diff=array(ndx)-array(ndx-1)
					rold=rdat
					call pkfilt(diff,rold,rdat,eabs)
					call pkfunc(rold,rdat,esta,elta,edat)

			! Check for large amplitude zero crossings.
					if(abs(rdat).ge.rbig .and. sign(rdat,rlast).ne.rdat)then
						nlzc=nlzc+1
						rlast=rdat
					endif
					if(lfzc)	tmax=amax1(tmax,abs(rdat))

			! Check for zero crossings (large or small)
					if(sign(rdat,rold).ne.rdat)then
						mzc=mzc+1
						ecrit=ecrit+crtinc

					! Increment or zero the successive small zero crossing counter.

						if(esta.gt.ecrit)then
							nsszc=0
						else
							nsszc=nsszc+1
						endif

					! Adjust large zero crossing amplitude at first zero crossing.

						if(lfzc)then
							rbig=amax1(rbig,tmax/3.0)
							ndxfzc=ndx
							lfzc=.false.
						endif
						msszc=C3+mzc/C3

					!* ----- The validation phase is over when the number of zero crossings
					!*       or the number of successive small zero crossings reach certain
					!*       values.  The pick is declared to be a valid event and the
					!*       routine terminates if the number of large zero crossings and
					!*       the event length have both reached certain values.  If the pick
					!*       does not satisfy these criteria, the algorithm continues
					!*       the top and continues its search.

						if(mzc.ge.I4 .or. nsszc.ge.msszc)then
							if( (nlzc.ge.I6) .and.((mzc.ge.I4) .or. &
									& ((ndx-ndxpkq).ge.I5)) )then

								ndxpk=ndxpkq
								return
							else
								go to 2000
							endif
						endif
					endif

				! Loop back during validation phase.

					go to 5000
				endif
			endif

			! Loop back during search phase.

			go to 2000
		endif

	return

end subroutine pkdet



subroutine pkchar(array,ndxmx,si,ndxpk,ktype,kdir,kqual)
!*=====================================================================
!* PURPOSE: To characterize the quality and sense of motion of a valid pick.
!*=====================================================================
!* INPUT ARGUMENTS:
!*    ARRAY:   Array containing the trace.
!*    NDXMX:   Length of ARRAY.
!*    SI:      Sampling interval, seconds.
!*    NDXPK:   Index of valid pick in ARRAY.
!*=====================================================================
!* OUTPUT ARGUMENTS:
!*    KTYPE:   Type of arrival [char*1]
!*             ='I' for impulsive.
!*             ='E' for emergent.
!*    KDIR:    Direction of first motion [char*1].
!*             ='U' or '+' for up.
!*             ='D' or '-' for down.
!*             =' ' for undeterminable.
!*    KQUAL:   Quality of pick [char*1].
!*             ='0' to '3' for best to worst.
!*=====================================================================
!* SUBROUTINES CALLED:
!*			   PKFILT
!*=====================================================================
!* LOCAL VARIABLES:
!*    AMPMX:   Maximum amplitude store for current half cycle. [f]
!*    BACKLV:  Measure of background noise level prior to pick. [f]
!*    DIFF:    First difference at current data point. [f]
!*    DIFFJ:   First difference used to calculate direction. [f]
!*    FAC:     Scale factor used in determining sense of motion. [f]
!*    FDNEW:   Current filtered data value. [f]
!*    FDOLD:   Previous filtered data value. [f]
!*    FDPK:    Filtered data value at pick. [f]
!*    PEAKS:   Array of absolute values of first three peaks. [fa]
!*    NDX:     Index of current data point being analyzed. [i]
!*    NPEAKS:  Number of current entries in PEAKS. [i]
!*    RBCKLV:  Reciprocal of BACKLV. [f]
!*    RMNABS:  Running mean absolute value of filtered data. [f]
!*    XON:     Scaled pick value used to estimate quality of pick. [f]
!*    XP1:     Scaled first peak used to estimate quality of pick. [f]
!*    XP2:     Scaled second peak used to estimate quality of pick. [f]
!*    XP3:     Scaled third peak used to estimate quality of pick. [f]
!*=====================================================================

	integer ndxmx,ndxpk
    real	array(ndxmx),si

	integer npeaks,ndx,n,j,iqual
    real	peaks(4), amp(0:3)
    real	diff,diffpk,diffj,ampmx
    real	fdnew,fdold,rmnabs,backlv,fdpk,fac
    real	xon,xp1,xp2,xp3

	common /cAarry/ C1,C2,C3,C4,C5,C6,C7,C8,D5,D8,D9,I3,I4,I6

    character*1 kdir,ktype,kqual,kaqual(0:3)

	data amp/4*0./
    data kaqual/'0','1','2','3'/

!* PROCEDURE:

!* - Compute the background noise level just before the pick.

	ndx=1
	diff=array(ndx)
	fdnew=0.0
	rmnabs=0.0

! 2000 continue

	do while (ndx.le.ndxpk) 
!	if(ndx.le.ndxpk)then
		fdold=fdnew
        call pkfilt(diff,fdold,fdnew,rmnabs)
        ndx=ndx+1
        diff=array(ndx)-array(ndx-1)
!        go to 2000
!	endif
	end do

	backlv=1.6*rmnabs
	fdpk=fdnew

!* - Compute direction of first motion.

	rbcklv=1./backlv
	diffpk=array(ndxpk)-array(ndxpk-1)
	n=1
	j=ndxpk+1

 3000  continue

	diffj=array(j)-array(j-1)

	if((diffpk*diffj).le.0.)then
		if(n.eq.1)then
			kdir=' '
        elseif(diff.gt.0.)then
			kdir='+'
			if(n.gt.3)kdir='U'
			fac=abs(array(ndxpk)-array(j-1))*rbcklv
			if(fac.gt.4.)kdir='U'
        else
			kdir='-'
			if(n.gt.3)kdir='D'
			fac=abs(array(ndxpk)-array(j-1))*rbcklv
			if(fac.gt.4.)kdir='D'
        endif
	else
        j=j+1
        n=n+1
        go to 3000
	endif

!* - Determine the absolute value of the first three peaks in the signal.

	ndx=ndxpk+1
	diff=array(ndx)-array(ndx-1)
	fdnew=fdpk
	ampmx=abs(fdnew)
	npeaks=0

 4000 continue
 
	if(ndx.le.ndxmx .and. npeaks.lt.3)then
		fdold=fdnew
        call pkfilt(diff,fdold,fdnew,rmnabs)
        ampmx=amax1(ampmx,abs(fdnew))
        
		if(sign(fdnew,fdold).ne.fdnew)then
			npeaks=npeaks+1
			peaks(npeaks)=ampmx
			ampmx=0.
        endif

        ndx=ndx+1
        diff=array(ndx)-array(ndx-1)
        go to 4000
	endif

!* - Compute quality based on size of first 3 peaks and first difference of signal at pick.

	if(peaks(1).gt.abs(array(ndxpk)))then
        xp1=peaks(1)*rbcklv
        xp2=peaks(2)*rbcklv
        xp3=peaks(3)*rbcklv
	else
        xp1=peaks(2)*rbcklv
        xp2=peaks(3)*rbcklv
        xp3=peaks(4)*rbcklv
	endif

	xon=abs(diffpk)*rbcklv

	if((xp1.gt.4.).and.(xp2.gt.6.0 .or. xp3.gt.6.0) .and. & 
					& (xon.gt.0.5).and.(peaks(1).gt.amp(0))) then
          iqual=0

	elseif((xp1.gt.3.) .and. (xp2.gt.3. .or. xp3.gt.3.) .and. &
					& (xon.gt.0.5) .and. (peaks(1).gt.amp(1))) then
          iqual=1

	elseif((xp1.gt.2.) .and. (xon.gt.0.5) .and. (peaks(1).gt.amp(2))) then
          iqual=2

	else
          iqual=3
	endif

	if((kdir.eq.'U' .or. kdir.eq.'D') .and. iqual.gt.0) iqual=iqual-1
	kqual=kaqual(iqual)

! Compute type of arrival based upon quality of pick.

	if(iqual.le.1)then
        ktype='I'
	else
        ktype='E'
	endif

end subroutine pkchar

!*=====================================================================

subroutine pkfilt(diff,fdold,fdnew,rmnabs)
!*=====================================================================
!* PURPOSE: To filter (high pass) trace data for picking module.
!*          The running mean absolute value of the filtered data is
!*          also returned.
!*=====================================================================
!*=====================================================================
!* INPUT ARGUMENTS:
!*    DIFF:    First difference (current point - last point). [f]
!*    FDOLD:   Last value of filtered data. [f]
!*=====================================================================
!* OUTPUT ARGUMENTS:
!*    FDNEW:   Current value of filtered data. [f]
!*    RMNABS:  Running mean absolute value of filtered data. [f]
!*=====================================================================
!* GLOBAL INPUT:
!*    EAM:     C1, C4(?)
!*=====================================================================

	common /cAarry/ C1,C2,C3,C4,C5,C6,C7,C8,D5,D8,D9,I3,I4,I6

!* - Compute new value of filtered (high pass) data.
	fdnew=diff+ C1 * fdold	
!* - Compute the running mean absolute value of the filtered data.
	rmnabs = rmnabs + C6*(abs(fdnew)-rmnabs)	

end subroutine pkfilt

!*=====================================================================


subroutine pkfunc(fdold,fdnew,chfsta,chflta,chf)
!*=====================================================================
!* PURPOSE: To calculate characteristic function and its averages
!*          by automatic picker.
!*=====================================================================
!* INPUT ARGUMENTS:
!*    FDOLD:   Old (last) value of filtered trace. [f]
!*    FDNEW:   New (current) value of filtered trace. [f]
!*    CHFSTA:  Old short term average of characteristic function. [f]
!*    CHFLTA:  Old long term average of characteristic function. [f]
!*=====================================================================
!* OUTPUT ARGUMENTS:
!*    CHFSTA:  New short term average. [f]
!*    CHFLTA:  New long term average. [f]
!*    CHF:     New value of characteristic function. [f]
!*=====================================================================
!* GLOBAL INPUT:
!*    EAM:     C2, C3, C5(?)
!*=====================================================================

	common /cAarry/ C1,C2,C3,C4,C5,C6,C7,C8,D5,D8,D9,I3,I4,I6

      fdfd   = fdnew-fdold			!* - Compute first difference of filtered data.
      chf    = fdnew**2 + C2*fdfd**2   !* - Compute characteristic function.
      chfsta = chfsta + C3*(chf-chfsta)!* - Compute the short term average.
      chflta = chflta + C4*(chf-chflta)!* - Compute the long term average.

end subroutine pkfunc

!*=====================================================================
subroutine pkeval(array,ndxmx,si,ndxpk,nlncda)
!*=====================================================================
!* PURPOSE: To evaluate a valid pick.
!*=====================================================================
!* INPUT ARGUMENTS:
!*    ARRAY:   Array containing the trace. [fa]
!*    NDXMX:   Length of ARRAY. [i]
!*    SI:      Sampling interval, seconds. [f]
!*    NDXPK:   Index in ARRAY of validated arrival pick. [i]
!*=====================================================================
!* OUTPUT ARGUMENTS:
!*    NLNCDA:  Length of event in samples. [i]
!*             Set to 0 if the end of the event was not found.
!*=====================================================================
!* GLOBAL INPUT:
!*    EAM:     D8, D5, C8
!*=====================================================================
!* SUBROUTINES CALLED:
!*			   PKFILT
!*=====================================================================
!* LOCAL VARIABLES:
!*    DIFF:    First difference at current data point. [f]
!*    FDNEW:   Current filtered data value. [f]
!*    ICOUNT:  Count of number of samples after coda level reached. [i]
!*    NDX:     Index of current data point being analyzed. [i]
!*    RMNABS:  Running mean absolute value of filtered data. [f]
!*    RMNCRT:  Critical value of RMNABS.  This is the value that
!*             determines the end of the signal or coda. [f]
!*=====================================================================

	real array(ndxmx)

	common /cAarry/ C1,C2,C3,C4,C5,C6,C7,C8,D5,D8,D9,I3,I4,I6

!* - Initialize operating parameters.

	ndx=1
	diff=array(ndx)
	fdnew=0.
	rmnabs=0.
	I8=D8/si+1

!* - Main loop during evaluation phase:

5000 continue

	if(ndx.lt.ndxmx)then
        fdold=fdnew				! High pass the data to remove the mean.
        call pkfilt(diff,fdold,fdnew,rmnabs)

        if(ndx.eq.ndxpk)then	! Compute coda level based upon level at pick OR based upon a preset value.
			I5=D5/si+1
			if(C8.gt.0.)then
				rmncrt=2.0*C8*rmnabs
			else
				rmncrt=-C8
			endif
			icount=0
			nlncda=I5

        elseif(ndx.gt.(ndxpk+I5))then	!* -- Coda is declared when running mean falls below coda level
			nlncda=nlncda+1				!*    and stays there for D8 seconds.
			if(rmnabs.lt.rmncrt)then	!*    Search does not start until D5 seconds after pick.
				icount=icount+1			!*    (I5 and I8 are the times, D5 and D8 converted from seconds to counts.)
				if(icount.ge.I8)then
					nlncda=nlncda-I8
					if(nlncda.le.I5)nlncda=0

					return
				endif
			else
				icount=0
			endif
        endif

!* -- Loop back during evaluation phase.

		ndx=ndx+1
		diff=array(ndx)-array(ndx-1)
		go to 5000
	endif

	nlncda=0

end subroutine pkeval
