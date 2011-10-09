	SUBROUTINE ANSWER(A,S,XMEAN,SIGMA,IDX,PHI,L,M,MM,PF,NDX,ADX)

C------- PRINT INTERMEDIATE RESULTS OF REGRESSION ANALYSIS (SWMREG) ---  100.
      REAL*8 ADX                                                         101.
      DIMENSION A(7,7),S(4,4)                                            102.
      DIMENSION XMEAN(1),SIGMA(1),IDX(1),B(4),BSE(4),PF(1)               103.
C----------------------------------------------------------------------- 104.
      DO 410 I=1,MM                                                      105.
      WRITE(16,400) (A(I,J),J=1,MM)                                     106.
  400 FORMAT(7E18.8)                                                     107.
  410 CONTINUE                                                           108.
      FVE=1.-A(M,M)                                                      109.
      B0=XMEAN(M)                                                        110.
  450 YSE=77.7                                                           111.
      IF (PHI .GE. 1) YSE=SIGMA(M)*SQRT(ABS(A(M,M)/PHI))                 112.
      DO  5 I=1,L                                                        113.
      IF (IDX(I).EQ.0) GO TO  5                                          114.
      B(I)=A(I,M)* SQRT(ABS(S(M,M)/S(I,I)))                              115.
      BSE(I)=YSE* SQRT(ABS(A(I+M,I+M)/S(I,I)))                           116.
      B0=B0-B(I)*XMEAN(I)                                                117.
    5 CONTINUE                                                           118.
      WRITE(16,10) ADX,NDX,FVE,YSE,B0                                   119.
   10 FORMAT(/,' VARIABLE ', A8, '................',I5                   120.
     2,      /,' FRACTION OF VARIATION EXPLAINED..',E18.8                121.
     3,      /,' STANDARD ERROR OF Y..............',E18.8                122.
     4,      /,' CONSTANT IN REGRESSION EQUATION..',E18.8)               123.
      WRITE(16,20)                                                      124.
   20 FORMAT(/,' VARIABLE     COEFFICIENT      STANDARD ERROR'           125.
     1,'     PARTIAL F-VALUE')                                           126.
      DO 40 I=1,L                                                        127.
      IF (IDX(I).EQ.0) GO TO 40                                          128.
      WRITE(16,30) I,B(I),BSE(I),PF(I)                                    129.
   30 FORMAT(I5,3E20.6)                                                  130.
   40 CONTINUE                                                           131.
      RETURN                                                             132.
      END                                                                133.
