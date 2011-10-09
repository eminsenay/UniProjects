      SUBROUTINE SINGLE                                                 1022.
C-------- SOLUTION FOR A SINGLE EARTHQUAKE ---------------------------- 1023.
      INTEGER*2 SYM                                                     1024.
      REAL*8 TIME1,TIME2                                                1025.
      REAL LATRT, LONRT, LATSV, LONSV                                   1026.
      REAL LAT,LON,LAT2,LON2,LATEP,LONEP,MAG,LATR,LONR                  1027.

      COMMON /A1/ NSTA(1501),DLY(2,1501),FMGC(1501),XMGC(1501),         1028.
     1       KLAS(1501),PRR(1501),CALR(1501),ICAL(1501),IS(1501),       
     1       NDATE(1501),NHRMN(1501)									  
      COMMON /A2/ LAT(1501),LON(1501),DELTA(1501),                      
     1       DX(1501),DY(1501),T(1501)							      
      COMMON /A3/ NRES(2,1501),NXM(1501),NFM(1501),SR(2,1501),          1031.
     1       SRSQ(2,1501),SRWT(2,1501),SXM(1501),SXMSQ(1501),
     1       SFM(1501),SFMSQ(1501),QNO(4)                               1032.
      COMMON /A5/ ZTR,XNEAR,XFAR,POS,IQ,KMS,KFM,IPUN,IMAG,IR,QSPA(9,40) 1033.
      COMMON /A6/ NMAX,LMAX,NS,NL,MMAX,NR,FNO,Z,
     1	   X(4,1501),ZSQ,NRP,DF(1501)                                 
      COMMON /A7/ KP,KZ,KOUT,WT(1501),Y(4),SE(4),XMEAN(4),
     1	   CP(180),SP(180)                                            
      COMMON /A8/ CAL(1501),XMAG(1501),FMAG(1501),NM,AVXM,SDXM,NF,AVFM, 1036.
     1       SDFM,MAG,KDX(1501),AMX(1501),PRX(1501),CALX(1501),FMP(1501)1037.
      COMMON /A10/ ANIN(1501),AZ(1501),TEMP(1501),CA(71),CB(71)         1038.
      COMMON /A11/ KDATE,KHR,KMIN,SEC,LAT1,LAT2,LON1,LON2,RMK1,RMK2,    1039.
     1       IGAP,DMIN,RMSSQ,ERH,Q,QS,QD,ADJSQ,INST,AVR,AAR,NI,KNST,JHR 1040.
      COMMON /A12/ MSTA(1501),PRMK(1501),W(1501),JMIN(1501),P(1501),    1041.
     1       RMK(1501),WRK(1501),TP(1501),DT(1501),COSL(701)            1042.
      COMMON /A13/ JDX(1501),LDX(1501),KEY(1501),CLASS(4)               1043.
      COMMON /A14/ MBK,MDOL,BLANK,MSTAR,DOT,STAR4,QUES,CRMK,MCENT,ISTAR 1044.
      COMMON /A15/ M,L,J,ORG,JAV,PMIN,AZRES(1501),NEAR,IDXS,LATEP,LONEP 1045.
      COMMON /A16/ KLSS(1501),CALS(1501),MDATE(1501),MHRMN(1501),
     1       IPRN,ISW                                                   1046.
      COMMON /A17/ TIME1,TIME2,LATR,LONR,KTEST,KAZ,KSORT,KSEL,XFN       1047.
      COMMON /A18/ S(1501),SRMK(1501),WS(1501),TS(1501),NOS,QRMK(1501)  1048.
      COMMON /A19/ KNO,IELV(1501),TEST(15),FLT(2,1501),
     1       MNO(1501),IW(1501)                                         1049.
      COMMON /A20/ V(21),D(21),VSQ(21),THK(21),TID(21,21),DID(21,21)    1050.
      COMMON /A21/ KSMP(1501),FMO,ONF,B(4),IPH,KF,AVRPS,IEXIT           1051.
      COMMON /A22/ F(21,21),G(4,21),H(21),DEPTH(21),IONE                1052.
      COMMON /A23/ AIN(1501),RMS,ADJ,SYM(1501)                          1053.
      COMMON /A24/ FLTEP,IPRO,ISTTT,ISKP(4),AHEAD(12),FLIM,AF(3),NDEC   1054.
      COMMON /A25/ INS(1501),IEW(1501),JPH                              1055.


      DIMENSION SUM(5),YSAVE(4),WF(41),ALZ(10),LA(10),LO(10)            1056.

      DATA WF/.95,0.95,0.95,0.95,0.95,0.95,0.94,0.94,0.94,0.93,         1057.
     1       0.92,0.92,0.91,0.90,0.88,0.87,0.85,0.83,0.80,0.77,         1058.
     2       0.73,0.69,0.64,0.59,0.53,0.47,0.41,0.34,0.28,0.23,         1059.
     3       0.18,0.14,0.11,0.08,0.06,0.04,0.03,0.02,0.01,0.01,0./      1060.
      DATA LA/1,1,1,1,0,0,-1,-1,-1,-1/,                                 1061.
     1     LO/+1,-1,+1,-1,0,0,+1,-1,+1,-1/,                             1062.
     2     ALZ/-1.0,-1.0,+1.0,+1.0,-1.732,+1.732,-1.0,-1.0,+1.0,+1.0/   1063.
