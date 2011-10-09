      SUBROUTINE SORT(X,KEY,NO)                                         1500.
      DIMENSION X(NO),KEY(NO)                                           1501.
C-----------------------------------------------------------------------1502.
      DO 1 I=1,NO                                                       1503.
 1    KEY(I)=I                                                          1504.
      MO=NO                                                             1505.
 2    IF (MO-15) 21,21,23                                               1506.
 21   IF (MO-1) 29,29,22                                                1507.
 22   MO=2*(MO/4)+1                                                     1508.
      GO TO 24                                                          1509.
 23   MO=2*(MO/8)+1                                                     1510.
 24   KO=NO-MO                                                          1511.
      JO=1                                                              1512.
 25   I=JO                                                              1513.
 26   IF (X(I)-X(I+MO)) 28,28,27                                        1514.
 27   TEMP=X(I)                                                         1515.
      X(I)=X(I+MO)                                                      1516.
      X(I+MO)=TEMP                                                      1517.
      KEMP=KEY(I)                                                       1518.
      KEY(I)=KEY(I+MO)                                                  1519.
      KEY(I+MO)=KEMP                                                    1520.
      I=I-MO                                                            1521.
      IF (I-1) 28,26,26                                                 1522.
 28   JO=JO+1                                                           1523.
      IF (JO-KO) 25,25,2                                                1524.
 29   RETURN                                                            1525.
      END                                                               1526.
