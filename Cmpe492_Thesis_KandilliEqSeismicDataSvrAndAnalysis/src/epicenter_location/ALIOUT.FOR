      SUBROUTINE OUTPUT                                                  738.
C------- OUTPUT HYPOCENTER --------------------------------------------- 739.
      INTEGER*2 SYM                                                      740.
      REAL*8 TIME1,TIME2                                                 741.
      REAL LAT,LON,LAT2,LON2,LATEP,LONEP,MAG,LATR,LONR
	
                   
      COMMON /A1/ NSTA(1501),DLY(2,1501),FMGC(1501),                     
     1       XMGC(1501),KLAS(1501),PRR(1501),CALR(1501),                 
     1       ICAL(1501),IS(1501),NDATE(1501),NHRMN(1501)                 
      COMMON /A2/ LAT(1501),LON(1501),DELTA(1501),                       
     1	   DX(1501),DY(1501),T(1501)								   
      COMMON /A5/ ZTR,XNEAR,XFAR,POS,IQ,KMS,KFM,IPUN,IMAG,IR,QSPA(9,40)  746.
      COMMON /A6/ NMAX,LMAX,NS,NL,MMAX,NR,FNO,Z,                         
     1       X(4,1501),ZSQ,NRP,DF(1501)								   
      COMMON /A7/ KP,KZ,KOUT,WT(1501),Y(4),SE(4),XMEAN(4),
     1       CP(180),SP(180)                                             748.
      COMMON /A8/ CAL(1501),XMAG(1501),FMAG(1501),NM,AVXM,SDXM,NF,AVFM,  749.
     1       SDFM,MAG,KDX(1501),AMX(1501),PRX(1501),CALX(1501),FMP(1501) 750.
      COMMON /A10/ ANIN(1501),AZ(1501),TEMP(1501),CA(71),CB(71)          751.
      COMMON /A11/ KDATE,KHR,KMIN,SEC,LAT1,LAT2,LON1,LON2,RMK1,RMK2,     752.
     1       IGAP,DMIN,RMSSQ,ERH,Q,QS,QD,ADJSQ,INST,AVR,AAR,NI,KNST,JHR  753.
      COMMON /A12/ MSTA(1501),PRMK(1501),W(1501),JMIN(1501),P(1501),     754.
     1       RMK(1501),WRK(1501),TP(1501),DT(1501),COSL(701)             755.
      COMMON /A13/ JDX(1501),LDX(1501),KEY(1501),CLASS(4)                756.
      COMMON /A14/ MBK,MDOL,BLANK,MSTAR,DOT,STAR4,QUES,CRMK,MCENT,ISTAR  757.
      COMMON /A15/ M,L,J,ORG,JAV,PMIN,AZRES(1501),NEAR,IDXS,LATEP,LONEP  758.
      COMMON /A16/ KLSS(1501),CALS(1501),MDATE(1501),MHRMN(1501),
     1       IPRN,ISW                                                    759.
      COMMON /A17/ TIME1,TIME2,LATR,LONR,KTEST,KAZ,KSORT,KSEL,XFN        760.
      COMMON /A18/ S(1501),SRMK(1501),WS(1501),TS(1501),NOS,QRMK(1501)   761.
      COMMON /A19/ KNO,IELV(1501),TEST(15),FLT(2,1501),
     1       MNO(1501),IW(1501)                                          762.
      COMMON /A21/ KSMP(1501),FMO,ONF,B(4),IPH,KF,AVRPS,IEXIT            763.
      COMMON /A22/ F(21,21),G(4,21),H(21),DEPTH(21),IONE                 764.
      COMMON /A23/ AIN(1501),RMS,ADJ,SYM(1501)                           765.
      COMMON /A24/ FLTEP,IPRO,ISTTT,ISKP(4),AHEAD(12),FLIM,AF(3),NDEC    766.
      COMMON /A25/ INS(1501),IEW(1501),JPH                               767.

      DIMENSION FMT1(32),FMT2(24),FMT3(32),FMT4(16),DEMP(1501),SYMBOL(5) 768.


      DATA FMT1/'(1X,','I6,A','1,2I','2,F6','.2,I','3,A1',',F5.','2,I4', 769.
     1          ',A1,','F5.2',',A1,','F6.2',',A1,','F6.2',',2I3',',I4,', 770.
     2          'I2,F','5.2,','F5.1',',   ','F5.1',',2(1','X,A1','),2A', 771.
     3          '1,F5','.2,2','I3,2','F5.2',',2(I','3,2F','5.1)',',I2)'/ 772.
      DATA FMT2/'(I6,','1X,2','I2,F','6.2,','I3,A','1,F5','.2,I','4,A1', 773.
     1          ',F5.','2,A1',',F6.','2,A1',',   ','F6.2',',I3,','I4,F', 774.
     2          '5.1,','F5.2',',   ','F5.1',',   ','F5.1',',3A1',')   '/ 775.
      DATA FMT3/'(1X,','A4,F','6.1,','2I4,','1X,A','4,1X',',2I2',',4F6', 776.
     1          '.2, ','F6.2',',A2,','F4.2',',I4,','I3,F','6.2,','I2, ', 777.
     2          'F4.1',',A1,','1X,A','3,  ','I4, ','F4.1',',A1,','1X,A', 778.
     3          '4, 3','F6.2',',A2,','F4.2',',   ','F6.2',',T6,','A1) '/ 779.
      DATA FMT4/'(A4,','3F6.','1,1X',',A4,','2F6.','2,F5','.1, ','F6.2', 780.
     1          ',1X,','A3, ','F6.2',',I7,','   2','I2,2','I4,A','1)  '/ 781.
      DATA SYM1,SYM2,F1,F2,G1,G2/'-','*','F6.2','F5.1','A6  ','  A5'/    782.
      DATA F4,F5,F6,G3,G4/'F4.1','I4, ','F4.2','A4  ','A4, '/            783.
      DATA SYMBOL/' ','1','2','Q','*'/,ZDOT/'0.  '/,KS1,KW1/'S','W'/     784.
