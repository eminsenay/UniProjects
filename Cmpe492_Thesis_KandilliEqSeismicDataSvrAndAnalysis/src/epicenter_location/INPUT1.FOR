      SUBROUTINE INPUT1                                                  362.
C------- INPUT STATION LIST,CRUSTAL MODEL,AND CONTROL CARD ------------- 363.
      REAL*8 TIME1,TIME2                                                 365.
      REAL LAT,LON,LAT2,LON2,LATR,LONR,LATEP,LONEP                       366.
      COMMON /A1/ NSTA(1501),DLY(2,1501),FMGC(1501),XMGC(1501),          367.
     1       KLAS(1501),PRR(1501),CALR(1501),ICAL(1501),IS(1501),
     1       NDATE(1501),NHRMN(1501)                                     368.
      COMMON /A2/ LAT(1501),LON(1501),DELTA(1501),
     1       DX(1501),DY(1501),T(1501)                                   369.
      COMMON /A5/ ZTR,XNEAR,XFAR,POS,IQ,KMS,KFM,IPUN,IMAG,IR,QSPA(9,40)  370.
      COMMON /A6/ NMAX,LMAX,NS,NL,MMAX,NR,FNO,Z,
     1       X(4,1501),ZSQ,NRP,DF(1501)                                  371.
      COMMON /A14/ MBK,MDOL,BLANK,MSTAR,DOT,STAR4,QUES,CRMK,MCENT,ISTAR  372.
      COMMON /A15/ M,L,J,ORG,JAV,PMIN,AZRES(1501),NEAR,IDXS,LATEP,LONEP  373.
      COMMON /A16/ KLSS(1501),CALS(1501),MDATE(1501),MHRMN(1501),
     1       IPRN,ISW                                                    374.
      COMMON /A17/ TIME1,TIME2,LATR,LONR,KTEST,KAZ,KSORT,KSEL,XFN        375.
      COMMON /A19/ KNO,IELV(1501),TEST(15),FLT(2,1501),
     1       MNO(1501),IW(1501)                                          376.
      COMMON /A20/ V(21),D(21),VSQ(21),THK(21),TID(21,21),DID(21,21)     377.
      COMMON /A22/ F(21,21),G(4,21),H(21),DEPTH(21),IONE                 378.
      COMMON /A24/ FLTEP,IPRO,ISTTT,ISKP(4),AHEAD(12),FLIM,AF(3),NDEC    379.
      COMMON /A25/ INS(1501),IEW(1501),JPH                               380.
      DIMENSION BHEAD(12), ATEST(15)                                     381.
      IB1=' '
      KN1='N'
      KW1='W'
      DATA HEAD/'HEAD'/                                                  364.
C----------------------------------------------------------------------- 383.
      DO 350 I=1,15                                                      384.
      ATEST(I) = 1.23456                                                 385.
  350 CONTINUE                                                           386.
      WRITE(16,300)                                                     387.
  300 FORMAT(1H1)                                                        388.
      IF (M-1) 1,100,200                                                 389.
C------- INITIALIZE TEST VARIABLES ------------------------------------- 390.
    1 TEST(1)=0.10                                                       391.
      TEST(2)=10.                                                        392.
      TEST(3)=2.                                                         393.
      TEST(4)=0.05                                                       394.
      TEST(5)=5.                                                         395.
      TEST(6)= 4.                                                        396.
      TEST(7)=-0.87                                                      397.
      TEST(8)=+2.00                                                      398.
      TEST(9)=+0.0035                                                    399.
      TEST(10)=100.                                                      400.
      TEST(11)=8.0                                                       401.
      TEST(12)=0.5                                                       402.
      TEST(13)= 1.                                                       403.
      IFLAG=0                                                            404.
