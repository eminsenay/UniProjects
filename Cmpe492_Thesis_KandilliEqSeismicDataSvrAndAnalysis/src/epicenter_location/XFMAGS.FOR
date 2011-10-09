
      SUBROUTINE XFMAGS                                                 2025.
C------- COMPUTE X-MAGNITUDE AND F-MAGNITUDE ---------------------------2026.

      REAL LAT,LON,MAG                                                  2027.
      COMMON /A12/ MSTA(1501),PRMK(1501),W(1501),JMIN(1501),             576.
     1       P(1501),RMK(1501),WRK(1501),TP(1501),DT(1501),COSL(701)     577.
      COMMON /A1/ NSTA(1501),DLY(2,1501),FMGC(1501),XMGC(1501),         2028.
     1       KLAS(1501),PRR(1501),CALR(1501),ICAL(1501),                2029.
     1       IS(1501),NDATE(1501),NHRMN(1501)                           2029.
      COMMON /A2/ LAT(1501),LON(1501),DELTA(1501),                       
     1	   DX(1501),DY(1501),T(1501) 
      COMMON /A5/ ZTR,XNEAR,XFAR,POS,IQ,KMS,KFM,IPUN,IMAG,IR,QSPA(9,40) 2030.
      COMMON /A6/ NMAX,LMAX,NS,NL,MMAX,NR,FNO,Z,
     1	   X(4,1501),ZSQ,NRP,DF(1501)
      COMMON /A8/ CAL(1501),XMAG(1501),FMAG(1501),                      2033.
     1       NM,AVXM,SDXM,NF,AVFM,SDFM,MAG,
     1       KDX(1501),AMX(1501),PRX(1501),CALX(1501),FMP(1501)         2034.
      COMMON /A16/ KLSS(1501),CALS(1501),MDATE(1501),MHRMN(1501),
     1       IPRN,ISW                                                   2035.
      COMMON /A19/ KNO,IELV(1501),TEST(15),FLT(2,1501),
     1       MNO(1501),IW(1501)                                         2036.
      DIMENSION RSPA(8,20)                                              2037.
      DATA ZMC1,ZMC2,PWC1,PWC2/0.15,3.38,0.80,1.50/,BLANK/'    '/       2038.
      DATA RSPA/-0.02, 1.05,-0.15,-0.13, 0.66, 0.55, 0.17, 0.42,        2039.
     2           0.14, 1.18,-0.01, 0.01, 0.79, 0.66, 0.27, 0.64,        2040.
     3           0.30, 1.29, 0.12, 0.14, 0.90, 0.76, 0.35, 0.84,        2041.
     4           0.43, 1.40, 0.25, 0.27, 1.00, 0.86, 0.43, 0.95,        2042.
     5           0.55, 1.49, 0.38, 0.41, 1.08, 0.93, 0.49, 1.04,        2043.
     6           0.65, 1.57, 0.53, 0.57, 1.16, 1.00, 0.55, 1.13,        2044.
     7           0.74, 1.63, 0.71, 0.75, 1.23, 1.07, 0.63, 1.24,        2045.
     8           0.83, 1.70, 0.90, 0.95, 1.30, 1.15, 0.72, 1.40,        2046.
     9           0.92, 1.77, 1.07, 1.14, 1.38, 1.25, 0.83, 1.50,        2047.
     A           1.01, 1.86, 1.23, 1.28, 1.47, 1.35, 0.95, 1.62,        2048.
     B           1.11, 1.96, 1.35, 1.40, 1.57, 1.46, 1.08, 1.73,        2049.
     C           1.20, 2.05, 1.45, 1.49, 1.67, 1.56, 1.19, 1.84,        2050.
     D           1.30, 2.14, 1.55, 1.58, 1.77, 1.66, 1.30, 1.94,        2051.
     E           1.39, 2.24, 1.65, 1.67, 1.86, 1.76, 1.40, 2.04,        2052.
     F           1.47, 2.33, 1.74, 1.76, 1.95, 1.85, 1.50, 2.14,        2053.
     G           1.53, 2.41, 1.81, 1.83, 2.03, 1.93, 1.58, 2.24,        2054.
     H           1.56, 2.45, 1.85, 1.87, 2.07, 1.97, 1.62, 2.31,        2055.
     I           1.53, 2.44, 1.84, 1.86, 2.06, 1.96, 1.61, 2.31,        2056.
     J           1.43, 2.36, 1.76, 1.78, 1.98, 1.88, 1.53, 1.92,        2057.
     K           1.25, 2.18, 1.59, 1.61, 1.82, 1.72, 1.37, 1.49/        2058.
