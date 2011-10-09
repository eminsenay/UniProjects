
SUBROUTINE XFMAGS0                                    
!COMPUTE X-MAGNITUDE AND F-MAGNITUDE ---------------------------

REAL LAT,LON,MAG     
common /stnC/iSTNPar(1501),constA(1501),constB(1501),constC(1501),logus(1501),nConst,magOK
                                         
COMMON /A12/ MSTA(1501),PRMK(1501),W(1501),JMIN(1501),P(1501), &        
&       RMK(1501),WRK(1501),TP(1501),DT(1501),COSL(701)                
COMMON /A1/ NSTA(1501),DLY(2,1501),FMGC(1501),XMGC(1501),KLAS(1501), &  
&       PRR(1501),CALR(1501),ICAL(1501),IS(1501),NDATE(1501),NHRMN(1501) 
COMMON /A2/ LAT(1501),LON(1501),DELTA(1501),DX(1501),DY(1501),T(1501)   
COMMON /A5/ ZTR,XNEAR,XFAR,POS,IQ,KMS,KFM,IPUN,IMAG,IR,QSPA(9,40) 
COMMON /A6/ NMAX,LMAX,NS,NL,MMAX,NR,FNO,Z,X(4,1501),ZSQ,NRP,DF(1501)
COMMON /A8/ CAL(1501),XMAG(1501),FMAG(1501),NM,AVXM,SDXM,NF,AVFM, &   
&       SDFM,MAG,KDX(1501),AMX(1501),PRX(1501),CALX(1501),FMP(1501)     
COMMON /A16/ KLSS(1501),CALS(1501),MDATE(1501),MHRMN(1501),IPRN,ISW   
COMMON /A19/ KNO,IELV(1501),TEST(15),FLT(2,1501),MNO(1501),IW(1501)   

DIMENSION RSPA(8,20)                                              


DATA ZMC1,ZMC2,PWC1,PWC2/0.15,3.38,0.80,1.50/,BLANK/'    '/       

DATA RSPA/ -0.02, 1.05,-0.15,-0.13, 0.66, 0.55, 0.17, 0.42, &       
&           0.14, 1.18,-0.01, 0.01, 0.79, 0.66, 0.27, 0.64, &        
&           0.30, 1.29, 0.12, 0.14, 0.90, 0.76, 0.35, 0.84, &        
&           0.43, 1.40, 0.25, 0.27, 1.00, 0.86, 0.43, 0.95, &        
&           0.55, 1.49, 0.38, 0.41, 1.08, 0.93, 0.49, 1.04, &        
&           0.65, 1.57, 0.53, 0.57, 1.16, 1.00, 0.55, 1.13, &        
&           0.74, 1.63, 0.71, 0.75, 1.23, 1.07, 0.63, 1.24, &        
&           0.83, 1.70, 0.90, 0.95, 1.30, 1.15, 0.72, 1.40, &        
&           0.92, 1.77, 1.07, 1.14, 1.38, 1.25, 0.83, 1.50, &        
&           1.01, 1.86, 1.23, 1.28, 1.47, 1.35, 0.95, 1.62, &        
&           1.11, 1.96, 1.35, 1.40, 1.57, 1.46, 1.08, 1.73, &        
&           1.20, 2.05, 1.45, 1.49, 1.67, 1.56, 1.19, 1.84, &        
&           1.30, 2.14, 1.55, 1.58, 1.77, 1.66, 1.30, 1.94, &        
&           1.39, 2.24, 1.65, 1.67, 1.86, 1.76, 1.40, 2.04, &        
&           1.47, 2.33, 1.74, 1.76, 1.95, 1.85, 1.50, 2.14, &        
&           1.53, 2.41, 1.81, 1.83, 2.03, 1.93, 1.58, 2.24, &        
&           1.56, 2.45, 1.85, 1.87, 2.07, 1.97, 1.62, 2.31, &        
&           1.53, 2.44, 1.84, 1.86, 2.06, 1.96, 1.61, 2.31, &        
&           1.43, 2.36, 1.76, 1.78, 1.98, 1.88, 1.53, 1.92, &        
&           1.25, 2.18, 1.59, 1.61, 1.82, 1.72, 1.37, 1.49/        
!-----------------------------------------------------------------------
	NM=0                                                              
	AVXM=0.                                                           
	SDXM=0.                                                           
	NF=0                                                              
	AVFM=0.                                                           
	SDFM=0.

	DO 40 I=1,NRP                                                     
		XMAG(I)=BLANK                                                     
		RAD2=DELTA(I)**2+ZSQ                                              
		IF ((RAD2.LT.1.).OR.(RAD2.GT.360000.)) GO TO 30                   
		JI=KDX(I)                                                         
		K=KLAS(JI)                                                        
		AMXI=ABS(AMX(I))                                                  
		CAL(I)=CALX(I)                                                    
		IF ((CAL(I).LT.0.01).OR.(ICAL(JI).EQ.1)) CAL(I)=CALR(JI)          
		IF ((AMXI.LT.0.01).OR.(CAL(I).LT.0.01)) GO TO 30                  
		IF ((K.LT.0).OR.(K.GT.8)) GO TO 30                                
		XLMR=0.                                                           
		IF (K .EQ. 0) GO TO 20                                            
		PRXI=PRX(I)                                                       
		IF (PRXI .LT. 0.01) PRXI=PRR(JI)                                  
		IF (IR .EQ. 0) GO TO 10                                           
		IF ((PRXI.GT.20.).OR.(PRXI.LT.0.033)) GO TO 30                    
		FQ=10.*ALOG10(1./PRXI)+20.                                        
		IFQ=FQ                                                            

		XLMR=QSPA(K,IFQ)+(FQ-IFQ)*(QSPA(K,IFQ+1)-QSPA(K,IFQ))             
		GO TO 20                                                          
