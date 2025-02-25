       IDENTIFICATION DIVISION.
       PROGRAM-ID. REFLEMP.
       ENVIRONMENT DIVISION.
      *=================================================================
      *-=-=-=-=-=-=-=-=-=-=-=-=
       CONFIGURATION SECTION.
      *-=-=-=-=-=-=-=-=-=-=-=-=
       SOURCE-COMPUTER. IBM-370.
       SPECIAL-NAMES. DECIMAL-POINT IS COMMA.
      *=================================================================
       DATA DIVISION.
      *=================================================================
      *-=-=-=-=-=-=-=-=-=-=-=-=-=
       WORKING-STORAGE SECTION.
      *-=-=-=-=-=-=-=-=-=-=-=-=-=
       01  W-ERR                         PIC X(08).
          88 W-TRT-OK                   VALUE '00000000'.
      *ARGUMENT FIXE INCORRECT
          88 W-ERR-ARGFIXINC            VALUE '00090001'.
      *ARGUMENT VARIABLE INCORRECT
          88 W-ERR-ARGVARINC            VALUE '00090002'.
       01  FILLER REDEFINES W-ERR.
          05 W-CODERR.
             10 W-CODERRPRM             PIC 9(04).
             10 W-CODERRSCD             PIC 9(04).
       01 WS-CPT-EMP PIC 9(2).
       01 WS-I PIC 9(2) VALUE 01 .
       01  FILLER PIC X(30) VALUE '*** DEBUT WORKING REFLEMP ***'.
       01  C-SUBPGM PIC X(08) VALUE 'REFPEMP'.
          COPY YEMPENT.
          COPY YEMPSOR.
      *-=-=-=-=-=-=-=-=-=
       LINKAGE SECTION.
          COPY YFCIFAL.
          COPY YFCIFRE.
          COPY YEMLENT.
          COPY YEMLSOR.
      *-=-=-=-=-=-=-=-=-=
      *================================================================
       PROCEDURE DIVISION USING YFCIFAL
                                YFCIFRE
                                YEMLENT
                                YEMLSOR.
      *=================================================================
      *    TRAITEMENT G N RAL
      *=================================================================
      *     1) INITIALISATION
      *     2) TRAITEMENT DE LA FONCTION
      *     3) FIN DE PROGRAMME
      *=================================================================
      *=================================================================
           PERFORM FONCTION-INITIALIZE
           IF W-TRT-OK
              PERFORM FONCTION-TRAITEMENT
           END-IF.
           PERFORM FONCTION-FIN-PROG.
           GOBACK.
       FONCTION-INITIALIZE.
           INITIALIZE YFCIFRE YEMPSOR
           SET W-TRT-OK TO TRUE
           .
       FONCTION-TRAITEMENT.
           EVALUATE FCIFAL-SCEDMD-FCT
              WHEN 'L0001'
                 PERFORM TRT-L0001
              WHEN 'L1001'
                 PERFORM TRT-L1001
              WHEN 'I0001'
                 PERFORM TRT-I0001
              WHEN 'M0001'
                 PERFORM TRT-M0001
              WHEN OTHER
                 SET W-ERR-ARGFIXINC TO TRUE
           END-EVALUATE
           PERFORM FONCTION-AFF-ERR
           .
       TRT-L0001.
           IF EMLENT-EMPID = ZERO
              SET W-ERR-ARGVARINC TO TRUE
              PERFORM FONCTION-AFF-ERR
           END-IF
           IF W-TRT-OK
              MOVE EMLENT-EMPID  TO EMPENT-EMPID
              PERFORM FONCTION-APPEL-PHY
           END-IF
           .
    
       TRT-I0001.
           IF EMLENT-EMPID = ZERO OR EMLENT-NAME = ZERO OR
              EMLENT-NAM2 = ZERO OR EMLENT-DEPARTMENT = ZERO
              OR EMLENT-SALARY = ZERO OR
              EMLENT-DESIGNATION = ZERO
              SET W-ERR-ARGVARINC   TO TRUE
              PERFORM FONCTION-AFF-ERR
           END-IF
           IF W-TRT-OK
              MOVE EMLENT-EMPLOYES-ENT TO EMPENT-EMPLOYES-ENT
              PERFORM FONCTION-APPEL-PHY
           END-IF
           .
       TRT-M0001.
           IF EMLENT-EMPID = ZERO OR EMLENT-NAME = ZERO OR
              EMLENT-NAM2 = ZERO OR EMLENT-DEPARTMENT = ZERO
              OR EMLENT-SALARY = ZERO OR
              EMLENT-DESIGNATION = ZERO
              SET W-ERR-ARGVARINC   TO TRUE
              PERFORM FONCTION-AFF-ERR
           END-IF
           IF W-TRT-OK
              MOVE EMLENT-EMPLOYES-ENT TO EMPENT-EMPLOYES-ENT
              PERFORM FONCTION-APPEL-PHY
           END-IF
           .
       FONCTION-AFF-ERR.
           IF W-ERR-ARGFIXINC OR W-ERR-ARGVARINC
              MOVE W-CODERRPRM TO FCIFRE-CODRETPMR
              MOVE W-CODERRSCD TO FCIFRE-CODRETSCD
              DISPLAY ' FCIFRE-ERR < ' FCIFRE-MSGERRMET(9:8) ' > '
           END-IF
           .
       FONCTION-APPEL-PHY.
           DISPLAY ' ACCESSEUR LOGIQUE <REFLEMP> '

           DISPLAY ' D BUT APPEL ==> ' C-SUBPGM

           CALL C-SUBPGM USING YFCIFAL
                               YFCIFRE
                               YEMPENT
                               YEMPSOR.

           DISPLAY ' FIN APPEL ==> ' C-SUBPGM

           DISPLAY " ME REVOIL  L'ACCESSEUR LOGIQUE <REFLEMP> "
           DISPLAY ' CI-DESSOUS LA SORTIE DE ' C-SUBPGM
           DISPLAY ' YFCIFRE < ' YFCIFRE ' > '
           DISPLAY ' YEMPSOR < ' YEMPSOR ' > '
           DISPLAY ' YEMLSOR < ' EMLSOR-L0001 ' > '
           .
       FONCTION-FIN-PROG.
           DISPLAY ' YFCIFRE < ' YFCIFRE ' > '
           .