C-----------------------------------------------------------------------1064.
      AVRPS = 0.0                                                       1065.
      IEXIT=0                                                           1066.
      LATRT=0.                                                          1067.
      ZRES=P(NR+1)                                                      1068.
      KNST=JMIN(NR+1)/10                                                1069.
      INST=JMIN(NR+1)-KNST*10                                           1070.
      NRP=NR                                                            1071.
  151 IF (IDXS .EQ. 0) GO TO 80                                         1072.
C------- TREAT S DATA BY AUGMENTING P DATA -----------------------------1073.
      NOS=0                                                             1074.
      DO 65 I=1,NRP                                                     1075.
      IF (LDX(I) .EQ. 0) GO TO 65                                       1076.
      NOS=NOS+1                                                         1077.
      NRS=NRP+NOS                                                       1078.
      TP(NRS)=TS(I)                                                     1079.
      W(NRS)=WS(I)                                                      1080.
      KSMP(NRS)=0                                                       1081.
      IF ((KNST.NE.1).AND.(KNST.NE.6)) W(NRS)=0.                        1082.
      KDX(NRS)=KDX(I)                                                   1083.
      LDX(I)=NRS                                                        1084.
      WRK(NRS)=BLANK                                                    1085.
   65 CONTINUE                                                          1086.
      NR=NRP+NOS                                                        1087.
C------- INITIALIZE TRIAL HYPOCENTER -----------------------------------1088.
   80 K=KDX(NEAR)                                                       1089.
      SVY1 = 0.0                                                        1090.
      SVY2 = 0.0                                                        1091.
      SVY3 = 0.0                                                        1092.
      ERLMT = 0.                                                        1093.
      DO 25 I = 1,3                                                     1094.
      ISKP(I)=0                                                         1095.
   25 CONTINUE                                                          1096.
      IF (INST .NE. 9) GO TO 90                                         1097.
      READ(15,85) ORG1,ORG2,LAT1,LAT2,LON1,LON2,Z                       1098.
   85 FORMAT(F5.0,F5.2,I5,F5.2,I5,2F5.2)                                1099.
      ORG=60.*ORG1+ORG2                                                 1100.
      LATEP=60.*LAT1+LAT2                                               1101.
      LONEP=60.*LON1+LON2                                               1102.
      GO TO 105                                                         1103.
   90 IF (NR .GE. 3) GO TO 100                                          1104.
