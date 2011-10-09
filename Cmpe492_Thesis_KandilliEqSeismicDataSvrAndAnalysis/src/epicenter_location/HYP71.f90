!  HYP71.f90 
!
!  FUNCTIONS/SUBROUTINES exported from zHYPO71.dll:
!	HYP71      - subroutine 
!

subroutine HYP02d

  
	integer L,magOK
	character*50 Header

	common /stnC/iSTNPar(1501),constA(1501),constB(1501),constC(1501),logus(1501),L,magOK

	L=1
    open(unit=10,file='katsay.tmp',status='old')
!    open(unit=11,file='zz.txt',status='unknown')
	read(10,21) magOK,Header
!	write(11,21)magOK,Header

5	READ(10,20,END=300) iSTNPar(L),constA(L),constB(L),constC(L),logus(L)
!	write(11,20)iSTNPar(L),constA(L),constB(L),constC(L),logus(L)
	L=L+1
	go to 5

300 continue
	L=L-1

	close(10)

	CALL HYPO71 
20	FORMAT(A4,3F9.6,I3)
21	FORMAT(I1,A50)
!	close(11)
	close(10)
end subroutine HYP02d
