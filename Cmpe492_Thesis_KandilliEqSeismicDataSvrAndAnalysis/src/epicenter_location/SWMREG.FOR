      SUBROUTINE SWMREG                                                 1653.
C------- COMPUTE GEIGER ADJUSTMENTS BY STEP-WISE MULTIPLE REGRESSION OF 1654.
C        TRAVEL TIME RESIDUALS -----------------------------------------1655.
      REAL IPRO,ISW,ISTTT
      REAL*8 ENT,ELM,FMT                                                1656.
      COMMON /A6/ NMAX,LMAX,NS,NL,MMAX,NR,FNO,Z,
     1       X(4,1501),ZSQ,NRP,DF(1501)                                 1657.
      COMMON /A7/ KP,KZ,KOUT,W(1501),Y(4),BSE(4),XMEAN(4),
     1       CP(180),SP(180)                                            1658.
      COMMON /A16/ KLSS(1501),CALS(1501),MDATE(1501),MHRMN(1501),
     1       IPRN,ISW                                                   1659.
      COMMON /A19/ KNO,IELV(1501),TEST(15),FLT(2,1501),
     1       MNO(1501),IW(1501)                                         1660.
      COMMON /A21/ KSMP(1501),FMO,ONF,B(4),IPH,KF,AVRPS,IEXIT           1661.
      COMMON /A24/ FLTEP,IPRO,ISTTT,ISKP(4),AHEAD(12),FLIM,AF(3),NDEC   1662.
      DIMENSION XSUM(4),SIGMA(4),IDX(4),V(3),PF(3),A(7,7),T(7,7),S(4,4) 1663.
      DATA L,M,MM,M1/3,4,7,5/,ENT,ELM/'ENTERING','LEAVING.'/            1664.
C-----------------------------------------------------------------------1665.
      KFLAG=0                                                           1666.
      SVTEST = TEST(3)                                                  1667.
      ONF=0.0                                                           1668.
      FLIM = TEST(3)                                                    1669.
      DO 2 I=1,3                                                        1670.
      AF(I)=-1.00                                                       1671.
    2 CONTINUE                                                          1672.
      DO 5 I=1,NR                                                       1673.
      ONF=ONF + W(I)*(1-KSMP(I))                                        1674.
    5 CONTINUE                                                          1675.
      DO 10 I=1,MM                                                      1676.
      DO 10 J=1,MM                                                      1677.
   10 A(I,J)=0.                                                         1678.
C-----COMPUTE MEANS,STANDARD DEVIATIONS,AND CORRECTED SUMS OF SQUARE    1679.
      DO 40 I=1,M                                                       1680.
      XSUM(I)=0.                                                        1681.
      XMEAN(I)=0.                                                       1682.
      DO 40 J=1,M                                                       1683.
   40 S(I,J)=0.                                                         1684.
      DO 50 K=1,NR                                                      1685.
      DO 50 I=1,M                                                       1686.
      TEMP=X(I,K)*W(K)                                                  1687.
      ETMP=TEMP*(1-KSMP(K))                                             1688.
      XSUM(I)=XSUM(I)+ETMP                                              1689.
      DO 50 J=I,M                                                       1690.
   50 S(I,J)=S(I,J)+TEMP*X(J,K)                                         1691.
      DO 70 I=1,M                                                       1692.
      IF (ONF .EQ. 0.) GO TO 65                                         1693.
      XMEAN(I)=XSUM(I)/ONF                                              1694.
      DO 60 J=I,M                                                       1695.
   60 S(I,J)=S(I,J)-XSUM(I)*XSUM(J)/ONF                                 1696.
   65 A(I,I)=1.                                                         1697.
      IF (S(I,I) .LT. 0.000001) S(I,I)=0.000001                         1698.
      SIGMA(I)=SQRT(ABS(S(I,I)))                                        1699.
   70 CONTINUE                                                          1700.