c   96  continue
   96 WRITE(16,97)                                                      1105.
   97 FORMAT(///,' ***** INSUFFICIENT DATA FOR LOCATING THIS QUAKE*')   1106.
      IF( NRP .EQ. 0 ) NRP = 1                                          1107.
      DO 98 L=1,NRP                                                     1108.
   98 WRITE(16,99) MSTA(L),PRMK(L),KDATE,KHR,JMIN(L),P(L),S(L)          1109.
   99 FORMAT(5X,2A4,1X,I6,2I2,F5.2,7X,F5.2)                             1110.
      IEXIT=1                                                           1111.
      IF (NRP .EQ. 1) RETURN                                            1112.
      GO TO 575                                                         1113.
  100 Z=ZTR                                                             1114.
      IF (AZRES(NRP+1).NE. BLANK) Z=ZRES                                1115.

c	write(222,*)'Z= ',Z,'NRP=',NRP

      ORG=PMIN-Z/5.-1.                                                  1116.
      IF(LATRT.EQ.0.) GO TO 102                                         1117.
      LATEP=LATRT                                                       1118.
      LONEP=LONRT                                                       1119.
      GO TO 105                                                         1120.
  102 IF (LATR .EQ. 0.) GO TO 104                                       1121.
      LATEP=LATR                                                        1122.
      LONEP=LONR                                                        1123.
      GO TO 105                                                         1124.
  104 LATEP=LAT(K)+0.1                                                  1125.
      LONEP=LON(K)+0.1                                                  1126.
  105 ADJSQ=0.                                                          1127.
      IPH=0                                                             1128.
      NDEC=0                                                            1129.
      PRMSSQ=100000.                                                    1130.
      IF (ISW .EQ. IONE) KNO=MNO(K)                                     1131.
      IF(ISW .EQ. IONE) FLTEP=FLT(KNO,K)                                1132.
      NIMAX=TEST(11)+.0001                                              1133.
C------- GEIGER'S ITERATION TO FIND HYPOCENTRAL ADJUSTMENTS ------------1134.
  109 NI = 1                                                            1135.
      IF (INST .EQ. 9) NI=NIMAX                                         1136.
  111 IF(ERLMT .EQ. 0.) GO TO 110                                       1137.
      LATEP = LATSV + LA(NA)*DELAT                                      1138.
      LONEP = LONSV + LO(NA)*DELON                                      1139.
      Z = ZSV + ALZ(NA)*DEZ                                             1140.
      IF(Z .LT. 0.) Z=0.                                                1141.
  110 FMO=0.                                                            1142.
      FNO=0.                                                            1143.
      DO 112 I=1,5                                                      1144.
  112 SUM(I)=0.                                                         1145.
C------- CALCULATE EPICENTRAL DISTANCE BY RICHTER'S METHOD -------------1146.
      DO 120 I=1,NR                                                     1147.
      JI=KDX(I)                                                         1148.
      AVL=(LAT(JI)+LATEP)/120.                                          1149.
      M1=AVL+1.5                                                        1150.
      M2=AVL*10.+1.5                                                    1151.
      DX(I)=(LON(JI)-LONEP)*CA(M1)*COSL(M2)                             1152.
      DY(I)=(LAT(JI)-LATEP)*CB(M1)                                      1153.
      DELTA(I)=SQRT(ABS(DX(I)**2+DY(I)**2))+0.000001                    1154.
      WT(I)=W(I)                                                        1155.
      IF (NI .LE. 1) GO TO 115                                          1156.
C------- DISTANCE WEIGHTING --------------------------------------------1157.
      IF (DELTA(I) .LE. XNEAR) GO TO 115                                1158.
      WT(I)=W(I)*(XFAR-DELTA(I))/XFN                                    1159.
      IF (WT(I) .LT. 0.005) WT(I)=0.                                    1160.
  115 IF (WT(I) .EQ. 0.) GO TO 120                                      1161.
      IF (KSMP(I) .EQ. 1) FMO=FMO+1.                                    1162.
      FNO=FNO+1.                                                        1163.
      SUM(4)=SUM(4)+WT(I)                                               1164.
  120 CONTINUE                                                          1165.
      IF (FNO .LT. 3.) GO TO 96                                         1166.
      AVWT=SUM(4)/FNO                                                   1167.
C------- NORMALIZE DISTANCE WEIGHTS ------------------------------------1168.
      SUM(4)=0.0                                                        1169.
      DO 122 I=1,NR                                                     1170.
  122 WT(I)=WT(I)/AVWT                                                  1171.
      IF ((NI.LE.2).OR.(KAZ.EQ.0)) GO TO 130                            1172.
C------- AZIMUTHAL WEIGHTING -------------------------------------------1173.
      CALL AZWTOS                                                       1174.
C------- COMPUTE TRAVEL TIMES + DERIVATIVES ----------------------------1175.
  130 ZSQ=Z**2                                                          1176.
      CALL TRVDRV                                                       1177.
      FDLY=1.                                                           1178.
      IF (ISW .EQ. IONE) FDLY=0.                                        1179.
C------- CALCULATE TRAVEL TIME RESIDUALS X(4,I) + MODIFY THE DERIV'S ---1180.
  140 DO 150 I=1,NR                                                     1181.
      JI=KDX(I)                                                         1182.
      IF (I .LE. NRP) GO TO 145                                         1183.
C------- S PHASE DATA --------------------------------------------------1184.
      T(I)=POS*T(I)                                                     1185.
      X(1,I)=POS*X(1,I)                                                 1186.
      X(2,I)=POS*X(2,I)                                                 1187.
      X(3,I)=POS*X(3,I)                                                 1188.
      X(4,I)=TP(I)-T(I)-ORG-POS*DLY(KNO,JI)*FDLY                        1189.
      GO TO 150                                                         1190.
  145 IF (KSMP(I) .EQ. 0) GO TO 146                                     1191.
C------- S-P DATA ------------------------------------------------------1192.
      X(1,I)=(POS-1.)*X(1,I)                                            1193.
      X(2,I)=(POS-1.)*X(2,I)                                            1194.
      X(3,I)=(POS-1.)*X(3,I)                                            1195.
      X(4,I)=TS(I)-TP(I)-(POS-1.)*(DLY(KNO,JI)*FDLY+T(I))               1196.
      GO TO 150                                                         1197.
C------- P TRAVEL TIME RESIDUAL ----------------------------------------1198.
  146 X(4,I)=TP(I)-T(I)-ORG-DLY(KNO,JI)*FDLY                            1199.
  150 CONTINUE                                                          1200.
C------- COMPUTE AVR, AAR, RMSSQ, + SDR --------------------------------1201.
      ONF=0.0                                                           1202.
      DO 152 I=1,NR                                                     1203.
      ONF = ONF + WT(I)*(1-KSMP(I))                                     1204.
      XWT = X(4,I)*WT(I)                                                1205.
      SUM(1)=SUM(1)+XWT                                                 1206.
      SUM(2)=SUM(2)+ABS(XWT)                                            1207.
      SUM(3)=SUM(3)+X(4,I)*XWT                                          1208.
      SUM(5)=SUM(5)+XWT*(1-KSMP(I))                                     1209.
  152 CONTINUE                                                          1210.
      IF(FNO .GT. FMO) AVRPS=SUM(5)/(ONF)                               1211.
      AVR=SUM(1)/FNO                                                    1212.
      AAR=SUM(2)/FNO                                                    1213.
      RMSSQ=SUM(3)/FNO                                                  1214.
      SDR=SQRT(ABS(RMSSQ-AVR**2))                                       1215.
      DO 153 I=1,5                                                      1216.
      SUM(I)= 0.0                                                       1217.
  153 CONTINUE                                                          1218.
      IF (RMSSQ .GE. TEST(1)) GO TO 154                                 1219.
      IF(ERLMT .EQ. 1.) GO TO 167                                       1220.
      IF(INST.EQ.9) GO TO 501                                           1221.
      IF(NI .GE. 2) GO TO 167                                           1222.
      GO TO 165                                                         1223.
C------- JEFFREYS' WEIGHTING -------------------------------------------1224.
  154 FMO=0.                                                            1225.
      FNO=0.                                                            1226.
      DO 160 I=1,NR                                                     1227.
      WRK(I)=BLANK                                                      1228.
      IF (WT(I) .EQ. 0.) GO TO 160                                      1229.
      K=10.*ABS(X(4,I)-AVR)/SDR+1.5                                     1230.
      IF (K .GT. 41) K=41                                               1231.
      WT(I)=WT(I)*WF(K)                                                 1232.
      IF (K .GT.151) WRK(I)=STAR4                                       1233.
      IF (WT(I) .LT. 0.005) WT(I)=0.                                    1234.
      IF (WT(I) .EQ. 0.) GO TO 160                                      1235.
      IF (KSMP(I) .EQ. 1) FMO=FMO+1.                                    1236.
      FNO=FNO+1.                                                        1237.
      SUM(4)=SUM(4)+WT(I)                                               1238.
  160 CONTINUE                                                          1239.
      IF (FNO .LT. 3.) GO TO 96                                         1240.
      AVWT=SUM(4)/FNO                                                   1241.
      SUM(4)=0.0                                                        1242.
      ONF=0.0                                                           1243.
      DO 164 I=1,NR                                                     1244.
      WT(I)=WT(I)/AVWT                                                  1245.
      ONF = ONF + WT(I)*(1-KSMP(I))                                     1246.
      XWT=X(4,I)*WT(I)                                                  1247.
      SUM(5)=SUM(5)+XWT*(1-KSMP(I))                                     1248.
  164 CONTINUE                                                          1249.
C------- RECALCULATE AVRPS ---------------------------------------------1250.
      IF(ERLMT .EQ. 1.) GO TO 163                                       1251.
      IF(INST .NE. 9) GO TO 163                                         1252.
      AVRPS = 0.0                                                       1253.
      IF(FNO .NE. FMO) AVRPS = SUM(5)/ONF                               1254.
      GO TO 501                                                         1255.
  163 IF(FNO.EQ.FMO) AVRPS=0.0                                          1256.
      IF(FNO.EQ.FMO) GO TO 167                                          1257.
      AVRPS=SUM(5)/(ONF)                                                1258.
      SUM(5)=0.0                                                        1259.
      IF(ERLMT .EQ. 1.) GO TO 167                                       1260.
C------- RESET FIRST ORIGIN TIME ---------------------------------------1261.
      IF(NI.GE. 2) GO TO 167                                            1262.
  165 ORG=ORG+AVRPS                                                     1263.
      DO 166 I=1,NR                                                     1264.
      IF(KSMP(I) .EQ. 0) X(4,I)=X(4,I)-AVRPS                            1265.
      XWT=WT(I)*X(4,I)                                                  1266.
      SUM(5)=SUM(5)+XWT*(1 - KSMP(I))                                   1267.
      SUM(2)=SUM(2)+ABS(XWT)                                            1268.
      SUM(3)=SUM(3)+X(4,I)*XWT                                          1269.
  166 CONTINUE                                                          1270.
      IF(FNO .GT. FMO) AVRPS=SUM(5)/(ONF)                               1271.
      AAR=SUM(2)/FNO                                                    1272.
      RMSSQ = SUM(3)/FNO                                                1273.
      GO TO 169                                                         1274.
C------- FOR NI*1, COMPUTE AAR, + RMSSQ AS IF AVRPS=0. -----------------1275.
  167 DO 168 I=1,NR                                                     1276.
      XWT=WT(I)*(X(4,I)-AVRPS*(1-KSMP(I)))                              1277.
      SUM(2)=SUM(2)+ABS(XWT)                                            1278.
      SUM(3)=SUM(3)+(X(4,I)-AVRPS*(1-KSMP(I)))*XWT                      1279.
  168 CONTINUE                                                          1280.
      AAR=SUM(2)/FNO                                                    1281.
      RMSSQ=SUM(3)/FNO                                                  1282.
      IF(ERLMT .EQ. 0.) GO TO 169                                       1283.
C------- OUTPUT RMS ERROR OF AUXILIARY POINTS --------------------------1284.
      L = LATEP/60.                                                     1285.
      ALA = LATEP - 60.*L                                               1286.
      L = LONEP/60.                                                     1287.
      ALO = LONEP - 60.*L                                               1288.
      RMSX= SQRT(ABS(RMSSQ))                                            1289.
      DRMS = RMSX - RMSSV                                               1290.
      GO TO (1,2,3,4,5,6,1,2,3,4), NA                                   1291.
c1     continue
    1 WRITE(16,801) ALA,ALO,Z,AVRPS,RMSX,DRMS                           1292.
  801 FORMAT(5F10.2,10X,F6.2)                                           1293.
      GO TO 174
c2      continue                                                         1294.
    2 WRITE(16,802) ALA,ALO,Z,AVRPS,RMSX,DRMS                           1295.
  802 FORMAT(5F10.2,28X,F6.2)                                           1296.
      GO TO 174                                                         1297.
c    3 continue
    3 WRITE(16,803) ALA,ALO,Z,AVRPS,RMSX,DRMS                           1298.
  803 FORMAT(5F10.2,13X,'(',F6.2,')')                                   1299.
      GO TO 174                                                         1300.
c    4 continue
    4 WRITE(16,804) ALA,ALO,Z,AVRPS,RMSX,DRMS                           1301.
  804 FORMAT(5F10.2,31X,'(',F6.2,')')                                   1302.
      IF(NA .EQ. 10) GO TO 550                                          1303.
      GO TO 174                                                         1304.
c    5 continue
    5 WRITE(16,805) ALA,ALO,Z,AVRPS,RMSX,DRMS                           1305.
  805 FORMAT(/5F10.2,19X,F6.2)                                          1306.
      WRITE(16,807) RMSSV                                               1307.
  807 FORMAT(40X,F10.2,23X,'0.00')                                      1308.
      GO TO 174                                                         1309.
c6      continue
    6 WRITE(16,806) ALA,ALO,Z,AVRPS,RMSX,DRMS                           1310.
  806 FORMAT(5F10.2,22X,'(',F6.2,')'/)                                  1311.
  174 NA = NA + 1                                                       1312.
      GO TO 111                                                         1313.
C------- CHECK IF SOLUTION IS BETTER THAN PREVIOUS ONE -----------------1314.
  169 IF((NI .EQ. 1) .AND. (NDEC .EQ. 0)) GO TO 170                     1315.
      IF(PRMSSQ.GE.RMSSQ) GO TO 170                                     1316.
      NDEC = NDEC +1                                                    1317.
      IF(NDEC .GT. 1) GO TO 175                                         1318.
      DO 177 I= 1,3                                                     1319.
      B(I) = 0.0                                                        1320.
      AF(I)=-1.0                                                        1321.
      SE(I) = 0.0                                                       1322.
  177 CONTINUE                                                          1323.
      NI = NI -1                                                        1324.
      BM1=Y(1)                                                          1325.
      BM2=Y(2)                                                          1326.
      BM3=Y(3)                                                          1327.
      BMAX = ABS(Y(1))                                                  1328.
      IIMAX = 1                                                         1329.
      DO 176 I = 2,3                                                    1330.
      IF(ABS(Y(I)).LE.BMAX) GO TO 176                                   1331.
      BMAX = ABS(Y(I))                                                  1332.
      IIMAX = I                                                         1333.
  176 CONTINUE                                                          1334.
      ISKP(IIMAX)=1                                                     1335.
      Y(1)=-BM1/5.                                                      1336.
      Y(2)=-BM2/5.                                                      1337.
      Y(3)=-BM3/5.                                                      1338.
      Y(4)=-Y(1)*XMEAN(1)-Y(2)*XMEAN(2)-Y(3)*XMEAN(3)                   1339.
      XADJSQ=Y(1)**2+Y(2)**2+Y(3)**2                                    1340.
      KP=0                                                              1341.
      IF(XADJSQ .LT. 4.*TEST(4)/25.) GO TO 170                          1342.
  175 IF(NDEC .EQ. 5) GO TO 170                                         1343.
      GO TO 325                                                         1344.
C------- STEPWISE MULTIPLE REGRESSION ANALYSIS OF TRAVEL TIME RESIDUALS-1345.
  170 IF(NDEC .GE. 1) NI = NI + 1                                       1346.
      IF (INST.EQ.1) GO TO 250                                          1347.
      IF(ISKP(3) .EQ. 1) GO TO 250                                      1348.
      IF (INST .EQ. 9) GO TO 501                                        1349.
      IF ((FNO.EQ.3) .AND. (FMO.LT.3)) GO TO 250                        1350.
C---- FREE SOLUTION                                                     1351.
 1010 KZ=0                                                              1352.
      KF=0                                                              1353.
      CALL SWMREG                                                       1354.
C------- AVOID CORRECTING DEPTH IF HORIZONTAL CHANGE IS LARGE ----------1355.
      IF (Y(1)**2+Y(2)**2 .LT. TEST(2)) GO TO1510                       1356.
C---- FIXED DEPTH SOLUTION                                              1357.
  250 KZ=1                                                              1358.
      KF=0                                                              1359.
      CALL SWMREG                                                       1360.
C------- LIMIT FOCAL DEPTH CHANGE + AVOID HYPOCENTER IN THE AIR --------1361.
 1510 DO 275 I= 1,3                                                     1362.
      ISKP(I)=0                                                         1363.
  275 CONTINUE                                                          1364.
      OLDY1=Y(1)                                                        1365.
      OLDY2=Y(2)                                                        1366.
      OLDY3=Y(3)                                                        1367.
      ABSY1=ABS(Y(1))                                                   1368.
      ABSY2=ABS(Y(2))                                                   1369.
      ABSY3=ABS(Y(3))                                                   1370.
      IF(ABSY1.GT.ABSY2) GO TO1515                                      1371.
      ABSGR=ABSY2                                                       1372.
      GO TO1518                                                         1373.
 1515 ABSGR=ABSY1                                                       1374.
 1518 IF(ABSY3.LE.TEST(5)) GO TO 310                                    1375.
      I=ABSY3/TEST(5)                                                   1376.
      Y(3)=Y(3)/(I+1)                                                   1377.
  310 IF((Z+Y(3)).GT. 0.0) GO TO 315                                    1378.
      Y(3)=-Z*TEST(12)+.000001                                          1379.
      ISKP(3) = 1                                                       1380.
C------- LIMIT HORIZONTAL ADJUSTMENT OF EPICENTER ----------------------1381.
  315 IF(ABSGR.LE.TEST(10)) GO TO 320                                   1382.
      I=ABSGR/TEST(10)                                                  1383.
      Y(1)=Y(1)/(I+1)                                                   1384.
      Y(2)=Y(2)/(I+1)                                                   1385.
  320 Y(4)=Y(4)-(Y(3)-OLDY3)*XMEAN(3)-(Y(1)-OLDY1)*XMEAN(1)             1386.
     1 -(Y(2)-OLDY2)*XMEAN(2)                                           1387.
      XADJSQ=Y(1)**2+Y(2)**2+Y(3)**2                                    1388.
      KP=0                                                              1389.
      NDEC=0                                                            1390.
      JPH=0                                                             1391.
  325 IF (IPRN .GE. 1) CALL OUTPUT                                      1392.
      IF(NDEC .GE. 1) GO TO 330                                         1393.
C------- TERMINATE ITERATION IF HYPOCENTER ADJUSTMENT ) TEST(4) --------1394.
      IF (XADJSQ .LT. TEST(4)) GO TO 500                                1395.
  330 IF(NI .EQ. NIMAX) GO TO 500                                       1396.