C-----------------------------------------------------------------------2059.
      NM=0                                                              2060.
      AVXM=0.                                                           2061.
      SDXM=0.                                                           2062.
      NF=0                                                              2063.
      AVFM=0.                                                           2064.
      SDFM=0.                                                           2065.
      DO 40 I=1,NRP                                                     2066.
      XMAG(I)=BLANK                                                     2067.
      RAD2=DELTA(I)**2+ZSQ                                              2068.
      IF ((RAD2.LT.1.).OR.(RAD2.GT.360000.)) GO TO 30                   2069.
      JI=KDX(I)                                                         2070.
      K=KLAS(JI)                                                        2071.
      AMXI=ABS(AMX(I))                                                  2072.
      CAL(I)=CALX(I)                                                    2073.
      IF ((CAL(I).LT.0.01).OR.(ICAL(JI).EQ.1)) CAL(I)=CALR(JI)          2074.
      IF ((AMXI.LT.0.01).OR.(CAL(I).LT.0.01)) GO TO 30                  2075.
      IF ((K.LT.0).OR.(K.GT.8)) GO TO 30                                2076.
      XLMR=0.                                                           2077.
      IF (K .EQ. 0) GO TO 20                                            2078.
      PRXI=PRX(I)                                                       2079.
      IF (PRXI .LT. 0.01) PRXI=PRR(JI)                                  2080.
      IF (IR .EQ. 0) GO TO 10                                           2081.
      IF ((PRXI.GT.20.).OR.(PRXI.LT.0.033)) GO TO 30                    2082.
      FQ=10.*ALOG10(1./PRXI)+20.                                        2083.
      IFQ=FQ                                                            2084.
      XLMR=QSPA(K,IFQ)+(FQ-IFQ)*(QSPA(K,IFQ+1)-QSPA(K,IFQ))             2085.
      GO TO 20                                                          2086.
   10 IF ((PRXI.GT.3.).OR.(PRXI.LT.0.05)) GO TO 30                      2087.
      FQ=10.*ALOG10(1./PRXI)+6.                                         2088.
      IFQ=FQ                                                            2089.
      XLMR=RSPA(K,IFQ)+(FQ-IFQ)*(RSPA(K,IFQ+1)-RSPA(K,IFQ))             2090.
   20 BLAC=ALOG10(AMXI/(2.*CAL(I)))-XLMR                                2091.
      RLD2=ALOG10(RAD2)                                                 2092.
      BLNT=ZMC1-PWC1*RLD2                                               2093.
      IF (RAD2 .GE. 40000.) BLNT=ZMC2-PWC2*RLD2                         2094.
      XMAG(I)=BLAC-BLNT+XMGC(JI)                                        2095.
      NM=NM+1                                                           2096.
      AVXM=AVXM+XMAG(I)                                                 2097.
      SDXM=SDXM+XMAG(I)**2                                              2098.
   30 FMAG(I)=BLANK                                                     2099.

	go to 111
       IF(MSTA(I).EQ.'BADT') FMP(I)=BLANK
       IF(MSTA(I).EQ.'BAL ') FMP(I)=BLANK
       IF(MSTA(I).EQ.'BCA ') FMP(I)=BLANK
       IF(MSTA(I).EQ.'BNN ') FMP(I)=BLANK
       IF(MSTA(I).EQ.'CEY ') FMP(I)=BLANK
       IF(MSTA(I).EQ.'ISP ') FMP(I)=BLANK
       IF(MSTA(I).EQ.'KARS') FMP(I)=BLANK
       IF(MSTA(I).EQ.'LAP ') FMP(I)=BLANK
       IF(MSTA(I).EQ.'MRMT') FMP(I)=BLANK
       IF(MSTA(I).EQ.'SAFT') FMP(I)=BLANK
       IF(MSTA(I).EQ.'GNY ') FMP(I)=BLANK
       IF(MSTA(I).EQ.'GDD ') FMP(I)=BLANK

