      SUBROUTINE SUMOUT                                                 1527.
C------- OUTPUT SUMMARY OF TIME AND MAGNITUDE RESIDUALS ----------------1528.
      REAL LAT,LON,LAT2,LON2                                            1529.
      COMMON /A1/ NSTA(1501),DLY(2,1501),FMGC(1501),XMGC(1501),         1530.
     1       KLAS(1501),PRR(1501),CALR(1501),ICAL(1501),IS(1501),
     1       NDATE(1501),NHRMN(1501)                                    1531.
      COMMON /A2/ LAT(1501),LON(1501),DELTA(1501),
     1       DX(1501),DY(1501),T(1501)                                  1532.
      COMMON /A3/ NRES(2,1501),NXM(1501),NFM(1501),SR(2,1501),          1533.
     1       SRSQ(2,1501),SRWT(2,1501),SXM(1501),SXMSQ(1501),
     1       SFM(1501),SFMSQ(1501),QNO(4)                               1534.
      COMMON /A5/ ZTR,XNEAR,XFAR,POS,IQ,KMS,KFM,IPUN,IMAG,IR,QSPA(9,40) 1535.
      COMMON /A6/ NMAX,LMAX,NS,NL,MMAX,NR,FNO,Z,
     1       X(4,1501),ZSQ,NRP,DF(1501)                                 1536.
      COMMON /A16/ KLSS(1501),CALS(1501),MDATE(1501),MHRMN(1501),
     1       IPRN,ISW                                                   1537.
      COMMON /A19/ KNO,IELV(1501),TEST(15),FLT(2,1501),
     1       MNO(1501),IW(1501)                                         1538.
      COMMON /A22/ F(21,21),G(4,21),H(21),DEPTH(21),IONE                1539.
      COMMON /A25/ INS(1501),IEW(1501),JPH                              1540.
      DIMENSION AVRES(4,1501),SDRES(4,1501)                             1541.
      DATA KS1,KW1/'S','W'/                                             1542.
