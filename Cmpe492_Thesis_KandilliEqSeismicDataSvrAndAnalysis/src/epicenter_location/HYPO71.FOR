
	SUBROUTINE HYPO71 

C------- PROGRAM* HYPO71 (DEC. 21, 1971* REVISED NOV. 25, 1973) --------    1.
      INTEGER*2 SYM                                                         2.
      REAL*8 TIME1,TIME2                                                    3.
      character*15 file1,file2,file3

      REAL LAT,LON,LAT2,LON2,LATEP,LONEP,MAG,LATR,LONR                      4.
      COMMON /A3/ NRES(2,1501),NXM(1501),NFM(1501),SR(2,1501),
     1       SRSQ(2,1501),SRWT(2,1501),SXM(1501),                           5.
     1       SXMSQ(1501),SFM(1501),SFMSQ(1501),QNO(4)                       6.
      COMMON /A5/ ZTR,XNEAR,XFAR,POS,IQ,KMS,KFM,IPUN,IMAG,IR,QSPA(9,40)     7.
      COMMON /A6/ NMAX,LMAX,NS,NL,MMAX,NR,FNO,Z,X(4,1501),                  
     1	   ZSQ,NRP,DF(1501)												  
      COMMON /A7/ KP,KZ,KOUT,WT(1501),Y(4),SE(4),XMEAN(4),
     1	   CP(180),SP(180)												 
      COMMON /A8/ CAL(1501),XMAG(1501),FMAG(1501),NM,AVXM,SDXM,NF,AVFM,    10.
     1       SDFM,MAG,KDX(1501),AMX(1501),PRX(1501),CALX(1501),FMP(1501)   11.
      COMMON /A12/ MSTA(1501),PRMK(1501),W(1501),JMIN(1501),P(1501),       12.
     1       RMK(1501),WRK(1501),TP(1501),DT(1501),COSL(701)               13.
      COMMON /A14/ MBK,MDOL,BLANK,MSTAR,DOT,STAR4,QUES,CRMK,MCENT,ISTAR    14.
      COMMON /A15/ M,L,J,ORG,JAV,PMIN,AZRES(1501),NEAR,IDXS,LATEP,LONEP    15.
      COMMON /A17/ TIME1,TIME2,LATR,LONR,KTEST,KAZ,KSORT,KSEL,XFN          16.
      COMMON /A19/ KNO,IELV(1501),TEST(15),FLT(2,1501),                     
     1       MNO(1501),IW(1501)                                            
      COMMON /A21/ KSMP(1501),FMO,ONF,B(4),IPH,KF,AVRPS,IEXIT              18.
      COMMON /A23/ AIN(1501),RMS,ADJ,SYM(1501)                             19.
      COMMON /A25/ INS(1501),IEW(1501),JPH                                 20.


C-----------------------------------------------------------------------   21.
C--- RESET SOME LIMITS OF ERROR HANDLING FACILITY OF IBM FORTH -----       22.
C      CALL ERRSET(207,256,1,0)                                            23.
C      CALL ERRSET(208,256,1,0)                                            24.
C      CALL ERRSET(209,256,1,0)                                            25.
C      CALL ERRSET(251,256,1,0)                                            26.
C      CALL ERRSET(255,256,1,0)                                            27.
C------- SET UP SINE + COSINE TABLES FOR CALCULATING DISTANCES ---------  28.

      file1='1'
	file2='2'
	file3='3'

c     file1 ' HYPO Giris Dosya adi :'
c     file2 ' Ayrintili Bilgi Iceren Cikis Dosyasi...?'

      open(unit=15,file=file1,status='old')
      open(unit=7,file=file2,status='UNKNOWN')
      open(unit=16,file=file3,status='UNKNOWN')

      DO 10 I=1,180                                                       29.
      PI=I*.0349066                                                       30.
      CP(I)=COS(PI)                                                       31.
   10 SP(I)=SIN(PI)                                                       32.
      DO 20 I=1,701                                                       33.
   20 COSL(I)=COS((I-1)*.0017453)                                         34.
   30 M=0                                                                 35.