111	continue

       IF(MSTA(I).EQ.'BADT') zFac=BLANK
       IF(MSTA(I).EQ.'BAL ') zFac=BLANK
       IF(MSTA(I).EQ.'BCA ') zFac=BLANK
       IF(MSTA(I).EQ.'BNN ') zFac=BLANK
       IF(MSTA(I).EQ.'CEY ') zFac=BLANK
       IF(MSTA(I).EQ.'ISP ') zFac=BLANK
       IF(MSTA(I).EQ.'KARS') zFac=BLANK
       IF(MSTA(I).EQ.'LAP ') zFac=BLANK
       IF(MSTA(I).EQ.'MRMT') zFac=BLANK
       IF(MSTA(I).EQ.'SAFT') zFac=BLANK
       IF(MSTA(I).EQ.'GNY ') zFac=BLANK
       IF(MSTA(I).EQ.'GDD ') zFac=BLANK
       IF((FMP(I) .EQ. 0.0) .or. (zFac .EQ. BLANK)) GO TO 40                                   
C
      IF(MSTA(I).EQ.'ALT ') THEN
      FMAG(I)= 0.390+1.493*(ALOG10(FMP(I)))+0.0003*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I) .EQ.'AGRT') THEN
      FMAG(I)=-0.525+1.986*(ALOG10(FMP(I)))+0.0026*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I) .EQ.'BCK ') THEN
      FMAG(I)= 0.650+1.377*(ALOG10(FMP(I)))+0.0008*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I) .EQ.'BINT') THEN
      FMAG(I)=-0.049+1.672*(ALOG10(FMP(I)))+0.0015*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'BNT ') THEN
      FMAG(I)=0.556+1.413*(ALOG10(FMP(I)))+0.0007*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'BTM ') THEN
      FMAG(I)=-0.471+1.984*(ALOG10(FMP(I)))+0.0012*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'BYBT') THEN
      FMAG(I)= 0.186+1.656*(ALOG10(FMP(I)))+0.0009*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'BZK ') THEN
      FMAG(I)= 0.157+1.724*(ALOG10(FMP(I)))+0.0005*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'CANT') THEN
      FMAG(I)= 0.028+1.671*(ALOG10(FMP(I)))+0.0012*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'CTT ') then
      FMAG(I)= 0.677+1.247*(ALOG10(FMP(I)))+0.0014*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'DST ') THEN
      FMAG(I)= 0.393+1.399*(ALOG10(FMP(I)))+0.0011*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'EDC ') THEN
      FMAG(I)= 0.590+1.375*(ALOG10(FMP(I)))+0.0006*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'ELL ') then
      FMAG(I)= 0.734+1.254*(ALOG10(FMP(I)))+0.0009*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'EYL ') THEN
      FMAG(I)= 0.608+1.351*(ALOG10(FMP(I)))+0.0012*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'EZC ') THEN
      FMAG(I)=-0.054+1.733*(ALOG10(FMP(I)))+0.0013*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'EZN ') THEN
      FMAG(I)= 0.639+1.358*(ALOG10(FMP(I)))+0.0006*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'GAZ ') THEN
      FMAG(I)=-0.440+1.966*(ALOG10(FMP(I)))+0.0008*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'GPA ') THEN
      FMAG(I)= 0.703+1.295*(ALOG10(FMP(I)))+0.0012*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'HRT ') THEN
      FMAG(I)= 0.690+1.273*(ALOG10(FMP(I)))+0.0009*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'HTY ') THEN
      FMAG(I)= 0.292+1.568*(ALOG10(FMP(I)))+0.0010*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'IKL ') THEN
      FMAG(I)= 0.772+1.470*(ALOG10(FMP(I)))+0.0001*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'ISK ') THEN
      FMAG(I)= 0.705+1.338*(ALOG10(FMP(I)))+0.0009*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'IZI ') THEN
      FMAG(I)= 0.473+1.339*(ALOG10(FMP(I)))+0.0008*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'IZM ') THEN
      FMAG(I)= 0.770+1.243*(ALOG10(FMP(I)))+0.0011*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'KCT ') THEN
      FMAG(I)= 0.651+1.221*(ALOG10(FMP(I)))+0.0015*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'KGT ') THEN
      FMAG(I)= 0.658+1.215*(ALOG10(FMP(I)))+0.0009*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'KHL ') THEN
      FMAG(I)= 0.694+1.345*(ALOG10(FMP(I)))+0.0008*DELTA(I)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'KONT') THEN
      FMAG(I)= 0.303+1.452*(ALOG10(FMP(I)))+0.0021*DELTA(I)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'KVT ') THEN
      FMAG(I)=-0.141+1.784*ALOG10(FMP(I))+0.0002*DELTA(I)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'LEF ') THEN
      FMAG(I)= 0.160+1.666*ALOG10(FMP(I))+0.0009*DELTA(I)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'LFK ') THEN
      FMAG(I)= 0.830+1.377*ALOG10(FMP(I))+0.0003*DELTA(I)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'MFT ') THEN 
      FMAG(I)= 0.593+1.246*ALOG10(FMP(I))+0.0010*DELTA(I)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'MDU ') THEN 
      FMAG(I)= 0.276+1.543*ALOG10(FMP(I))+0.0011*DELTA(I)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'MYA ') THEN
      FMAG(I)= 0.021+1.769*ALOG10(FMP(I))+0.0004*DELTA(I)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'TOKT') THEN 
      FMAG(I)= 0.443+1.459*ALOG10(FMP(I))+0.0009*DELTA(I)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'VANT') THEN
      FMAG(I)=-0.175+1.784*ALOG10(FMP(I))+0.0016*DELTA(I)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'YER ') THEN 
      FMAG(I)= 0.788+1.309*ALOG10(FMP(I))+0.0008*DELTA(I)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'YLV ') THEN
      FMAG(I)= 0.479+1.377*ALOG10(FMP(I))+0.0007*DELTA(I)
      GOTO 41
      ENDIF