C------- ADJUST HYPOCENTER ---------------------------------------------1397.
  350 AVL=LATEP/60.                                                     1398.
  375 M1=AVL+1.5                                                        1399.
      M2=AVL*10.+1.5                                                    1400.
      DY1 =Y(1)/(CA(M1)*COSL(M2))                                       1401.
      DY2 =Y(2)/CB(M1)                                                  1402.
      LATEP=LATEP+DY2                                                   1403.
      LONEP=LONEP+DY1                                                   1404.
      Z=Z+Y(3)                                                          1405.
      ORG=ORG+Y(4)                                                      1406.
      SVY1 = Y(1)                                                       1407.
      SVY2 = Y(2)                                                       1408.
      SVY3 = Y(3)                                                       1409.
      ADJSQ=XADJSQ                                                      1410.
      IF(NDEC .EQ. 0) PRMSSQ=RMSSQ                                      1411.
      IF(NDEC.GE.1) GO TO 110                                           1412.
  400 NI = NI + 1                                                       1413.
      IF(NI .LE. NIMAX) GO TO 111                                       1414.
C------- RESET ORIGIN TIME ---------------------------------------------1415.
  500 ORG=ORG+XMEAN(4)                                                  1416.
      GO TO 502                                                         1417.
  501 XMEAN(4)=0.0                                                      1418.
  502 DO 505 I=1,5                                                      1419.
  505 SUM(I)=0.0                                                        1420.
      SUMM = 0.0                                                        1421.
      DO 510 I=1,NR                                                     1422.
      IF (KSMP(I) .EQ. 0) X(4,I)=X(4,I)-XMEAN(4)                        1423.
      IF (WT(I) .EQ. 0.) GO TO 510                                      1424.
      IF(INST .NE. 9) GO TO 509                                         1425.
      XWTS=WT(I)*(X(4,I)**2)                                            1426.
      IF(KSMP(I) .EQ. 0) XWTS=WT(I)*((X(4,I)-AVRPS)**2)                 1427.
      SUMM = SUMM + XWTS                                                1428.
  509 XWT=X(4,I)*WT(I)                                                  1429.
      SUM(1)=SUM(1)+XWT                                                 1430.
      SUM(2)=SUM(2)+ABS(XWT)                                            1431.
      SUM(3)=SUM(3)+X(4,I)*XWT                                          1432.
      SUM(5)=SUM(5)+XWT*(1-KSMP(I))                                     1433.
  510 CONTINUE                                                          1434.
      RM9SV = SUMM/FNO                                                  1435.
      AVR=SUM(1)/FNO                                                    1436.
      AVRPS = 0.0                                                       1437.
      IF(FNO .GT. FMO) AVRPS=SUM(5)/ONF                                 1438.
      AAR=SUM(2)/FNO                                                    1439.
      RMSSQ=SUM(3)/FNO                                                  1440.