10		IF ((PRXI.GT.3.).OR.(PRXI.LT.0.05)) GO TO 30                      
		FQ=10.*ALOG10(1./PRXI)+6.                                         
		IFQ=FQ                                                            
		XLMR=RSPA(K,IFQ)+(FQ-IFQ)*(RSPA(K,IFQ+1)-RSPA(K,IFQ))             
20		BLAC=ALOG10(AMXI/(2.*CAL(I)))-XLMR                                
		RLD2=ALOG10(RAD2)                                                 
		BLNT=ZMC1-PWC1*RLD2                                               
		IF (RAD2 .GE. 40000.) BLNT=ZMC2-PWC2*RLD2                         
		XMAG(I)=BLAC-BLNT+XMGC(JI)                                        
		NM=NM+1                                                           
		AVXM=AVXM+XMAG(I)                                                 
		SDXM=SDXM+XMAG(I)**2                                              
30		FMAG(I)=BLANK                                                     


!*------------------------------------------------------------
!222 FORMAT(2A4,5f10.7)

		do nc=1,nConst
			if (MSTA(I) .eq. iSTNPar(nc)) then
				

				if(FMP(I).GT.1.0) Then
					FMAG(I)= constA(nc)+constB(nc)*(ALOG10(FMP(I)))**logus(nc) &
					&		+constC(nc)*DELTA(I)+FMGC(JI)
					NF=NF+1                                                           
					AVFM=AVFM+FMAG(I)                                                 
					SDFM=SDFM+FMAG(I)**2  
!				write(11,*)MSTA(I),iSTNPar(nc),constA(nc),constB(nc),constC(nc),FMP(I),FMAG(I),logus(nc)
				endif 
				goto 40
			end if                                           
		end do
!Katsayýsý olmayan ama süresi olan istasyonlar
		if(FMP(I).GT.1.0 .and. magOK .eq. 1) Then
			FMAG(I)=TEST(7)+TEST(8)*ALOG10(FMP(I))+TEST(9)*DELTA(I)+FMGC(JI)  
			NF=NF+1                                                           
			AVFM=AVFM+FMAG(I)                                                 
			SDFM=SDFM+FMAG(I)**2
		end if
	                                              
40	CONTINUE                                                          

!write(11,*)nf

	IF (NM .EQ. 0) GO TO 50                                           
	AVXM=AVXM/NM                                                      
	SDXM=SQRT(ABS(SDXM/NM-AVXM**2))                                   
50	IF (NF .EQ. 0) GO TO 60                                           
	AVFM=AVFM/NF                                                      
	SDFM=SQRT(ABS(SDFM/NF-AVFM**2))                                   
60	IF (NM .EQ. 0) AVXM=BLANK                                         
	IF (NF .EQ. 0) AVFM=BLANK                                         
	IF (IMAG-1) 70,80,90                                             

70	MAG=AVXM                                                          
	RETURN                                                           

80	MAG=AVFM                                                          
	RETURN                                                            

90	MAG=0.5*(AVXM+AVFM)                                               
	IF (AVXM .EQ. BLANK) GO TO 80                                    
	IF (AVFM .EQ. BLANK) GO TO 70                                    

	RETURN                                                            
END                                                               
