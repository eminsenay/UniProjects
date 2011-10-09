      SUBROUTINE FMPLOT                                                  249.
C------- PLOT FIRST-MOTION DIRECTIONS OF THE LOWER FOCAL HEMISPHERE      250.
C------- IN EQUAL AREA PROJECTION, WHERE C DENOTES COMPRESSION AND       251.
C------- D DENOTES DILATATION ------------------------------------------ 252.
      INTEGER*4 KDATE
      INTEGER*2 SYM
      INTEGER*2 GRAPH(95,59),TEMP                                        253.
      INTEGER*2 BORD,BLANK,PL,CR,DOT,SI,A,B,C,D,E,F,CD,SN,UP             254.
      REAL LAT2,LON2,MAG                                                 255.
      COMMON /A5/ ZTR,XNEAR,XFAR,POS,IQ,KMS,KFM,IPUN,IMAG,IR,QSPA(9,40)  256.
      COMMON /A6/ NMAX,LMAX,NS,NL,MMAX,NR,FNO,Z,
     1       G(4,1501),ZSQ,NRP,DF(1501)                                  257.
      COMMON /A7/ KP,KZ,KOUT,WT(1501),O(4),SE(4),XMEAN(4),
     1       CP(180),SP(180)                                             258.
      COMMON /A8/ CAL(1501),XMAG(1501),FMAG(1501),NM,AVXM,SDXM,NF,AVFM,  259.
     1       SDFM,MAG,KDX(1501),AMX(1501),PRX(1501),CALX(1501),FMP(1501) 260.
      COMMON /A10/ ANIN(1501),AZ(1501),OOOO(1501),CA(71),CB(71)          261.
      COMMON /A11/ KDATE,KHR,KMIN,SEC,LAT1,LAT2,LON1,LON2,RMK1,RMK2,     262.
     1       IGAP,DMIN,RMSSQ,ERH,Q,QS,QD,ADJSQ,INST,AVR,AAR,NI,KNST,JHR  263.
      COMMON /A19/ KNO,IELV(1501),TEST(15),FLT(2,1501),
     1       MNO(1501),IW(1501)                                          264.
      COMMON /A23/ AIN(1501),RMS,ADJ,SYM(1501)                           265.
      COMMON /A25/ INS(1501),IEW(1501),JPH                               266.
      DATA BORD,BLANK,PL,CR,DOT,SI/'*',' ','+','-','.','I'/              267.
      DATA A,B,C,D,E,F,CD,SN,UP/'A','B','C','D','E','F','X','N','U'/     268.
      DATA NOX,NOY,IX,IY,NOY1,NOX2,NOY2/95,59,39,24,57,48,30/            269.
      DATA RMAX,XSCALE,YSCALE,ADD/3.937008,0.101064,0.169643,4.75/       270.
