      SUBROUTINE TRVDRV                                                 1858.
C------- COMPUTE TRAVEL TIME AND DERIVATIVES FROM CRUSTAL MODEL --------1859.
      REAL IONE
      REAL IPRO,ISW,ISTTT
      REAL*8 TIME1,TIME2                                                1860.
      REAL LAT,LON,MAG                                                  1861.
      COMMON /A2/ LAT(1501),LON(1501),DELTA(1501),                      
     1	   DX(1501),DY(1501),T(1501)                                  
      COMMON /A6/ NMAX,LMAX,NS,NL,MMAX,NR,FNO,Z,                        
     1       X(4,1501),ZSQ,NRP,DF(1501)			                      
      COMMON /A8/ CAL(1501),XMAG(1501),FMAG(1501),NM,AVXM,SDXM,NF,AVFM, 1864.
     1       SDFM,MAG,KDX(1501),AMX(1501),PRX(1501),
     1       CALX(1501),FMP(1501)                                       1865.
      COMMON /A10/ ANIN(1501),AZ(1501),TEMP(1501),CA(71),CB(71)         1866.
      COMMON /A16/ KLSS(1501),CALS(1501),MDATE(1501),MHRMN(1501),
     1       IPRN,ISW                                                   1867.
      COMMON /A17/ TIME1,TIME2,LATR,LONR,KTEST,KAZ,KSORT,KSEL,XFN       1868.
      COMMON /A19/ KNO,IELV(1501),TEST(15),FLT(2,1501),
     1       MNO(1501),IW(1501)                                         1869.
      COMMON /A20/ V(21),D(21),VSQ(21),THK(21),TID(21,21),DID(21,21)    1870.
      COMMON /A22/ F(21,21),G(4,21),H(21),DEPTH(21),IONE                1871.
      COMMON /A24/ FLTEP,IPRO,ISTTT,ISKP(4),AHEAD(12),FLIM,AF(3),NDEC   1872.
      DIMENSION TINJ(21),DIDJ(21),TR(21)                                1873.
C-----------------------------------------------------------------------1874.
      IF (ISW .EQ. IONE) GO TO 5                                        1875.
C-----INITIALIZATION FOR FIXED LAYER MODEL -----------------------------1876.
      DO  1 L=1,NL                                                      1877.
      IF (D(L) .GT. Z) GO TO  2                                         1878.
    1 CONTINUE                                                          1879.
      JL=NL                                                             1880.
      GO TO  3                                                          1881.
    2 JJ=L                                                              1882.
      JL=L-1                                                            1883.
    3 TKJ=Z-D(JL)                                                       1884.
      TKJSQ=TKJ**2+0.000001                                             1885.
      IF (JL .EQ. NL) GO TO  5                                          1886.
      DO  4 L=JJ,NL                                                     1887.
      SQT=SQRT(ABS(VSQ(L)-VSQ(JL)))                                     1888.
      TINJ(L)=TID(JL,L)-TKJ*SQT/(V(L)*V(JL))                            1889.
    4 DIDJ(L)=DID(JL,L)-TKJ*V(JL)/SQT                                   1890.
      XOVMAX=V(JJ)*V(JL)*(TINJ(JJ)-TID(JL,JL))/(V(JJ)-V(JL))            1891.
    5 DO 300 I=1,NR                                                     1892.
      IF (ISW .NE. IONE) GO TO 45                                       1893.
C-----INITIALIZATION FOR VARIABLE LAYER MODEL --------------------------1894.
      JI=KDX(I)                                                         1895.
      DEPTH(2)=FLT(KNO,JI)                                              1896.
      IF (Z .LT. FLTEP) DEPTH(2)=0.5*(FLT(KNO,JI)+FLTEP)                1897.
      THK(1)=DEPTH(2)                                                   1898.
      THK(2)=D(3)-DEPTH(2)                                              1899.
      DH1=THK(1)-H(1)                                                   1900.
      DH2=THK(2)-H(2)                                                   1901.
      DO 10 L=1,NL                                                      1902.
      IF (DEPTH(L) .GT. Z) GO TO 20                                     1903.
   10 CONTINUE                                                          1904.
      JL=NL                                                             1905.
      GO TO 30                                                          1906.
   20 JJ=L                                                              1907.
      JL=L-1                                                            1908.
   30 TKJ=Z-DEPTH(JL)                                                   1909.
      TKJSQ=TKJ**2+0.000001                                             1910.
      IF (JL .EQ. NL) GO TO 100                                         1911.