C-----COMPUTE AND AUGMENT CORRELATION MATRIX A                          1701.
      DO 80 I=1,L                                                       1702.
      I1=I+1                                                            1703.
      DO 80 J=I1,M                                                      1704.
      A(I,J)=S(I,J)/(SIGMA(I)*SIGMA(J))                                 1705.
   80 A(J,I)=A(I,J)                                                     1706.
      PHI=FNO-1.                                                        1707.
      DO 120 I=M1,MM                                                    1708.
      A(I-M,I)=1.                                                       1709.
  120 A(I,I-M)=-1.                                                      1710.
  130 DO 140 I=1,M                                                      1711.
      B(I)=0.                                                           1712.
      Y(I)=0.                                                           1713.
      BSE(I)=0.                                                         1714.
  140 IDX(I)=0                                                          1715.
      IF (IPRN .LT. 3) GO TO 150                                        1716.
      WRITE(16,45)                                                       1717.
   45 FORMAT(///, '***** DATA *****',//,4X,'K',8X,'W'                   1718.
     1,14X,'X1',14X,'X2',14X,'X3',14X,'X4',/)                           1719.
      DO 47 K=1,NR                                                      1720.
      WRITE(16,46) K,W(K),(X(I,K),I=1,M)                                 1721.
   46 FORMAT(I5,8E16.8)                                                 1722.
   47 CONTINUE                                                          1723.
      WRITE(16,75) (XMEAN(I),I=1,M)                                      1724.
   75 FORMAT(/,' MEAN',16X,8E16.8)                                      1725.
      WRITE(16,76) (SIGMA(I),I=1,M)                                      1726.
   76 FORMAT(/,' SIGMA',15X,7E16.8)                                     1727.
      WRITE(16,77)                                                       1728.
   77 FORMAT(///,' ***** CORRECTED SUMS OF SQUARES MATRIX *****',/)     1729.
      DO 78 I=1,M                                                       1730.
c78     continue
   78 WRITE(16,95) (S(I,J),J=1,M)                                        1731.
      WRITE(16,85)                                                       1732.
   85 FORMAT(///,' ***** CORRELATION MATRIX R *****',/)                 1733.
      DO 90 I=1,M                                                       1734.
c90     continue
   90 WRITE(16,95) (A(I,J),J=1,M)                                        1735.
   95 FORMAT(7E18.8)                                                    1736.
C-----STEPWISE MULTIPLE REGRESSION                                      1737.
      WRITE(16,125) NR,L,TEST(3)                                         1738.
  125 FORMAT(///, '********** STEPWISE MULTIPLE REGRESSION ANALYSIS'    1739.
     1,' **********',//' NUMBER OF DATA....................',I5         1740.
     2,              /,' NUMBER OF INDEPENDENT VARIABLES...',I5         1741.
     3,              /,' CRITICAL F-VALUE..................',F8.2)      1742.
  150 DO 300 NSTEP=1,L                                                  1743.
      NU=0                                                              1744.
      MU=0                                                              1745.
      IF (IPRN .LT. 3) GO TO 155                                        1746.
      WRITE(16,154) NSTEP,KZ,KF                                          1747.
  154 FORMAT(//,' ***** STEP NO.',I2,' *****',5X,'KZ =',I2,5X,'KF =',I2)1748.
C-----FIND VARIABLE TO ENTER REGRESSION                                 1749.
  155 VMAX=0.                                                           1750.
      MAX=NSTEP                                                         1751.
      DO 160 I=1,L                                                      1752.
      IF(ISKP(I).EQ.1) GO TO 160                                        1753.
      IF (IDX(I) .EQ. 1) GO TO 160                                      1754.
      IF ((I.EQ.3).AND.(KZ.EQ.1)) GO TO 160                             1755.
      V(I)=A(I,M)*A(M,I)/A(I,I)                                         1756.
      IF (V(I) .LE. VMAX) GO TO 160                                     1757.
      VMAX=V(I)                                                         1758.
      MAX=I                                                             1759.
  160 CONTINUE                                                          1760.
      F=0.0                                                             1761.
      IF(VMAX.EQ.0.0) GO TO 163                                         1762.
      F=(PHI-1.)*VMAX/(A(M,M)-VMAX)                                     1763.
      IF(F .GE. 1000.) F=999.99                                         1764.
  163 AF(MAX)=F                                                         1765.
      IF(KF .GE. 2) GO TO 165                                           1766.
      IF (F .LT. TEST(3)) GO TO 400                                     1767.
  165 IF ((MAX.EQ.3).AND.(KZ.EQ.1)) GO TO 300                           1768.
  166 NU=MAX                                                            1769.
      IDX(NU)=1                                                         1770.
      PHI=PHI-1.                                                        1771.
C-----COMPUTE MATRIX T FOR THE ENTRANCE OF VARIABLE X(NU)               1772.
      DO 170 J=1,MM                                                     1773.
  170 T(NU,J)=A(NU,J)/A(NU,NU)                                          1774.
      DO 180 I=1,MM                                                     1775.
      IF (I .EQ. NU) GO TO 180                                          1776.
      DO 175 J=1,MM                                                     1777.
  175 T(I,J)=A(I,J)-A(I,NU)*A(NU,J)/A(NU,NU)                            1778.
  180 CONTINUE                                                          1779.
      DO 190 I=1,MM                                                     1780.
      DO 190 J=1,MM                                                     1781.
  190 A(I,J)=T(I,J)                                                     1782.
      DO 200 I=1,L                                                      1783.
      IF (IDX(I) .EQ. 0) GO TO 200                                      1784.
      IF (ABS(A(M,M)*A(I+M,I+M)) .LT. .000001 ) GO TO 195               1785.
      PF(I)=PHI*A(I,M)**2/(A(M,M)*A(I+M,I+M))                           1786.
      IF(PF(I) .GE. 1000.0) PF(I)=999.99                                1787.
      AF(I) = PF(I)                                                     1788.
      GO TO 200                                                         1789.
  195 PF(I) = 999.99                                                    1790.
  200 CONTINUE                                                          1791.
      IF (IPRN .LT. 3) GO TO 210                                        1792.
      CALL ANSWER(A,S,XMEAN,SIGMA,IDX,PHI,L,M,MM,PF,NU,ENT)             1793.
  210 IF (KF .EQ. 2) GO TO 300                                          1794.
      IF(KF .GE. 3) GO TO 450                                           1795.
C-----FIND VARIABLE TO LEAVE REGRESSION                                 1796.
      DO 250 K=1,L                                                      1797.
      IF (IDX(K) .EQ. 0) GO TO 250                                      1798.
      IF (PF(K) .GE. TEST(3)) GO TO 250                                 1799.
      MU=K                                                              1800.
      F=PF(MU)                                                          1801.
      IDX(MU)=0                                                         1802.
      PHI=PHI+1.                                                        1803.
      DO 220 J=1,MM                                                     1804.
  220 T(MU,J)=A(MU,J)/A(MU+M,MU+M)                                      1805.
      DO 230 I=1,MM                                                     1806.
      IF (I .EQ. MU) GO TO 230                                          1807.
      DO 225 J=1,MM                                                     1808.
      IF (J .EQ. MU) GO TO 225                                          1809.
      T(I,J)=A(I,J)-A(I,MU+M)*A(MU+M,J)/A(MU+M,MU+M)                    1810.
  225 CONTINUE                                                          1811.
  230 CONTINUE                                                          1812.
      DO 240 I=1,MM                                                     1813.
      IF (I .EQ. MU) GO TO 240                                          1814.
      T(I,MU)=A(I,MU)-A(I,MU+M)/A(MU+M,MU+M)                            1815.
  240 CONTINUE                                                          1816.
      DO 245 I=1,MM                                                     1817.
      DO 245 J=1,MM                                                     1818.
  245 A(I,J)=T(I,J)                                                     1819.
      IF (IPRN .LT. 3) GO TO 250                                        1820.
      CALL ANSWER(A,S,XMEAN,SIGMA,IDX,PHI,L,M,MM,PF,MU,ELM)             1821.
  250 CONTINUE                                                          1822.
  300 CONTINUE                                                          1823.
C-----CHECK TERMINATION CONDITION                                       1824.
  400 KOUT=0                                                            1825.
      DO 410 I=1,L                                                      1826.
  410 KOUT=KOUT+IDX(I)                                                  1827.
      B(4)=XMEAN(M)                                                     1828.
      IF (KOUT .NE. 0) GO TO 450                                        1829.
      IF(KF .NE. 1) GO TO 420                                           1830.
      KF = 3                                                            1831.
      GO TO 150                                                         1832.
  420 TEST(3)= TEST(3)/TEST(6)                                          1833.
      FLIM=TEST(3)                                                      1834.
      KF=1                                                              1835.
      KFLAG = 0                                                         1836.
      IF(TEST(6) .GT. 1.) GO TO 150                                     1837.
      KFLAG = 1                                                         1838.
      KF = 4                                                            1839.
      GO TO 150                                                         1840.
C-----COMPUTE REGRESSION CONSTANT,COEFFICIENTS,AND STANDARD ERRORS      1841.
  450 YSE=77.7                                                          1842.
      IF (PHI .GE. 1) YSE=SIGMA(M)*SQRT(ABS(A(M,M)/PHI))                1843.
      DO 500 I=1,L                                                      1844.
      IF (IDX(I) .EQ. 0) GO TO 500                                      1845.
      B(I)=A(I,M)*SQRT(ABS(S(M,M)/S(I,I)))                              1846.
      BSE(I)=YSE*SQRT(ABS(A(I+M,I+M)/S(I,I)))                           1847.
      IF(KF .NE. 3) Y(I)=B(I)                                           1848.
      IF(KFLAG .EQ. 0) GO TO 480                                        1849.
      IF(ABS(B(I)) .LE. TEST(6)*BSE(I)) Y(I)=0.                         1850.
  480 IF(PHI .LT. 1.) BSE(I) = 0.                                       1851.
      B(4)=B(4)-Y(I)*XMEAN(I)                                           1852.
  500 CONTINUE                                                          1853.
      IF(KF .NE. 3) Y(4)=B(4)                                           1854.
      TEST(3)=SVTEST                                                    1855.
      RETURN                                                            1856.
      END                                                               1857.