C----------------------------------------------------------------------- 785.
      IF ((IPRN.GE.2) .OR. (KP.EQ.1)) then
		CALL XFMAGS0
	endif

      LAT1=LATEP/60.                                                     787.
      LAT2=LATEP-60.*LAT1                                                788.
      LON1=LONEP/60.                                                     789.
      LON2=LONEP-60.*LON1                                                790.
      ADJ=SQRT(ABS(ADJSQ))                                               791.
      RMS=SQRT(ABS(RMSSQ))                                               792.
      JHR=KHR                                                            793.
      OSAVE = ORG                                                        794.
      IF (ORG .GE. 0.) GO TO 5                                           795.
      ORG=ORG+3600.                                                      796.
      KHR=KHR-1                                                          797.
    5 KMIN=ORG/60.0                                                      798.
      SEC=ORG-60.0*KMIN                                                  799.
      ERH=SQRT(SE(1)**2+SE(2)**2)                                        800.
      NO=FNO                                                             801.
      RMK1=BLANK                                                         802.
      RMK2=BLANK                                                         803.
      RMKO=BLANK                                                         804.
C---- KZ=1 FOR FIXED DEPTH* ONF=0 FOR ORIGIN TIME BASED ON SMP'S         805.
      IF (ONF .EQ. 0.) RMKO=STAR4                                        806.
      IF (KZ .EQ. 1) RMK2=STAR4                                          807.
      J=0                                                                808.
      DO 10 I=1,NRP                                                      809.
      DXI=DX(I)                                                          810.
      DYI=DY(I)                                                          811.
      IF ((DXI.EQ.0.).AND.(DYI.EQ.0.)) GO TO 6                           812.
      JI=KDX(I)                                                          813.
      IF (INS(JI) .EQ. KS1) DYI=-DYI                                     814.
      IF (IEW(JI) .EQ. KW1) DXI=-DXI                                     815.
      AZ(I)=AMOD(ATAN2(DXI,DYI)*57.29578 + 360., 360.)                   816.
      GO TO 7                                                            817.
    6 AZ(I)= 999.                                                        818.
    7 CONTINUE                                                           819.
      AIN(I)=ASIN(ANIN(I))*57.29578                                      820.
      IF (AIN(I) .LT. 0.) AIN(I)=180.+AIN(I)                             821.
      AIN(I)=180.-AIN(I)                                                 822.
      SWT=0.                                                             823.
      IF (LDX(I) .EQ. 0.) GO TO 8                                        824.
      KK=LDX(I)                                                          825.
      SWT=WT(KK)                                                         826.
    8 IF ((WT(I).EQ.0.).AND.(SWT.EQ.0.)) GO TO 10                        827.
      J=J+1                                                              828.
      TEMP(J)=AZ(I)                                                      829.
   10 CONTINUE                                                           830.
      CALL SORT(TEMP,KEY,J)                                              831.
      GAP=TEMP(1)+360.-TEMP(J)                                           832.
      DO 20 I=2,J                                                        833.
      DTEMP=TEMP(I)-TEMP(I-1)                                            834.
      IF (DTEMP .GT. GAP) GAP=DTEMP                                      835.
   20 CONTINUE                                                           836.
      IGAP=GAP+0.5                                                       837.
      DO 25 I=1,NRP                                                      838.
   25 DEMP(I)=DELTA(I)                                                   839.
      CALL SORT(DEMP,KEY,NRP)                                            840.
      DO 27 I=1,NRP                                                      841.
      K=KEY(I)                                                           842.
      SWT=0.                                                             843.
      IF (LDX(K) .EQ. 0.) GO TO 26                                       844.
      KK=LDX(K)                                                          845.
      SWT=WT(KK)                                                         846.
   26 IF ((WT(K).GT.0.).OR.(SWT.GT.0.)) GO TO 28                         847.
   27 CONTINUE                                                           848.
   28 DMIN=DEMP(I)                                                       849.
      IDMIN=DMIN+0.5                                                     850.
      OFD=Z                                                              851.
      TFD=2.*Z                                                           852.
      IF (OFD .LT. 5.) OFD=5.                                            853.
      IF (TFD .LT. 10.) TFD=10.                                          854.
      JS=4                                                               855.
      IF ((RMS.LT.0.50).AND.(ERH.LE.5.0)) JS=3                           856.
      IF ((RMS.LT.0.30).AND.(ERH.LE.2.5).AND.(SE(3).LE.5.0)) JS=2        857.
      IF ((RMS.LT.0.15).AND.(ERH.LE.1.0).AND.(SE(3).LE.2.0)) JS=1        858.
      JD=4                                                               859.
      IF (NO .LT. 6) GO TO 30                                            860.
      IF ((GAP.LE.180.).AND.(DMIN.LE.50.)) JD=3                          861.
      IF ((GAP.LE.135.).AND.(DMIN.LE.TFD)) JD=2                          862.
      IF ((GAP.LE. 90.).AND.(DMIN.LE.OFD)) JD=1                          863.
   30 JAV=(JS+JD+1)/2                                                    864.
      Q=CLASS(JAV)                                                       865.
      QS=CLASS(JS)                                                       866.
      QD=CLASS(JD)                                                       867.
   50 TIME2=SEC+1.D+02*KMIN+1.D+04*KHR+1.D+06*IABS(KDATE)                868.
      IF(IPRN .EQ. 0) GO TO 52                                           869.
      IF(NI .NE. 1) GO TO 60                                             870.
      IF(NDEC .GE. 1) GO TO 60                                           871.
      IF (JPH .EQ. 1) GO TO 60                                           872.
   52 KKYR=KDATE/10000                                                   873.
      KKMO=(KDATE-KKYR*10000)/100                                        874.
      KKDAY=(KDATE-KKYR*10000-KKMO*100)                                  875.
      JPH=1                                                              876.
      IF(KSEL) 501,501,505                                               877.