C-----CALCULATION FOR REFRACTED WAVES ----------------------------------1912.
      DO 40 L=JJ,NL                                                     1913.
      SQT=SQRT(ABS(VSQ(L)-VSQ(JL)))                                     1914.
      TIX=F(1,JL)*DH1*G(1,L)+F(2,JL)*DH2*G(2,L)+TID(JL,L)               1915.
      DIX=F(1,JL)*DH1*G(3,L)+F(2,JL)*DH2*G(4,L)+DID(JL,L)               1916.
      TINJ(L)=TIX-TKJ*SQT/(V(L)*V(JL))                                  1917.
   40 DIDJ(L)=DIX-TKJ*V(JL)/SQT                                         1918.
      TIX=F(1,JL)*DH1*G(1,JL)+F(2,JL)*DH2*G(2,JL)+TID(JL,JL)            1919.
      XOVMAX=V(JJ)*V(JL)*(TINJ(JJ)-TIX)/(V(JJ)-V(JL))                   1920.
      GO TO 50                                                          1921.
   45 IF (JL .EQ. NL) GO TO 100                                         1922.
   50 DO 60 M=JJ,NL                                                     1923.
   60 TR(M)=TINJ(M)+DELTA(I)/V(M)                                       1924.
      TMIN=999.99                                                       1925.
      DO 70 M=JJ,NL                                                     1926.
      IF (TR(M) .GT. TMIN) GO TO 70                                     1927.
      IF (DIDJ(M) .GT. DELTA(I)) GO TO 70                               1928.
      K=M                                                               1929.
      TMIN=TR(M)                                                        1930.
   70 CONTINUE                                                          1931.
      IF (DELTA(I) .LT. XOVMAX) GO TO 90                                1932.
C-----TRAVEL TIME + DERIVATIVES FOR REFRACTED WAVE                      1933.
   80 T(I)=TR(K)                                                        1934.
      DTDD=1.0/V(K)                                                     1935.
      DTDH=-SQRT(ABS(VSQ(K)-VSQ(JL))/(V(K)*V(JL)))                      1936.
      ANIN(I)=-V(JL)/V(K)                                               1937.
      GO TO 260                                                         1938.
C-----CALCULATION FOR DIRECT WAVE --------------------------------------1939.
   90 IF (JL .NE. 1) GO TO 100                                          1940.
      SQT=SQRT(ABS(ZSQ+DELTA(I)**2))                                    1941.
      TDJ1=SQT/V(1)                                                     1942.
      IF (TDJ1 .GE. TMIN) GO TO 80                                      1943.
C-----TRAVEL TIME + DERIVATIVES FOR DIRECT WAVE IN FIRST LAYER          1944.
      T(I)=TDJ1                                                         1945.
      DTDD=DELTA(I)/(V(1)*SQT)                                          1946.
      DTDH=Z/(V(1)*SQT)                                                 1947.
      ANIN(I)=DELTA(I)/SQT                                              1948.
      GO TO 260                                                         1949.
