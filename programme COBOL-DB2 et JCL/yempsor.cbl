      ************************************************************
      * NOM DU COPY  : YEMPSOR                                 V(1.00) *
      * PROJET       :                                                 *
      * OBJET DECRIT : DEFINITION DE LA PARTIE VARIABLE EN SORTIE      *
      *                                                                *
      * LONGUEUR     : 61  OCTETS                                      *
      ******************************************************************

       01  YEMPSOR.

      *===============================================================*
      * PARTIE VARIABLE SORTIE                   -----DEB=001/LON=61  *
      *===============================================================*
          05 EMPSOR-EMPLOYES-SORTIE.
             10  EMPSOR-EMPID           PIC 9(9).
             10  EMPSOR-NAME            PIC X(15).
             10  EMPSOR-NAM2            PIC X(15).
             10  EMPSOR-DEPARTMENT      PIC 9(9).
             10  EMPSOR-SALARY          PIC 9(7)V99.
             10  EMPSOR-DESIGNATION     PIC X(4).
