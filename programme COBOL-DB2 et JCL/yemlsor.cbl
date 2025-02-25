      ******************************************************************
      * NOM DU COPY  : YEMLSOR                                 V(1.00) *
      * PROJET       :                                                 *
      * OBJET DECRIT : DEFINITION DE LA PARTIE VARIABLE EN SORTIE      *
      *                                                                *
      * LONGUEUR     : 61  OCTETS                                      *
      ******************************************************************

       01  YEMLSOR.
         05 EMLSOR-SORTIE              PIC X(620).
      *================================================================*
      * PARTIE VARIABLE SORTIE                   -----DEB=001/LON=61  *
      *================================================================*
          05 EMLSOR-L0001 REDEFINES EMLSOR-SORTIE.
             10 EMLSOR-L0001-EMPID        PIC 9(9).
             10 EMLSOR-L0001-NAME         PIC X(15).
             10 EMLSOR-L0001-NAM2         PIC X(15).
             10 EMLSOR-L0001-DEPARTMENT   PIC 9(9).
             10 EMLSOR-L0001-SALARY       PIC 9(7)V99.
             10 EMLSOR-L0001-DESIGNATION  PIC X(4).
             10 FILLER                    PIC X(558).
          05 EMLSOR-L1001 REDEFINES EMLSOR-SORTIE.
           10 EMLSOR-L1001-LIGNE          OCCURS 10.
              15 EMLSOR-L1001-EMPID        PIC 9(9).
              15 EMLSOR-L1001-NAME         PIC X(15).
              15 EMLSOR-L1001-NAM2         PIC X(15).
              15 EMLSOR-L1001-DEPARTMENT   PIC 9(9).
              15 EMLSOR-L1001-SALARY       PIC 9(7)V99.
              15 EMLSOR-L1001-DESIGNATION  PIC X(4).
          05 EMLSOR-M0001 REDEFINES EMLSOR-SORTIE.
             10 FILLER                      PIC X(620).
          05 EMLSOR-S0001 REDEFINES EMLSOR-SORTIE.
             10 FILLER                      PIC X(620).