c501    continue
  501 WRITE(16,502)                                                       878.
  502 FORMAT(///)                                                        879.
      GO TO 535                                                          880.
c505   continue
  505 WRITE(16,506)                                                       881.
  506 FORMAT(1H1)                                                        882.
c51    continue
   51 WRITE(16,53) AHEAD,KKYR,KKMO,KKDAY,KHR,KMIN                         883.
   53 FORMAT(/,30X,12A4,T112,I2,'/',I2,'/',I2,4X,I2,':',I2)              884.
  535 IF( TIME2 - TIME1 .GT. -20.)GO TO 60                               885.
      WRITE(16,54)                                                        886.
   54 FORMAT(' ***** FOLLOWING EVENT IS OUT OF ORDER *****')             887.
   60 IF ((KP.EQ.1) .AND. (IPRN.EQ.0)) GO TO 67                          888.
      IF (IPH .EQ. 1) GO TO 62                                           889.
      WRITE(16,61) INS(1),IEW(1)                                          890.
   61 FORMAT(/,59X,'  ADJUSTMENTS (KM)  PARTIAL F-VALUES  STANDARD ERROR 891.
     1S  ADJUSTMENTS TAKEN',/,'  I  ORIG  LAT ',A1                       892.
     2,'    LONG ',A1,           '   DEPTH  DM  RMS AVRPS SKD   CF   DLA 893.
     3T  DLON    DZ  DLAT  DLON    DZ  DLAT  DLON    DZ  DLAT  DLON    D 894.
     4Z')                                                                895.
      IF (IPRN .EQ. 1) IPH=1                                             896.
c62     continue
   62 WRITE(16,63) NI,SEC,LAT1,LAT2,LON1,LON2,Z,RMK2,IDMIN,RMS,AVRPS,     897.
     1 QS,KF,QD,FLIM,B(2),B(1),B(3),AF(2),AF(1),AF(3),SE(2),SE(1),       898.
     2 SE(3),Y(2),Y(1),Y(3)                                              899.
   63 FORMAT(I3,F6.2,I3,'-',F5.2,I4,'-',F5.2,F6.2,A1,I3,F5.2,F6.2,       900.
     1 1X,A1,I1,A1,13F6.2)                                               901.
      IF (KP .EQ. 0) GO TO 100                                           902.
   67 JNST=KNST*10+INST                                                  903.
      IF (NM .EQ. 0) AVXM=0.                                             904.
      IF (NF .EQ. 0) AVFM=0.                                             905.
      FMT1(14)=F1                                                        906.
      FMT1(19)=F2                                                        907.
      FMT1(21)=F2                                                        908.
      FMT2(14)=F1                                                        909.
      FMT2(20)=F2                                                        910.
      FMT2(22)=F2                                                        911.
      IF (MAG .NE. BLANK) GO TO 68                                       912.
      FMT1(14)=G1                                                        913.
      FMT2(14)=G1                                                        914.
   68 IF (SE(3) .NE. 0.) GO TO 70                                        915.
      SE(3)=BLANK                                                        916.
      FMT1(21)=G2                                                        917.
      FMT2(22)=G2                                                        918.
   70 IF (ERH .NE. 0.) GO TO 72                                          919.
      ERH=BLANK                                                          920.
      FMT1(19)=G2                                                        921.
      FMT2(20)=G2                                                        922.
c72    continue
   72 WRITE(16,75) INS(1),IEW(1)                                          923.
   75 FORMAT(//, '  DATE    ORIGIN    LAT ',A1,'    LONG ',A1,'    DEPTH 924.
     1    MAG NO DM GAP M  RMS  ERH  ERZ Q SQD  ADJ IN NR  AVR  AAR NM A 925.
     2VXM SDXM NF AVFM SDFM I')                                          926.
c80     continue
   80 WRITE(16,FMT1)KDATE,RMKO,KHR,KMIN,SEC,LAT1,SYM1,LAT2,LON1,SYM1,
     *LON2,RMK1,Z,RMK2,MAG,NO,IDMIN,IGAP,KNO,RMS,ERH,SE(3),Q,QS,SYM2,
     *QD,ADJ,JNST,NR,AVR,AAR,NM,AVXM,SDXM,NF,AVFM,SDFM,NI                929.
      IF (IPUN .EQ. 0) GO TO 100                                         930.
      IF ((QRMK(1).NE.SYMBOL(4)).AND.(QRMK(1).NE.SYMBOL(5)))             931.
     1QRMK(1)=SYMBOL(1)                                                  932.
      SYM3=SYMBOL(KNO+1) 
	
	if (AVFM .LT. BLANK) AVFM = '0.01'                                               933.
      WRITE(7,FMT2) KDATE,KHR,KMIN,SEC,LAT1,SYM1,LAT2,LON1,SYM1,LON2     934.
     1,RMK1,Z,RMK2,AVFM,NO,IGAP,DMIN,RMS,ERH,SE(3),QRMK(1),Q,SYM3         935.
C 1090 FORMAT(I2,I4,I3,I2,F6.2,I3,A1,F5.2,I4,A1,F5.2,A2,F5.2,2A4,I2,
C     1 I4,F5.1,F5.2,2F5.1,3A1)
  100 IF (KP .EQ. 1) GO TO 105                                           936.
      IF(IPRN .LE. 1) GO TO 300                                          937.
c105    continue
  105 WRITE(16,110)                                                       938.
  110 FORMAT(/,'  STN  DIST AZM AIN PRMK HRMN P-SEC TPOBS TPCAL DLY/H1 P
     1-RES P-WT AMX PRX CALX K XMAG RMK FMP FMAG SRMK S-SEC TSOBS S-RES  940.
     2 S-WT    DT')                                                      941.
      DO 200 I=1,NRP                                                     942.
      K=I                                                                943.
      IF (KSORT .EQ. 1) K=KEY(I)                                         944.
      KJI=KDX(K)                                                         945.
      TPK=TP(K)-ORG                                                      946.
      IF (TPK .LT. 0.) TPK=TPK+3600.                                     947.
      FMT3(10)=F1                                                        948.
      IF ((AZRES(K).NE.DOT).AND.(AZRES(K).NE.BLANK).AND.                 949.
     1(AZRES(K).NE.ZDOT)) GO TO 114                                      950.
      X(4,K)=BLANK                                                       951.
      FMT3(10)=G1                                                        952.
  114 RMK3=BLANK                                                         953.
      IF (XMAG(K) .EQ. BLANK) GO TO 115                                  954.
      IF (ABS(XMAG(K)-AVXM) .GE. 0.5) RMK3=STAR4                         955.
  115 RMK4=BLANK                                                         956.
      IF (FMAG(K) .EQ. BLANK) GO TO 130                                  957.
      IF (ABS(FMAG(K)-AVFM) .GE. 0.5) RMK4=STAR4                         958.
  130 FMT3(17)=F4                                                        959.
      FMT3(21)=F5                                                        960.
      FMT3(22)=F4                                                        961.
      FMT4(8)=F1                                                         962.
      FMT4(11)=F1                                                        963.
      IF (XMAG(K) .NE. BLANK) GO TO 160                                  964.
      FMT3(17)=G3                                                        965.
      FMT4(8)=G1                                                         966.
  160 IF (FMAG(K) .NE. BLANK) GO TO 162                                  967.
      FMT3(21)=G4                                                        968.
      FMT3(22)=G3                                                        969.
      FMT4(11)=G1                                                        970.
  162 FMT3(26)=F1                                                        971.
      FMT3(28)=F6                                                        972.
      IAZ=AZ(K)+0.5                                                      973.
      IAIN=AIN(K)+0.5                                                    974.
      IAMX=AMX(K)                                                        975.
      IPRX=100.*PRX(K)+0.5                                               976.
      IFMP=FMP(K)                                                        977.
      IF (LDX(K) .NE. 0) GO TO 163                                       978.
C-----CHECK FOR SMP DATA                                                 979.
      IF (KSMP(K) .EQ. 0) GO TO 165                                      980.
      SRES=X(4,K)                                                        981.
      RMK5=BLANK                                                         982.
      SWT=11111.                                                         983.
      TSK=S(K)-P(K)                                                      984.
      GO TO 168                                                          985.
  163 KK=LDX(K)                                                          986.
      SRES=X(4,KK)                                                       987.
      RMK5=WRK(KK)                                                       988.
      SWT=WT(KK)                                                         989.
  164 TSK=TS(K)-ORG                                                      990.
      GO TO 168                                                          991.
  165 S(K)=BLANK                                                         992.
      TSK=BLANK                                                          993.
      SRES=BLANK                                                         994.
      RMK5=BLANK                                                         995.
      SWT=BLANK                                                          996.
      FMT3(26)=G1                                                        997.
      FMT3(28)=G3                                                        998.
  168 FMT3(30)=F1                                                        999.
      DLYK=DLY(KNO,KJI)                                                 1000.
      IF (ISW .EQ. IONE) DLYK=FLT(KNO,KJI)                              1001.
      DTK=DT(K)                                                         1002.
      IF (DTK .NE. 0.) GO TO 170                                        1003.
      DTK=BLANK                                                         1004.
      FMT3(30)=G1                                                       1005.
c170   continue
  170 WRITE(16,FMT3)MSTA(K),DELTA(K),IAZ,IAIN,PRMK(K),JHR,JMIN(K),P(K)   1006.
     1,      TPK,T(K),DLYK,X(4,K),WRK(K),WT(K),IAMX,IPRX,CAL(K)         1007.
     2,KLAS(KJI),XMAG(K),RMK3,RMK(K),IFMP,FMAG(K),RMK4,SRMK(K),S(K)     1008.
     3,TSK,SRES,RMK5,SWT,DTK,IW(KJI)                                    1009.
      IF (IPUN .NE. 2) GO TO 200                                        1010.
      ISEC = 100.*SEC                                                   1011.
C      WRITE(7,FMT4) MSTA(K),DELTA(K),AZ(K),AIN(K),PRMK(K),TPK,X(4,K)	   1012.
C     1,WT(K),XMAG(K),RMK(K),FMAG(K),KDATE,KHR,KMIN,ISEC,KJI,SYM3	       1013.
       PCAL=SEC+T(K)+DLYK
       SCAL=SEC+(T(K)+DLYK)*POS
      WRITE(7,1170) MSTA(K),DELTA(K),IAZ,IAIN,PRMK(K),P(K),PCAL,           
     1 X(4,K),IFMP,SRMK(K),S(K),SCAL,SRES,FMAG(K)                           
	
1170  FORMAT(A4,F8.2,2I4,(1X,A4,3F6.2,2X,I3,1X),(1X,A4,3F6.2,2X,F3.1))
  200 CONTINUE                                                          1014.
      IF (IPUN .NE. 2) GO TO 300                                        1015.
      WRITE(7,205)                                                      1016.
  205 FORMAT(' $$$')                                                    1017.
  300 KHR = JHR                                                         1018.
      ORG = OSAVE                                                       1019.

      RETURN                                                            1020.
      END                                                               1021.