C----------------------------------------------------------------------- 271.
      NFMR=0                                                             272.
      NO=FNO                                                             273.
      DO 1 I=1,NRP                                                       274.
      IF (SYM(I) .EQ. SN) SYM(I)=BLANK                                   275.
      IF (SYM(I) .EQ. BLANK) GO TO 1                                     276.
      IF (SYM(I) .EQ. UP) SYM(I)=C                                       277.
      NFMR=NFMR+1                                                        278.
    1 CONTINUE                                                           279.
      IF (NFMR .LT. KFM) RETURN                                          280.
      WRITE(16,2) INS(1),IEW(1)                                           281.
    2 FORMAT(1H1,'  DATE    ORIGIN    LAT ',A1,'    LONG ',A1,'    DEPTH 282.
     1    MAG NO GAP DMIN  RMS  ERH  ERZ Q M')                           283.
      WRITE(16,5) KDATE,KHR,KMIN,SEC,LAT1,LAT2,LON1,LON2,RMK1,Z,RMK2      284.
     1,MAG,NO,IGAP,DMIN,RMS,ERH,SE(3),Q,KNO                              285.
    5 FORMAT(2X,I6,1X,2I2,F6.2,I3,'-',F5.2,I4,'-',F5.2,A1,F6.2,A1        286.
     1,F6.2,I3,I4,F5.1,F5.2,2F5.1,1X,A1,1X,I1)                           287.
      DO 10 I=1,NOX                                                      288.
      DO 10 J=1,NOY                                                      289.
   10 GRAPH(I,J)=BLANK                                                   290.
      DO 20 I=1,180                                                      291.
      X=RMAX*CP(I)+ADD                                                   292.
      Y=RMAX*SP(I)+ADD                                                   293.
      JX=X/XSCALE+1.5                                                    294.
      JY=Y/YSCALE+.5                                                     295.
      JY=NOY-JY-1                                                        296.
   20 GRAPH(JX,JY)=BORD                                                  297.
      IT=NOX2-IX-1                                                       298.
      GRAPH(IT,NOY2)=CR                                                  299.
      IT=NOX2+IX+1                                                       300.
      GRAPH(IT,NOY2)=CR                                                  301.
      IT=NOY2-IY-1                                                       302.
      GRAPH(NOX2,IT)=SI                                                  303.
      IT=NOY2+IY+1                                                       304.
      GRAPH(NOX2,IT)=SI                                                  305.
      DO 50 I=1,NRP                                                      306.
      IF (SYM(I) .EQ. BLANK) GO TO 50                                    307.
      IF (AIN(I) .GT. 90.) GO TO 31                                      308.
      ANN=AIN(I)                                                         309.
      AZZ=AZ(I)*.0174533                                                 310.
      GO TO 32                                                           311.
   31 ANN=180.-AIN(I)                                                    312.
      AZZ=(180.+AZ(I))*.0174533                                          313.
   32 R=RMAX*1.414214*SIN(ANN*.0087266)                                  314.
      X=R*SIN(AZZ)+ADD                                                   315.
      Y=R*COS(AZZ)+ADD                                                   316.
      JX=X/XSCALE+1.5                                                    317.
      JY=Y/YSCALE+.5                                                     318.
      JY=NOY-JY-1                                                        319.
      TEMP=GRAPH(JX,JY)                                                  320.
C-----OVER-WRITE TEMP IF IT IS EQUAL TO BLANK,DOT,*,+,OR -               321.
      IF ((TEMP.EQ.BLANK).OR.(TEMP.EQ.BORD).OR.(TEMP.EQ.PL)              322.
     1.OR.(TEMP.EQ.CR).OR.(TEMP.EQ.DOT)) GO TO 47                        323.
C-----TEMP IS OCCUPIED SO IF SYS(I)=+ OR - SKIP THIS STATION             324.
      IF ((SYM(I).EQ.PL).OR.(SYM(I).EQ.CR)) GO TO 50                     325.
      IF (SYM(I) .EQ. C) GO TO 40                                        326.
      IF (GRAPH(JX,JY) .NE. D) GO TO 35                                  327.
      GRAPH(JX,JY)=E                                                     328.
      GO TO 50                                                           329.
   35 IF (GRAPH(JX,JY) .NE. E) GO TO 37                                  330.
      GRAPH(JX,JY)=F                                                     331.
      GO TO 50                                                           332.
   37 IF (GRAPH(JX,JY) .EQ. F) GO TO 50                                  333.
      GRAPH(JX,JY)=CD                                                    334.
      GO TO 50                                                           335.
   40 IF (GRAPH(JX,JY) .NE. C) GO TO 43                                  336.
      GRAPH(JX,JY)=B                                                     337.
      GO TO 50                                                           338.
   43 IF (GRAPH(JX,JY) .NE. B) GO TO 45                                  339.
      GRAPH(JX,JY)=A                                                     340.
      GO TO 50                                                           341.
   45 IF (GRAPH(JX,JY) .EQ. A) GO TO 50                                  342.
      GRAPH(JX,JY)=CD                                                    343.
      GO TO 50                                                           344.
   47 GRAPH(JX,JY)=SYM(I)                                                345.
   50 CONTINUE                                                           346.
      GRAPH(NOX2,NOY2)=BORD                                              347.
      WRITE(16,61)                                                        348.
   61 FORMAT(1H0,67X,'0')                                                349.
      DO 80 I=3,NOY1                                                     350.
      IF (I .EQ .NOY2) GO TO 70                                          351.
      WRITE(16,65) (GRAPH(J,I),J=1,NOX)                                   352.
   65 FORMAT(1H ,20X,95A1)                                               353.
      GO TO 80                                                           354.
c70    continue
   70 WRITE(16,75) (GRAPH(J,I),J=1,NOX)                                   355.
   75 FORMAT(1H ,16X,'270 ',95A1,' 90')                                  356.
   80 CONTINUE                                                           357.
      WRITE(16,85)                                                        358.
   85 FORMAT(67X,'180')                                                  359.
      RETURN                                                             360.
      END                                                                361.