C------- COMPUTE ERROR ESTIMATES BY SOLVING FULL NORMAL EQUATION -------1441.
  520 KF=2                                                              1442.
      KP=1                                                              1443.
      KZ=0                                                              1444.
      CALL SWMREG                                                       1445.
      DO 521 I =1,3                                                     1446.
  521 Y(I)=0.0                                                          1447.
      IF(INST.EQ.1) KZ = 1                                              1448.

      CALL OUTPUT                                                       1449.

      IF (KMS .EQ. 1) CALL MISING                                       1450.
      IF ((KNST.GE.5) .OR. (KFM.GE.1)) CALL FMPLOT                      1451.
      QNO(JAV)=QNO(JAV)+1.                                              1452.
      IF (JAV .GT. IQ) GO TO 523                                        1453.
C------- COMPUTE SUMMARY OF TRAVEL TIME RESIDUALS ----------------------1454.
      DO 522 I=1,NRP                                                    1455.
      IF ((WT(I).EQ.0.) .OR. (KSMP(I).EQ.1))  GO TO 522                 1456.
      JI=KDX(I)                                                         1457.
      NRES(KNO,JI)=NRES(KNO,JI)+1                                       1458.
      SR(KNO,JI)=SR(KNO,JI)+X(4,I)*WT(I)                                1459.
      SRSQ(KNO,JI)=SRSQ(KNO,JI)+X(4,I)**2*WT(I)                         1460.
      SRWT(KNO,JI)=SRWT(KNO,JI)+WT(I)                                   1461.
  522 CONTINUE                                                          1462.
  523 IF (KTEST .NE. 1) GO TO 550                                       1463.
