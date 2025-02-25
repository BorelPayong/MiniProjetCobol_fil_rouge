       IDENTIFICATION DIVISION.
       PROGRAM-ID. REFLTST.
       ENVIRONMENT DIVISION.
      *================================================================
      *-=-=-=-=-=-=-=-=-=-=-=-=
       CONFIGURATION SECTION.
      *-=-=-=-=-=-=-=-=-=-=-=-=
       SOURCE-COMPUTER. IBM-370.
       SPECIAL-NAMES. DECIMAL-POINT IS COMMA.
      *================================================================
       DATA DIVISION.
      *================================================================
      *-=-=-=-=-=-=-=-=-=-=-=-=-=
       WORKING-STORAGE SECTION.
      *-=-=-=-=-=-=-=-=-=-=-=-=-=
       01  WS-TEST PIC X(6).
       01  FILLER PIC X(30) VALUE '*** DEBUT WORKING REFPEMP ***'.
       01  C-SUBPGM PIC X(08) VALUE 'REFLEMP'.
      *-=-=-=-=-=-=-=-=-=
          COPY YFCIFAL.
          COPY YEMLENT.
          COPY YFCIFRE.
          COPY YEMLSOR.
       LINKAGE SECTION.
      *-=-=-=-=-=-=-=-=-=
      *===============================================================
       PROCEDURE DIVISION.
      *===============================================================
      *    TRAITEMENT G N RAL
      *===============================================================
      *     1) INITIALISATION
      *     2) TRAITEMENT DE LA FONCTION
      *     3) FIN DE PROGRAMME
      *===============================================================
      *===============================================================
           MOVE 'TEST08' TO WS-TEST
           PERFORM FONCTION-TRAITEMENT
           PERFORM FONCTION-FIN.
       FONCTION-TRAITEMENT.
           EVALUATE WS-TEST
              WHEN 'TEST01'
                  PERFORM FONCTION-TEST01
              WHEN 'TEST02'
                  PERFORM FONCTION-TEST02
              WHEN 'TEST03'
                  PERFORM FONCTION-TEST03
              WHEN 'TEST04'
                  PERFORM FONCTION-TEST04
              WHEN 'TEST05'
                  PERFORM FONCTION-TEST05
              WHEN 'TEST06'
                  PERFORM FONCTION-TEST06
              WHEN 'TEST07'
                  PERFORM FONCTION-TEST07
              WHEN 'TEST08'
                  PERFORM FONCTION-TEST08
              WHEN OTHER
                  DISPLAY ' TEST NON RECONNU '
           END-EVALUATE
           .
       FONCTION-TEST01.
           DISPLAY ' TEST-01 '
           DISPLAY ' JE TESTE AVEC UN CODE FONCTION INCORRECT '
           MOVE 'L1478'         TO FCIFAL-SCEDMD-FCT
           SET FCIFAL-TYPACN-UNQ TO TRUE
           PERFORM FONCTION-CORP-TEST
           .
       FONCTION-TEST02.
           DISPLAY ' TEST-02 '
           DISPLAY ' JE TESTE SANS ARGUMENT '
           MOVE 'L0001'         TO FCIFAL-SCEDMD-FCT
           SET FCIFAL-TYPACN-UNQ TO TRUE
           PERFORM FONCTION-CORP-TEST
           .
       FONCTION-TEST03.
           DISPLAY ' TEST-03 '
           DISPLAY ' JE TESTE LA CREATION D EMPLOYE SANS ARGUMENT '
           MOVE 'I0001'         TO FCIFAL-SCEDMD-FCT
           SET FCIFAL-TYPACN-ISR TO TRUE
           PERFORM FONCTION-CORP-TEST
           .
       FONCTION-TEST04.
           DISPLAY ' TEST-04 '
           DISPLAY ' JE TESTE LA CREATION D EMPLOYE AVEC 1 ARGUMENT '
           DISPLAY ' OBLIGATOIRE ABSENT '
           MOVE 'I0001'         TO FCIFAL-SCEDMD-FCT
           SET FCIFAL-TYPACN-ISR TO TRUE
           MOVE 'BOREL'         TO EMLENT-NAME
           MOVE 'FRANCK'        TO EMLENT-NAM2
           MOVE 95200           TO EMLENT-DEPARTMENT
           MOVE 35000           TO EMLENT-SALARY
           MOVE 'MANA'          TO EMLENT-DESIGNATION
           PERFORM FONCTION-CORP-TEST
           .
       FONCTION-TEST05.
           DISPLAY ' TEST-05 '
           DISPLAY ' JE TESTE LA MODIF D EMPLOYE AVEC 1 ARGUMENT '
           DISPLAY ' OBLIGATOIRE ABSENT '
           MOVE 'M0001'         TO FCIFAL-SCEDMD-FCT
           SET FCIFAL-TYPACN-LECMAJ TO TRUE
           SET FCIFAL-TYPACN-MOD TO TRUE
           MOVE 'BOREL'         TO EMLENT-NAME
           MOVE 'FRANCK'        TO EMLENT-NAM2
           MOVE 95200           TO EMLENT-DEPARTMENT
           MOVE 35000           TO EMLENT-SALARY
           MOVE 'MANA'          TO EMLENT-DESIGNATION
           PERFORM FONCTION-CORP-TEST
           .
       FONCTION-TEST06.
           DISPLAY ' TEST-06 '
           DISPLAY ' JE TESTE OBTENIR UN EMPLOYE AVEC SON ID '
           MOVE 'L0001'         TO FCIFAL-SCEDMD-FCT
           SET FCIFAL-TYPACN-UNQ TO TRUE
           MOVE 002           TO EMLENT-EMPID
           PERFORM FONCTION-CORP-TEST
           .
       FONCTION-TEST07.
           DISPLAY ' TEST-07 '
           DISPLAY ' JE TESTE LA CREATION D EMPLOYE '
           MOVE 'I0001'         TO FCIFAL-SCEDMD-FCT
           SET FCIFAL-TYPACN-ISR TO TRUE
           MOVE 024             TO EMLENT-EMPID
           MOVE 'BOREL'         TO EMLENT-NAME
           MOVE 'FRANCK'        TO EMLENT-NAM2
           MOVE 95200           TO EMLENT-DEPARTMENT
           MOVE 35000           TO EMLENT-SALARY
           MOVE 'MANA'          TO EMLENT-DESIGNATION
           PERFORM FONCTION-CORP-TEST
           .
       FONCTION-TEST08.
           DISPLAY ' TEST-08 '
           DISPLAY ' JE TESTE LA MODIF D EMPLOYE '
           MOVE 'M0001'         TO FCIFAL-SCEDMD-FCT
           SET FCIFAL-TYPACN-LECMAJ TO TRUE
           SET FCIFAL-TYPACN-MOD TO TRUE
           MOVE 008             TO EMLENT-EMPID
           MOVE 'BOREL'         TO EMLENT-NAME
           MOVE 'FRANCK'        TO EMLENT-NAM2
           MOVE 95200           TO EMLENT-DEPARTMENT
           MOVE 35000           TO EMLENT-SALARY
           MOVE 'MANA'          TO EMLENT-DESIGNATION
           PERFORM FONCTION-CORP-TEST
           .
       FONCTION-CORP-TEST.
           INITIALIZE YFCIFRE YEMLSOR
           DISPLAY ' PGM DE TEST <REFLTST> '
           DISPLAY ' D BUT APPEL ==> ' C-SUBPGM
           CALL C-SUBPGM USING YFCIFAL
                               YFCIFRE
                               YEMLENT
                               YEMLSOR.
           DISPLAY ' FIN APPEL ==> ' C-SUBPGM
           DISPLAY ' ME REVOIL  LE PGM DE TEST <REFLTST> '
           DISPLAY ' CI-DESSOUS LA SORTIE DE ' C-SUBPGM
           DISPLAY ' YFCIFRE < ' YFCIFRE ' > '
           DISPLAY ' YEMLSOR < ' YEMLSOR(1:62) ' > '
           .
       FONCTION-FIN.
           GOBACK
           .