C------- INPUT RESET TEST-VARIABLE CARDS AND SELECTION CARD ------------ 405.
      DO 5 I=1,16                                                        406.
      READ(15,4) ISW,J,  TESTJ,BHEAD                                      407.
    4 FORMAT(A4,T12, I2,T16,F9.4,12A4)                                   408.
   11 IF ((ISW.EQ.MBK).OR.(ISW.EQ.IONE)) GO TO 6                         409.
      IF(ISW .NE. HEAD) GO TO 12                                         410.
      DO 13 II=1,12                                                      411.
      AHEAD(II)= BHEAD(II)                                               412.
   13 CONTINUE                                                           413.
      GO TO 5                                                            414.
   12 IFLAG=1                                                            415.
      ATEST(J)=TESTJ                                                     416.
    5 CONTINUE                                                           417.
c    6 continue
    6 WRITE(16,14) AHEAD                                                  418.
   14 FORMAT(40X,12A4)                                                   419.
      WRITE(16,2)                                                         420.
    2 FORMAT(///,' ********** PROGRAM* HYPO71 REVISED (11/25/73) ******* 421.
     1',    ///,13X,'TEST(1)  TEST(2)  TEST(3)  TEST(4)  TEST(5)  TEST(6 422.
     2)  TEST(7)  TEST(8)  TEST(9) TEST(10) TEST(11) TEST(12) TEST(13)') 423.
      WRITE(16,3) (TEST(I),I=1,13)                                        424.
    3 FORMAT(' STANDARD ',13F9.4)                                        425.
      IF (IFLAG .EQ. 0) GO TO 8                                          426.
      DO 16 I = 1,15                                                     427.
      IF(ATEST(I) .NE. 1.23456) TEST(I)=ATEST(I)                         428.
   16 CONTINUE                                                           429.
      WRITE(16,7) (TEST(I),I=1,13)                                        430.
    7 FORMAT(' RESET TO ',13F9.4)                                        431.
C------- SQUARE SOME TEST-VARIABLES FOR LATER USE ---------------------- 432.
    8 TEST(1)=TEST(1)**2                                                 433.
      TEST(2)=TEST(2)**2                                                 434.
      TEST(4)=TEST(4)**2                                                 435.
C------- INPUT STATION LIST -------------------------------------------- 436.
      IF (ISW .EQ. IONE) GO TO 10                                        437.
      KNO=1                                                              438.
      WRITE(16,9)                                                         439.
    9 FORMAT(/,4X,'L     STN     LAT     LONG  ','  ELV DELAY',5X        440.
     1,'FMGC  XMGC KL  PRR  CALR IC      DATE HRMN')                     441.
      GO TO 20                                                           442.
c10     continue
   10 WRITE(16,15)                                                        443.
   15 FORMAT(/,4X,'L   STN    LAT      LONG      ELV     M  DLY1  DLY2', 444.
     1'  XMGC FMGC KL CALR IC   DATE HRMN')                              445.
   20 DO 50 L=1,NMAX                                                     446.
      IF (ISW .EQ. IONE) GO TO 30                                        447.
      READ(15,25) IW(L),NSTA(L),LAT1,LAT2,INS(L),LON1,LON2,IEW(L),
     *IELV(L),DLY(1,L),FMGC(L),XMGC(L),KLAS(L),PRR(L),CALR(L),
     *ICAL(L),NDATE(L),NHRMN(L)                                          450.
   25 FORMAT(1X,A1,A4,I2,F5.2,A1,I3,F5.2,A1,I4,F6.2,4X,F5.2,2X,F5.2,1X   451.
     1,I1,F5.2,F7.2,1X,I1,5X,I6,I4)                                      452.
      IF (NSTA(L) .EQ. MBK) GO TO 60                                     453.
      IF (INS(L) .EQ. IB1) INS(L)=KN1                                    454.
      IF (IEW(L) .EQ. IB1) IEW(L)=KW1                                    455.
      WRITE(16,26) L,IW(L),NSTA(L),LAT1,LAT2,INS(L),LON1,LON2,IEW(L)      456.
     1,IELV(L),DLY(1,L),FMGC(L),XMGC(L),KLAS(L),PRR(L),CALR(L),ICAL(L)   457.
     2,NDATE(L),NHRMN(L)                                                 458.
   26 FORMAT(I5,3X,A1,A4,I3,F5.2,A1,I4,F5.2,A1,I5,F6.2,4X,F5.2,2X,F5.2   459.
     1,1X,I1,F5.2,F7.2,1X,I1,5X,I6,I4)                                   460.
      GO TO 40                                                           461.
   30 READ(15,35) NSTA(L),IW(L),LAT1,LAT2,INS(L),LON1,LON2,IEW(L),
     *IELV(L),MNO(L),DLY(1,L),DLY(2,L),XMGC(L),FMGC(L),KLAS(L),
     *CALR(L),ICAL(L),NDATE(L),NHRMN(L)                                  464.
   35 FORMAT(A4,A1,I2,1X,F5.2,A1,I3,1X,F5.2,A1,I4,5X,I1                  465.
     1,4F6.2,1X,I1,F6.2,1X,I1,2X,I6,I4)                                  466.
      IF (NSTA(L) .EQ. MBK) GO TO 60                                     467.
      IF (INS(L) .EQ. IB1) INS(L)=KN1                                    468.
      IF (IEW(L) .EQ. IB1) IEW(L)=KW1                                    469.
      WRITE(16,36) L,NSTA(L),IW(L),LAT1,LAT2,INS(L),LON1,LON2,IEW(L)      470.
     1,IELV(L),MNO(L),DLY(1,L),DLY(2,L),XMGC(L),FMGC(L),KLAS(L),CALR(L)  471.
     2,ICAL(L),NDATE(L),NHRMN(L)                                         472.
   36 FORMAT(I5,2X,A4,A1,I2,1X,F5.2,A1,I4,1X,F5.2,A1,I5,5X,I1            473.
     1,4F6.2,1X,I1,F6.2,1X,I1,2X,I6,I4)                                  474.
      PRR(L)=0.                                                          475.
   40 LAT(L)=60.*LAT1+LAT2                                               476.
      LON(L)=60.*LON1+LON2                                               477.
      MDATE(L)=NDATE(L)                                                  478.
      MHRMN(L)=NHRMN(L)                                                  479.
      KLSS(L)=KLAS(L)                                                    480.
      CALS(L)=CALR(L)                                                    481.
   50 CONTINUE                                                           482.
      WRITE(16,55)                                                        483.
   55 FORMAT(///,' ***** ERROR* STATION LIST EXCEEDS ARRAY DIMENSION')   484.
      STOP                                                               485.
   60 NS=L-1                                                             486.
C------- INPUT CRUSTAL MODEL ------------------------------------------- 487.
c100    continue
  100 WRITE(16,105)                                                       488.
  105 FORMAT(///,7X,'CRUSTAL MODEL 1',/,5X,'VELOCITY     DEPTH')         489.
      DO 130 L=1,LMAX                                                    490.
      READ(15,115) V(L),D(L)                                              491.
  115 FORMAT(2F7.3)                                                      492.
      IF (V(L) .LT. 0.01) GO TO 140                                      493.
      WRITE(16,125) V(L),D(L)                                             494.
  125 FORMAT(3X,2F10.3)                                                  495.
      DEPTH(L)=D(L)                                                      496.
      VSQ(L)=V(L)**2                                                     497.
  130 CONTINUE                                                           498.
      WRITE(16,135)                                                       499.
  135 FORMAT(///,' ***** ERROR* CRUSTAL MODEL EXCEEDS ARRAY DIMENSION')  500.
      STOP                                                               501.
  140 NL=L-1                                                             502.
      N1=NL-1                                                            503.
C-----LAYER THICKNESS THK,F + G TERMS                                    504.
      DO 145 L=1,N1                                                      505.
      THK(L)=D(L+1)-D(L)                                                 506.
  145 H(L)=THK(L)                                                        507.
C---- COMPUTE TID AND DID                                                508.
      DO 150 J=1,NL                                                      509.
      G(1,J)=SQRT(ABS(VSQ(J)-VSQ(1)))/(V(1)*V(J))                        510.
      G(2,J)=SQRT(ABS(VSQ(J)-VSQ(2)))/(V(2)*V(J))                        511.
      G(3,J)=V(1)/SQRT(ABS(VSQ(J)-VSQ(1))+0.000001)                      512.
      G(4,J)=V(2)/SQRT(ABS(VSQ(J)-VSQ(2))+0.000001)                      513.
      IF (J .LE. 1) G(1,J)=0.                                            514.
      IF (J .LE. 2) G(2,J)=0.                                            515.
      IF (J .LE. 1) G(3,J)=0.                                            516.
      IF (J .LE. 2) G(4,J)=0.                                            517.
      DO 150 L=1,NL                                                      518.
      F(L,J)=1.                                                          519.
      IF (L .GE. J) F(L,J)=2.                                            520.
  150 CONTINUE                                                           521.
      DO 165 J=1,NL                                                      522.
      DO 165 M=1,NL                                                      523.
      TID(J,M)=0.                                                        524.
  165 DID(J,M)=0.                                                        525.
      DO 170 J=1,NL                                                      526.
      DO 170 M=J,NL                                                      527.
      IF (M .EQ. 1) GO TO 170                                            528.
      M1=M-1                                                             529.
      DO 160 L=1,M1                                                      530.
      SQT=SQRT(ABS(VSQ(M)-VSQ(L)))                                       531.
      TIM=THK(L)*SQT/(V(L)*V(M))                                         532.
      DIM=THK(L)*V(L)/SQT                                                533.
      TID(J,M)=TID(J,M)+F(L,J)*TIM                                       534.
  160 DID(J,M)=DID(J,M)+F(L,J)*DIM                                       535.
  170 CONTINUE                                                           536.
      IF (ISW .NE. IONE) GO TO 200                                       537.
C---- VARIABLE FIRST LAYER                                               538.
      VC=V(1)*V(2)/SQRT(ABS(VSQ(2)-VSQ(1)))                              539.
      DO 180 I=1,NS                                                      540.
      FLT(1,I)=DLY(1,I)*VC+D(2)                                          541.
  180 FLT(2,I)=DLY(2,I)*VC+D(2)                                          542.
C------- INPUT CONTROL CARD -------------------------------------------- 543.
c200    continue
  200 WRITE(16,205)                                                       544.
  205 FORMAT(///,' ZTR XNEAR XFAR  POS   IQ  KMS  KFM IPUN IMAG   IR'    545.
     1,' IPRN CODE   LATR      LONR')                                    546.

c======================================================================
      READ(15,215) ZTR,XNEAR,XFAR,POS,IQ,KMS,KFM,IPUN,IMAG,IR,IPRN        547.
     1,KTEST,KAZ,KSORT,KSEL,LAT1,LAT2,LON1,LON2                          548.


  215 FORMAT(3F5.0,F5.2,7I5,1X,4I1,2(I4,F6.2))                           549.

c=====================================================================
      LATR=60.*LAT1+LAT2                                                 552.
      LONR=60.*LON1+LON2                                                 553.
      IF (IR .EQ. 0) RETURN                                              554.
      DO 240 I=1,IR                                                      555.
      READ(15,225) (QSPA(I,J),J=1,40)                                    556.
  225 FORMAT(20F4.2)                                                     557.
      WRITE(16,235) I,(QSPA(I,J),J=1,40)                                558.
  235 FORMAT(/,' QSPA(',I1,')* ',20F5.2,/,10X,20F5.2)                    559.
  240 CONTINUE                                                           560.
      RETURN                                                             561.
      END                                                                562.