*...................................................
C     IZINET
*...................................................
      IF(MSTA(I) .EQ.'IZZ ') THEN
      FMAG(I)=0.767+1.344*(ALOG10(FMP(I)))+0.0016*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I) .EQ.'SAY ') THEN
      FMAG(I)=1.102+0.824*(ALOG10(FMP(I)))+0.0041*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I) .EQ.'OSM ') THEN
      FMAG(I)=0.484+1.105*(ALOG10(FMP(I)))+0.0026*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I) .EQ.'HIS ') THEN
      FMAG(I)=0.687+1.179*(ALOG10(FMP(I)))+0.0018*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I) .EQ.'KEK ') THEN
      FMAG(I)=1.223+0.871*(ALOG10(FMP(I)))+0.0025*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'CAV ') THEN
      FMAG(I)=0.419+1.327*(ALOG10(FMP(I)))+0.0028*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'GUL ') THEN
      FMAG(I)=1.049+0.800*(ALOG10(FMP(I)))+0.0030*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'GED ') THEN
      FMAG(I)=0.762+1.105*ALOG10(FMP(I))+0.0026*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'DER ') THEN
      FMAG(I)=0.762+1.105*ALOG10(FMP(I))+0.0026*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
      IF(MSTA(I).EQ.'BOY ') THEN
      FMAG(I)=0.762+1.105*ALOG10(FMP(I))+0.0026*DELTA(I)+FMGC(JI)
      GOTO 41
      ENDIF
*.......................................................
*.......................................................
      FMAG(I)=TEST(7)+TEST(8)*ALOG10(FMP(I))+TEST(9)*DELTA(I)+FMGC(JI)  2101.
      if(fmag(i).eq.BLANK) goto 40
   41 NF=NF+1                                                           2102.
      AVFM=AVFM+FMAG(I)                                                 2103.
      SDFM=SDFM+FMAG(I)**2                                              2104.
   40 CONTINUE                                                          2105.
      IF (NM .EQ. 0) GO TO 50                                           2106.
      AVXM=AVXM/NM                                                      2107.
      SDXM=SQRT(ABS(SDXM/NM-AVXM**2))                                   2108.
   50 IF (NF .EQ. 0) GO TO 60                                           2109.
      AVFM=AVFM/NF                                                      2110.
      SDFM=SQRT(ABS(SDFM/NF-AVFM**2))                                   2111.
   60 IF (NM .EQ. 0) AVXM=BLANK                                         2112.
      IF (NF .EQ. 0) AVFM=BLANK                                         2113.
       IF (IMAG-1) 70,80,90                                             2114.
   70 MAG=AVXM                                                          2115.
       RETURN                                                           2116.
   80 MAG=AVFM                                                          2117.
      RETURN                                                            2118.
   90 MAG=0.5*(AVXM+AVFM)                                               2119.
       IF (AVXM .EQ. BLANK) GO TO 80                                    2120.
       IF (AVFM .EQ. BLANK) GO TO 70                                    2121.
      RETURN                                                            2122.
      END                                                               2123.