C-----------------------------------------------------------------------1543.
      QSUM=QNO(1)+QNO(2)+QNO(3)+QNO(4)                                  1544.
      IF (QSUM .EQ. 0.) GO TO 72                                        1545.
      WRITE(16,5) (QNO(I),I=1,4),QSUM                                   1546.
    5 FORMAT(1H1,' ***** CLASS*     A     B     C     D TOTAL *****'    1547.
     1,//,7X,'NUMBER*',5F6.1)                                           1548.
      DO 10 I=1,4                                                       1549.
   10 QNO(I)=100.*QNO(I)/QSUM                                           1550.
      WRITE(16,15)(QNO(I),I=1,4)                                         1551.
   15 FORMAT(/,12X,'(*',4F6.1)                                          1552.
      WRITE(16,20)                                                       1553.
   20 FORMAT(///,10X,'TRAVELTIME RESIDUALS (MODEL=1)',5X                1554.
     1,'TRAVELTIME RESIDUALS (MODEL=2)',5X,'X-MAGNITUDE RESIDUALS'      1555.
     2,6X,'F-MAGNITUDE RESIDUALS',/,' STATION   NRES    SRWT   AVRES   S1556.
     3DRES       NRES    SRWT   AVRES   SDRES        NXM    AVXM    SDXM1557.
     4        NFM    AVFM    SDFM')                                     1558.
      DO 70 I=1,NS                                                      1559.
      DO 30 J=1,4                                                       1560.
      AVRES(J,I)=0.                                                     1561.
   30 SDRES(J,I)=0.                                                     1562.
      IF (NRES(1,I) .EQ. 0) GO TO 35                                    1563.
      AVRES(1,I)=SR(1,I)/SRWT(1,I)                                      1564.
      SDRES(1,I)=SQRT(ABS(SRSQ(1,I)/SRWT(1,I)-AVRES(1,I)**2+0.000001))  1565.
   35 IF (NRES(2,I) .EQ. 0) GO TO 40                                    1566.
      AVRES(2,I)=SR(2,I)/SRWT(2,I)                                      1567.
      SDRES(2,I)=SQRT(ABS(SRSQ(2,I)/SRWT(2,I)-AVRES(2,I)**2+0.000001))  1568.
   40 IF (NXM(I) .EQ. 0) GO TO 50                                       1569.
      AVRES(3,I)=SXM(I)/NXM(I)                                          1570.
      SDRES(3,I)=SQRT(ABS(SXMSQ(I)/NXM(I)-AVRES(3,I)**2+0.000001))      1571.
   50 IF (NFM(I) .EQ. 0) GO TO 60                                       1572.
      AVRES(4,I)=SFM(I)/NFM(I)                                          1573.
      SDRES(4,I)=SQRT(ABS(SFMSQ(I)/NFM(I)-AVRES(4,I)**2+0.000001))      1574.
c60    continue
   60 WRITE(16,65) NSTA(I),NRES(1,I),SRWT(1,I),AVRES(1,I),SDRES(1,I)    1575.
     1,NRES(2,I),SRWT(2,I),AVRES(2,I),SDRES(2,I),NXM(I),AVRES(3,I)      1576.
     2,SDRES(3,I),NFM(I),AVRES(4,I),SDRES(4,I)                          1577.
   65 FORMAT(4X,A4,2X,I5,3F8.2,6X,I5,3F8.2,2(6X,I5,2F8.2))              1578.
   70 CONTINUE                                                          1579.
   72 IF (IPUN .NE. 3) GO TO 200                                        1580.
C------- PUNCH STATION LIST WITH REVISED DELAYS,XMGC,AND FMGC ----------1881.
      IF (ISW .EQ. IONE) GO TO 80                                       1582.
      WRITE(16,75) INS(1),IEW(1)                                         1583.
   75 FORMAT(1H1,' ***** NEW STATION LIST *****'                        1584.
     1,///,    4X,'I   STN  LAT ',A1,'    LONG ',A1,'   ELV DELAY',5X   1585.
     2,'FMGC  XMGC KL  PRR  CALR IC IS   DATE HRMN')                    1586.
      GO TO 90                                                          1587.
c80    continue
   80 WRITE(16,85) INS(1),IEW(1)                                         1588.
   85 FORMAT(1H1,' ***** NEW STATION LIST *****'                        1589.
     1,///,4X,'I   STN   LAT ',A1,'     LONG ',A1,'    ELV     M  DLY1  1590.
     2DLY2  XMGC  FMGC K  CALR IC  DATE HRMN')                          1591.
   90 DO 120 I=1,NS                                                     1592.
      DLY(1,I)=DLY(1,I)+AVRES(1,I)                                      1593.
      IF (ISW.EQ.IONE) DLY(2,I)=DLY(2,I)+AVRES(2,I)                     1594.
      XMGC(I)=XMGC(I)+AVRES(3,I)                                        1595.
      FMGC(I)=FMGC(I)+AVRES(4,I)                                        1596.
      LAT1=LAT(I)/60.                                                   1597.
      LAT2=LAT(I)-60.*LAT1                                              1598.
      LON1=LON(I)/60.                                                   1599.
      LON2=LON(I)-60.*LON1                                              1600.
      IF (ISW .EQ. IONE) GO TO 115                                      1601.
      WRITE(16,105) I,NSTA(I),LAT1,LAT2,INS(I),LON1,LON2,IEW(I),IELV(I)  1602.
     1,DLY(1,I),FMGC(I),XMGC(I),KLSS(I),PRR(I),CALS(I),ICAL(I),NDATE(I) 1603.
     2,NHRMN(I)                                                         1604.
  105 FORMAT(I5,2X,A4,I2,F5.2,A1,I4,F5.2,A1,I5,F6.2,4X,F5.2,2X,F5.2,I2  1605.
     1,1X,F4.2,1X,F6.2,I2,5X,I6,I4)                                     1606.
      WRITE(7,110)   NSTA(I),LAT1,LAT2,INS(I),LON1,LON2,IEW(I),IELV(I)  1607.
     1,DLY(1,I),FMGC(I),XMGC(I),KLSS(I),PRR(I),CALS(I),ICAL(I),NDATE(I) 1608.
     2,NHRMN(I)                                                         1609.
  110 FORMAT(2X,A4,I2,F5.2,A1,I3,F5.2,A1,I4,F6.2,T38,F5.2,T45,F5.2      1610.
     1,I2,1X,F4.2,1X,F6.2,I2,T71,I6,I4)                                 1611.
      GO TO 120                                                         1612.
c115    continue
  115 WRITE(16,116) I,NSTA(I),LAT1,LAT2,INS(I),LON1,LON2,IEW(I),IELV(I)  1613.
     1,MNO(I),DLY(1,I),DLY(2,I),XMGC(I),FMGC(I),KLSS(I),CALS(I),ICAL(I) 1614.
     2,NDATE(I),NHRMN(I)                                                1615.
  116 FORMAT(I5,2X,A4,I3,'-',F5.2,A1,I4,'-',F5.2,A1,I5,I6,2F6.2         1616.
     1,2F6.2,I2,F6.2,I2,2X,I6,I4)                                       1617.
      WRITE(7,117)   NSTA(I),LAT1,LAT2,INS(I),LON1,LON2,IEW(I),IELV(I)  1618.
     1,MNO(I),DLY(1,I),DLY(2,I),XMGC(I),FMGC(I),KLSS(I),CALS(I),ICAL(I) 1619.
     2,NDATE(I),NHRMN(I)                                                1620.
  117 FORMAT(A4,I3,'-',F5.2,A1,I3,'-',F5.2,A1,I4,I6,2F6.2               1621.
     1,2F6.2,I2,F6.2,I2,2X,I6,I4)                                       1622.
  120 CONTINUE                                                          1623.
      RETURN                                                            1624.
C------- PUNCH STATION LIST WITH REVISED CALIBRATIONS ------------------1625.
  200 IF (IPUN .NE. 4) RETURN                                           1626.
      IF (ISW .EQ. IONE) GO TO 205                                      1627.
      WRITE(16,75) INS(1),IEW(1)                                         1628.
      GO TO 206                                                         1629.
c205     continue
  205 WRITE(16,85) INS(1),IEW(1)                                         1630.
  206 DO 220 I=1,NS                                                     1631.
      LAT1=LAT(I)/60.                                                   1632.
      LAT2=LAT(I)-60.*LAT1                                              1633.
      LON1=LON(I)/60.                                                   1634.
      LON2=LON(I)-60.*LON1                                              1635.
      IF (ISW .EQ. IONE) GO TO 210                                      1636.
      WRITE(16,105) I,NSTA(I),LAT1,LAT2,INS(I),LON1,LON2,IEW(I),IELV(I)  1637.
     1,DLY(1,I),FMGC(I),XMGC(I),KLAS(I),PRR(I),CALR(I),ICAL(I),MDATE(I) 1638.
     2,MHRMN(I)                                                         1639.
      WRITE(7,110)   NSTA(I),LAT1,LAT2,INS(I),LON1,LON2,IEW(I),IELV(I)  1640.
     1,DLY(1,I),FMGC(I),XMGC(I),KLAS(I),PRR(I),CALR(I),ICAL(I),MDATE(I) 1641.
     2,MHRMN(I)                                                         1642.
      GO TO 220                                                         1643.
c210    continue
  210 WRITE(16,116) I,NSTA(I),LAT1,LAT2,INS(I),LON1,LON2,IEW(I),IELV(I)  1644.
     1,MNO(I),DLY(1,I),DLY(2,I),XMGC(I),FMGC(I),KLAS(I),CALR(I),ICAL(I) 1645.
     2,MDATE(I),MHRMN(I)                                                1646.
      WRITE(7,117)   NSTA(I),LAT1,LAT2,INS(I),LON1,LON2,IEW(I),IELV(I)  1647.
     1,MNO(I),DLY(1,I),DLY(2,I),XMGC(I),FMGC(I),KLAS(I),CALR(I),ICAL(I) 1648.
     2,MDATE(I),MHRMN(I)                                                1649.
  220 CONTINUE                                                          1650.
      RETURN                                                            1651.
      END                                                               1652.