C-----FIND A DIRECT WAVE THAT WILL EMERGE AT THE STATION                1950.
  100 XBIG=DELTA(I)                                                     1951.
      XLIT=DELTA(I)*TKJ/Z                                               1952.
      UB=XBIG/SQRT(ABS(XBIG**2+TKJSQ))                                  1953.
      UL=XLIT/SQRT(ABS(XLIT**2+TKJSQ))                                  1954.
      UBSQ=UB**2                                                        1955.
      ULSQ=UL**2                                                        1956.
      DELBIG=TKJ*UB/SQRT(ABS(1.000001-UBSQ))                            1957.
      DELLIT=TKJ*UL/SQRT(ABS(1.000001-ULSQ))                            1958.
      J1=JL-1                                                           1959.
      DO 110 L=1,J1                                                     1960.
      DELBIG=DELBIG+(THK(L)*UB)/SQRT(ABS(VSQ(JL)/VSQ(L)-UBSQ))          1961.
  110 DELLIT=DELLIT+(THK(L)*UL)/SQRT(ABS(VSQ(JL)/VSQ(L)-ULSQ))          1962.
      DO 170 LL=1,25                                                    1963.
      IF (DELBIG-DELLIT .LT. 0.02) GO TO 180                            1964.
      XTR=XLIT+(DELTA(I)-DELLIT)*(XBIG-XLIT)/(DELBIG-DELLIT)            1965.
      U=XTR/SQRT(ABS(XTR**2+TKJSQ))                                     1966.
      USQ=U**2                                                          1967.
      DELXTR=TKJ*U/SQRT(ABS(1.000001-USQ))                              1968.
      DO 120 L=1,J1                                                     1969.
  120 DELXTR=DELXTR+(THK(L)*U)/SQRT(ABS(VSQ(JL)/VSQ(L)-USQ))            1970.
      XTEST=DELTA(I)-DELXTR                                             1971.
      IF (ABS(XTEST) .LE. 0.02) GO TO 190                               1972.
      IF (XTEST) 140,190,150                                            1973.
  140 XBIG=XTR                                                          1974.
      DELBIG=DELXTR                                                     1975.
      GO TO 160                                                         1976.
  150 XLIT=XTR                                                          1977.
      DELLIT=DELXTR                                                     1978.
  160 IF (LL .LT. 10) GO TO 170                                         1979.
      IF (1.0-U .LT. 0.0002) GO TO 190                                  1980.
  170 CONTINUE                                                          1981.
  180 XTR=0.5*(XBIG+XLIT)                                               1982.
      U=XTR/SQRT(XTR**2+TKJSQ)                                          1983.
      USQ=U**2                                                          1984.
  190 IF (1.0-U .GT. 0.0002) GO TO 220                                  1985.
C-----IF U IS TOO NEAR 1, COMPUTE TDIR AS WAVE ALONG THE TOP OF LAYER JL1986.
      IF (ISW .EQ. IONE) GO TO 195                                      1987.
      TDC=TID(JL,JL)+DELTA(I)/V(JL)                                     1988.
      GO TO 200                                                         1989.
  195 TIX=F(1,JL)*DH1*G(1,JL)+F(2,JL)*DH2*G(2,JL)+TID(JL,JL)            1990.
      TDC=TIX+DELTA(I)/V(JL)                                            1991.
  200 IF (JL .EQ. NL) GO TO 210                                         1992.
      IF (TDC .GE. TMIN) GO TO 80                                       1993.
  210 T(I)=TDC                                                          1994.
      DTDD=1.0/V(JL)                                                    1995.
      DTDH=0.0                                                          1996.
      ANIN(I)=0.9999999                                                 1997.
      GO TO 260                                                         1998.
C-----TRAVEL TIME + DERIVATIVES FOR DIRECT WAVE BELOW FIRST LAYER       1999.
  220 TDIR=TKJ/(V(JL)*SQRT(ABS(1.0-USQ)))                               2000.
      DO 240 L=1,J1                                                     2001.
  240 TDIR=TDIR+(THK(L)*V(JL))/(VSQ(L)*SQRT(ABS(VSQ(JL)/VSQ(L)-USQ)))   2002.
      IF (JL .EQ. NL) GO TO 245                                         2003.
      IF (TDIR .GE. TMIN) GO TO 80                                      2004.
  245 T(I)=TDIR                                                         2005.
      SRR=SQRT(ABS(1.-USQ))                                             2006.
      SRT=SRR**3                                                        2007.
      ALFA=TKJ/SRT                                                      2008.
      BETA=TKJ*U/(V(JL)*SRT)                                            2009.
      DO 250 L=1,J1                                                     2010.
      STK=(SQRT(ABS(VSQ(JL)/VSQ(L)-USQ)))**3                            2011.
      VTK=THK(L)/(VSQ(L)*STK)                                           2012.
      ALFA=ALFA+VTK*VSQ(JL)                                             2013.
  250 BETA=BETA+VTK*V(JL)*U                                             2014.
      DTDD=BETA/ALFA                                                    2015.
      DTDH=(1.0-V(JL)*U*DTDD)/(V(JL)*SRR)                               2016.
      ANIN(I)=U                                                         2017.
C-----SET UP PARTIAL DERIVATIVES FOR REGRESSION ANALYSIS ---------------2018.
  260 X(1,I)=-DTDD*DX(I)/DELTA(I)                                       2019.
      X(2,I)=-DTDD*DY(I)/DELTA(I)                                       2020.
      X(3,I)=DTDH                                                       2021.
  300 CONTINUE                                                          2022.
      RETURN                                                            2023.
      END                                                               2024.
