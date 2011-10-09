      SUBROUTINE MISING                                                  677.
C------- CHECK MISSING STATIONS ---------------------------------------- 678.
      REAL*8 TIME1,TIME2                                                 679.
      REAL LAT,LON,LAT2,LON2,LATEP,LONEP,MAG                             680.
      COMMON /A1/ NSTA(1501),DLY(2,1501),FMGC(1501),XMGC(1501),          681.
     1       KLAS(1501),PRR(1501),CALR(1501),ICAL(1501),IS(1501),
     1       NDATE(1501),NHRMN(1501)                                     682.
      COMMON /A2/ LAT(1501),LON(1501),DELTA(1501),
     1       DX(1501),DY(1501),T(1501)                                   683.
      COMMON /A5/ ZTR,XNEAR,XFAR,POS,IQ,KMS,KFM,IPUN,IMAG,IR,QSPA(9,40)  684.
      COMMON /A6/ NMAX,LMAX,NS,NL,MMAX,NR,FNO,Z,
     1       X(4,1501),ZSQ,NRP,DF(1501)                                  685.
      COMMON /A7/ KP,KZ,KOUT,WT(1501),Y(4),SE(4),XMEAN(4),
     1       CP(180),SP(180)                                             686.
      COMMON /A8/ CAL(1501),XMAG(1501),FMAG(1501),NM,AVXM,SDXM,NF,AVFM,  687.
     1       SDFM,MAG,KDX(1501),AMX(1501),PRX(1501),CALX(1501),FMP(1501) 688.
      COMMON /A10/ ANIN(1501),AZ(1501),TEMP(1501),CA(71),CB(71)          689.
      COMMON /A11/ KDATE,KHR,KMIN,SEC,LAT1,LAT2,LON1,LON2,RMK1,RMK2,     690.
     1       IGAP,DMIN,RMSSQ,ERH,Q,QS,QD,ADJSQ,INST,AVR,AAR,NI,KNST,JHR  691.
      COMMON /A12/ MSTA(1501),PRMK(1501),W(1501),JMIN(1501),P(1501),     692.
     1       RMK(1501),WRK(1501),TP(1501),DT(1501),COSL(701)             693.
      COMMON /A13/ JDX(1501),LDX(1501),KEY(1501),CLASS(4)                694.
      COMMON /A14/ MBK,MDOL,BLANK,MSTAR,DOT,STAR4,QUES,CRMK,MCENT,ISTAR  695.
      COMMON /A15/ M,L,J,ORG,JAV,PMIN,AZRES(1501),NEAR,IDXS,LATEP,LONEP  696.
      COMMON /A25/ INS(1501),IEW(1501),JPH                               697.
      DATA KS1,KW1/'S','W'/                                              698.
C----------------------------------------------------------------------- 699.
      IHD=0                                                              700.
      NJ=J+1                                                             701.
      TEMP(NJ)=TEMP(1)+360.                                              702.
      TDEL=25.*MAG**2                                                    703.
      IF (MAG .EQ. BLANK) TDEL=100.                                      704.
      DO 30 I=1,NS                                                       705.
      IF (JDX(I) .EQ. 1) GO TO 30                                        706.
      AVL=(LAT(I)+LATEP)/120.                                            707.
      M1=AVL+1.5                                                         708.
      M2=AVL*10.+1.5                                                     709.
      DXI=(LON(I)-LONEP)*CA(M1)*COSL(M2)                                 710.
      DYI=(LAT(I)-LATEP)*CB(M1)                                          711.
      DELI=SQRT(ABS(DXI**2+DYI**2)+0.000001)                             712.
      IF (DELI .GT. TDEL) GO TO 30                                       713.
C     CHECK LATITUDE AND LONGITUDE                                       714.
      IF (INS(I)  .EQ. KS1) DYI=-DYI                                     715.
      IF (IEW(I)  .EQ. KW1) DXI=-DXI                                     716.
      AZI=AMOD(ATAN2(DXI,DYI)*57.29578 + 360., 360.)                     717.
      IF (AZI .LE. TEMP(1)) AZI=AZI+360.                                 718.
      DO 10 J=2,NJ                                                       719.
      IF (AZI .LT. TEMP(J)) GO TO 20                                     720.
   10 CONTINUE                                                           721.
      J=NJ                                                               722.
   20 EXGAP=TEMP(J)-TEMP(J-1)                                            723.
      RDGAP=TEMP(J)-AZI                                                  724.
      TGAP=AZI-TEMP(J-1)                                                 725.
      IF (TGAP .LT. RDGAP) RDGAP=TGAP                                    726.
      IF ((DELI.GT.DMIN).AND.(RDGAP.LT.30.)) GO TO 30                    727.
      IF (AZI .GE. 360.) AZI=AZI-360.                                    728.
      IF (IHD .EQ. 1) GO TO 22                                           729.
      WRITE(16,5)                                                         730.
    5 FORMAT(/,10X,'MISSING STATION  DELTA   AZIM  EX-GAP  RD-GAP')      731.
      IHD=1                                                              732.
c22     continue
   22 WRITE(16,25) NSTA(I),DELI,AZI,EXGAP,RDGAP                           733.
   25 FORMAT(21X,A4,2F7.1,2F8.1)                                         734.
   30 CONTINUE                                                           735.
      RETURN                                                             736.
      END                                                                737.
