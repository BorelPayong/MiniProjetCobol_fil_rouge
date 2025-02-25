      ******************************************************************
      * NOM DU COPY  : YEMPENT                                 V(1.00) *
      * PROJET       :                                                 *
      * OBJET DECRIT : DEFINITION DE LA PARTIE VARIABLE EN ENTREE      *
      *                                                                *
      * LONGUEUR     : 61  OCTETS                                      *
      ******************************************************************

       01  YEMPENT.

      *================================================================*
      * PARTIE VARIABLE ENTREE                   -----DEB=001/LON=61  *
      *================================================================*
          05 EMPENT-EMPLOYES-ENT.
             10  EMPENT-EMPID           PIC S9(9)    COMP.
             10  EMPENT-NAME            PIC X(15).
             10  EMPENT-NAM2            PIC X(15).
             10  EMPENT-DEPARTMENT      PIC S9(9)    COMP.
             10  EMPENT-SALARY          PIC S9(7)V99 COMP-3.
             10  EMPENT-DESIGNATION     PIC X(4).
