      ******************************************************************
      * NOM DU COPY  : YEMLENT                                 V(1.00) *
      * PROJET       :                                                 *
      * OBJET DECRIT : DEFINITION DE LA PARTIE VARIABLE EN ENTREE      *
      *                                                                *
      * LONGUEUR     : 61  OCTETS                                      *
      ******************************************************************

       01  YEMLENT.

      *================================================================*
      * PARTIE VARIABLE ENTREE                   -----DEB=001/LON=61  *
      *================================================================*
          05 EMLENT-EMPLOYES-ENT.
             10  EMLENT-EMPID           PIC S9(9)    COMP.
             10  EMLENT-NAME            PIC X(15).
             10  EMLENT-NAM2            PIC X(15).
             10  EMLENT-DEPARTMENT      PIC S9(9)    COMP.
             10  EMLENT-SALARY          PIC S9(7)V99 COMP-3.
             10  EMLENT-DESIGNATION     PIC X(4).
