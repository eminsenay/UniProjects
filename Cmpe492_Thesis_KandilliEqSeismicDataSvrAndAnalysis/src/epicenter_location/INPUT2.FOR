      SUBROUTINE INPUT2                                                  563.
C--------INPUT PHASE LIST -----------------------------------------------564.
      INTEGER*2 SYM                                                      565.
      REAL*8 TIME1,TIME2                                                 566.
      REAL LAT2,LON2,LATEP,LONEP,MAG                                     567.
      COMMON /A1/ NSTA(1501),DLY(2,1501),FMGC(1501),XMGC(1501),          568.
     1       KLAS(1501),PRR(1501),CALR(1501),ICAL(1501),IS(1501),
     1       NDATE(1501),NHRMN(1501)                                     569.
      COMMON /A6/ NMAX,LMAX,NS,NL,MMAX,NR,FNO,Z,
     1       X(4,1501),ZSQ,NRP,DF(1501)                                  570.
      COMMON /A8/ CAL(1501),XMAG(1501),FMAG(1501),NM,AVXM,SDXM,NF,AVFM,  571.
     1       SDFM,MAG,KDX(1501),AMX(1501),PRX(1501),CALX(1501),FMP(1501) 572.
      COMMON /A10/ ANIN(1501),AZ(1501),TEMP(1501),CA(71),CB(71)          573.
      COMMON /A11/ KDATE,KHR,KMIN,SEC,LAT1,LAT2,LON1,LON2,RMK1,RMK2,     574.
     1       IGAP,DMIN,RMSSQ,ERH,Q,QS,QD,ADJSQ,INST,AVR,AAR,NI,KNST,JHR  575.
     2       ,KYIL,KAY,KGUN                                                  
      COMMON /A12/ MSTA(1501),PRMK(1501),W(1501),JMIN(1501),P(1501),     576.
     1       RMK(1501),WRK(1501),TP(1501),DT(1501),COSL(701)             577.
      COMMON /A13/ JDX(1501),LDX(1501),KEY(1501),CLASS(4)                578.
      COMMON /A14/ MBK,MDOL,BLANK,MSTAR,DOT,STAR4,QUES,CRMK,MCENT,ISTAR  579.
      COMMON /A15/ M,L,J,ORG,JAV,PMIN,AZRES(1501),NEAR,IDXS,LATEP,LONEP  580.
      COMMON /A16/ KLSS(1501),CALS(1501),MDATE(1501),MHRMN(1501),
     1	   IPRN,ISW                                                    581.
      COMMON /A17/ TIME1,TIME2,LATR,LONR,KTEST,KAZ,KSORT,KSEL,XFN        582.
      COMMON /A18/ s(1501),SRMK(1501),WS(1501),TS(1501),NOS,QRMK(1501)   583.
      COMMON /A19/ KNO,IELV(1501),TEST(15),FLT(2,1501),
     1       MNO(1501),IW(1501)                                          584.
      COMMON /A21/ KSMP(1501),FMO,ONF,B(4),IPH,KF,AVRPS,IEXIT            585.
      COMMON /A23/ AIN(1501),RMS,ADJ,SYM(1501)                           586.
      COMMON /A24/ FLTEP,IPRO,ISTTT,ISKP(4),AHEAD(12),FLIM,AF(3),NDEC    587.

      DIMENSION ICARD(20)                                                588.
	
C------------------------------------------------------------------------589.
10    PMIN=9999.                                                         590.
      IDXS=0                                                             591.

     
      DO 20 I=1,NS                                                       592.
      KSMP(I)=0                                                          593.
20    JDX(I)=0                                                           594.
25    L=1                                                                595.
30    READ(15,35,END=300) MSTA(L),PRMK(L),W(L),IY,IA,IG,ISA              596.
     *,JMIN(L),P(L),S(L),SRMK(L),WS(L),AMX(L),PRX(L),CALP,CALX(L)        597.
     *,RMK(L),DT(L),FMP(L),AZRES(L),SYM(L),AS,ICARD,QRMK(L),IPRO,dFlug   598.
	
	
35    FORMAT(2A4,T8,F1.0,1x,4I2,I2,F5.2,T32,F5.2,A4,T40,F1.0,T44,F4.0    599.
     1,F3.2,F4.1,T59,F4.1,A3,F5.2,F5.0,T21,A4,T7,A1,T32,A4,T1,20A4       600.
     2,T63,A1,T5,A4,T20,I1)                                              601.

c      write(222,35) MSTA(L),PRMK(L),W(L),IY,IA,IG,ISA              
c     *,JMIN(L),P(L),S(L),SRMK(L),WS(L),AMX(L),PRX(L),CALP,CALX(L)        
c     *,RMK(L),DT(L),FMP(L),AZRES(L),SYM(L),AS,ICARD,QRMK(L),IPRO             


      IF ((MSTA(L).EQ.MSTAR).OR.(MSTA(L).EQ.MDOL).OR.(MSTA(L).EQ.MCENT)) 602.
     1GO TO 300                                                          603.
      IF (MSTA(L).EQ.MBK) GOTO 350                                       604.
      IF (CALX(L).LT.0.01) CALX(L)=CALP                                  605.
      DO 40 I=1,NS                                                       606.
      IF (MSTA(L) .EQ. NSTA(I)) GOTO 50                                  607.