C------- INPUT STATION LIST, CRUSTAL MODEL, + CONTROL CARD -------------  36.
   40 CALL INPUT1                                                          37.
      IF(IPUN .EQ. 0) GO TO 44                                            38.
      WRITE(7,41) INS(1),IEW(1)                                           39.
   41 FORMAT(' DATE    ORIGIN    LAT ',A1,'    LONG ',A1,'    DEPTH    M  40.
     1AG NO GAP DMIN  RMS  ERH  ERZ QM')                                  21.
C-------- INITIALIZE SUMMARY OF RESIDUALS ------------------------------  42.
   44 DO 48 L=1,NS                                                        43.
      NRES(1,L)=0                                                         44.
      NRES(2,L)=0                                                         45.
      NXM(L)=0                                                            46.
      NFM(L)=0                                                            47.
      SR(1,L)=0.                                                          48.
      SR(2,L)=0.                                                          49.
      SRSQ(1,L)=0.                                                        50.
      SRSQ(2,L)=0.                                                        26.
      SRWT(1,L)=0.                                                        52.
      SRWT(2,L)=0.                                                        53.
      SXM(L)=0.                                                           54.
      SXMSQ(L)=0.                                                         55.
      SFM(L)=0.                                                           56.
      SFMSQ(L)=0.                                                         57.
   48 CONTINUE                                                            58.
      DO 49 I=1,4                                                         59.
   49 QNO(I)=0.                                                           60.
      XFN=XFAR-XNEAR+0.000001                                             61.
      TIME1=0.D+00                                                        62.
   50 CALL INPUT2                                                         63.
C------- TO PROCESS ONE EARTHQUAKE -------------------------------------  64.

      IF (M .EQ. 1) GO TO 900                                             65.
      IF (NR .GE. 1) GO TO 100                                            66.


      GO TO 50                                                            69.
  100 CALL SINGLE                                                         70.
      IF (IEXIT .EQ. 1) GO TO 50                                          71.
C------- COMPUTE SUMMARY OF MAGNITUDE RESIDUALS -----------------------   72.
  110 IF (JAV .GT. IQ) GO TO 50                                           73.
      DO 150 I=1,NRP                                                      74.
      IF  (XMAG(I) .EQ. BLANK) GO TO 120                                  75.
      JI=KDX(I)                                                           76.
      DXMAG=XMAG(I)-AVXM                                                  77.
      NXM(JI)=NXM(JI)+1                                                   78.
      SXM(JI)=SXM(JI)+DXMAG                                               79.
      SXMSQ(JI)=SXMSQ(JI)+DXMAG**2                                        80.
  120 IF  (FMAG(I) .EQ. BLANK) GO TO 150                                  81.
      JI=KDX(I)                                                           82.
      DFMAG=FMAG(I)-AVFM                                                  83.
      NFM(JI)=NFM(JI)+1                                                   84.
      SFM(JI)=SFM(JI)+DFMAG                                               85.
      SFMSQ(JI)=SFMSQ(JI)+DFMAG**2                                        86.
  150 CONTINUE                                                            87.
      GO TO 50                                                            88.
  900 CONTINUE                                                            89.
C------- END OF ONE DATA SET* PRINT SUMMARY OF RESIDUALS + RETURN ------  90.
      CALL SUMOUT                                                         91.
      IF (MSTA(NR+1) .EQ. MSTAR) GO TO 30                                 92.
      M=1                                                                 93.
      IF (MSTA(NR+1) .EQ. MDOL) GO TO 40                                  94.
      M=2                                                                 95.
      IF (MSTA(NR+1) .EQ. MCENT) GO TO 40                                 96.
	close(15)
	close(7)
	close(16)
      return                                                              97.
      END subroutine                                                      98.