C------- COMPUTE RMS AT AUXILIARY POINTS -------------------------------1464.
      RMSSV = SQRT(ABS(RMSSQ))                                          1465.
      IF(INST.EQ.9) RMSSV = SQRT(ABS(RM9SV))                            1466.
      ERLMT = 1.                                                        1467.
      LATSV = LATEP                                                     1468.
      LONSV = LONEP                                                     1469.
      ZSV = Z                                                           1470.
      AVL = LATEP/60.                                                   1471.
      M1 = AVL + 1.5                                                    1472.
      M2 = AVL*10. + 1.5                                                1473.
      DELAT = TEST(13)/CB(M1)                                           1474.
      DELON = TEST(13)/(CA(M1)*COSL(M2))                                1475.
      DEZ = TEST(13)                                                    1476.
      WRITE (16,525)                                                    1477.
  525 FORMAT (/'       LAT       LON         Z     AVRPS       RMS      1478.
     1                DRMS'/)                                           1479.
      NA=1                                                              1480.
      GO TO 111                                                         1481.
  550 TIME1=TIME2                                                       1482.
  575 CONTINUE                                                          1483.
C------- CHECK FOR MULTIPLE SOLUTIONS OF THE SAME EARTHQUAKE -----------1484.
      IF(IPRO.NE.ISTTT) RETURN                                          1485.
      NR=NRP                                                            1486.
      NRP1=NR +1                                                        1487.
      READ (15,600)  CHECK,IPRO,KNST,INST,ZRES,LAT1,LAT2,LON1,LON2,     1488.
     1 AZRES(NRP1)                                                      1489.
c      WRITE(222,601) CHECK,IPRO,KNST,INST,ZRES,LAT1,LAT2,LON1,LON2       1490.
  601 FORMAT(//2A4,9X,2I1,F5.2,1X,2(I4,F6.2),'--- RUN AGAIN ---')       1491.
  600 FORMAT(2A4,9X,2I1,F5.2,1X,2(I4,F6.2),T21,A4)                      1492.
      LATRT=60.*LAT1+LAT2                                               1493.
      LONRT=60.*LON1+LON2                                               1494.
      IF(CHECK.EQ.BLANK) GO TO 151                                      1495.
      WRITE(16,610) CHECK                                               1496.
  610 FORMAT(/' ERROR ',A4,' SKIPPED.   INST. CARD DID NOT FOLLOW ***') 1497.
      RETURN                                                            1498.
      END                                                               1499.