40    CONTINUE                                                           608.
      WRITE(16,45) ICARD,MSTA(L)                                        609.
45    FORMAT(///,'***** ',20A4,' ****** DELETED: ',A4,'NOT ON STATION L  610.
     1IST')                                                              611.
      GO TO 30                                                           612.
50    KDX(L)=I                                                           613.
      LDX(L)=0                                                           614.
      JDX(I)=1                                                           615.
      IF (FMP(L) .LE.0.) FMP(L)=BLANK                                    616.
      IF (L .GT. 1) GOTO 60                                              617.
      JTIME=IY*1000000+IA*10000+IG*100+ISA
      KTIME=JTIME                                                        618.
      KDATE=KTIME/100                                                    619.
      KHR=KTIME-KDATE*100                                                620.
      KKK=KDATE
      KKG=KKK/100
      KGUN=KKK-KKG*100
      KK1=KKG
      KKA=KK1/100
      KAY=KK1-KKA*100
      KYIL=KK1/100
      K1=KYIL
      K2=KAY
      K3=KGUN
60    IF (jtime.EQ.KTIME) GO TO 70                                       621.
      WRITE(16,65) ICARD                                                622.
65    FORMAT(///,' ***** ',20A4,' ***** DELETED: WRONG TIME')            623.
      GO TO 30                                                           624.
70    IF (RMK(L) .EQ.CRMK) GOTO 200                                      625.
80    W(L)=(4.-W(L))/4.                                                  626.
      IF (IW(I) .EQ. ISTAR) W(L)=0.                                      627.
      TP(L)=60.*JMIN(L)+P(L)+DT(L)                                       628.
      WRK(L)=BLANK                                                       629.
      IF (W(L) .EQ. 0.) GO TO 90                                         630.
      IF (W(L) .GT. 0.) GO TO 89                                         631.
C------- SMP DATA: RESET WEIGHT -----------------------------------------632.
      W(L)=(4.-WS(L))/4.                                                 633.
      KSMP(L)=1                                                          634.
      IF(TP(L).GE.PMIN) GO TO 95                                         635.
      PMIN=TP(L)                                                         636.
      NEAR=L                                                             637.
      GO TO 95                                                           638.
89    IF (TP(L) .GE. PMIN) GO TO 90                                      639.
      PMIN=TP(L)                                                         640.
      NEAR=L                                                             641.
90    IF (AS .EQ. BLANK) GO TO 100                                       642.
C--------- S DATA -------------------------------------------------------643.
      IDXS=1                                                             644.
      LDX(L)=1                                                           645.
      WS(L)=(4.-WS(L))/4.                                                646.
      IF (IW(I) .EQ. ISTAR) WS(L)=0.                                     647.
95    TS(L)=60.*JMIN(L)+S(L)+DT(L)                                       648.
100   L=L+1                                                              649.
      IF (L .LT. MMAX) GO TO 30                                          650.
      WRITE(16,105)                                                     651.
105   FORMAT(///,' ***** ERROR: PHASE LIST EXEEDS ARRAY DIMENSION: EXTR  652.
     1A DATA TREATED AS NEXT EARTHQUAKE')                                653.
      GO TO 350                                                          654.
C------ CALIBRATION CHANGE IN STATION LIST ------------------------------655.
200   IF (P(L) .NE. 0.) KLAS(I)=P(L)                                     656.
      CALR(I)=CALX(L)                                                    657.
      TIME2=1.+0.6*KDATE+1.+0.4*KHR+1.+0.2*JMIN(L)                       658.
      IF (TIME2 .GE. TIME1) GO TO 250                                    659.
      WRITE(16,205)                                                       660.
205   FORMAT(///,' ********** THE FOLLOWING EVENT IS OUT OF CRONOLOGICA  661.
     1L ORDER ********** ')                                              662.
c250    continue
250   WRITE(16,255) KDATE,KHR,JMIN(L),MSTA(L),KLAS(I),CALR(I)            663.
255   FORMAT(///,' ***** ',I6,1X,2I2,' ***** CALIBRATION CHANGE FOR ',A4 664.
     1,': KLAS = ',I1,',CALR = ',F4.1)                                   665.
      MDATE(I)=KDATE                                                     666.
      MHRMN(I)=100*KHR+JMIN(L)                                           667.
      TIME1=TIME2                                                        668.
      GO TO 10                                                           669.
300   M=1                                                                670.
      NR=L-1                                                             671.

      RETURN                                                             672.
350   M=0                                                                673.
400   NR=L-1 

      RETURN                                                             675.
      END                                                                676.
