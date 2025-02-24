      *PROGRAMME POUR FAIRE UN DELETE GENERIC
      *ON RENSEIGNE LES PREMIER VALEUR DU NUMERO DE COMPTE
      *ET LE PROGRAMME SE CHARGE DE SUPPRIME TOUS LES
      *ENREGISTREMENT COMMENCANT PAR CE NUMERO DE COMPTE 
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PGDELGEN.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY MAPPRJ.
       01 WS-TEMP PIC 9(2).
       01 WS-RESPCODE PIC S9(8) COMP.
       01 WS-NUM-REC PIC S9(4) COMP.
       01 WS-REC-LEN PIC S9(4) COMP.
       01 WS-KEY-LEN PIC S9(4) COMP.
       01 WS-REC-KEY PIC X(6).
       01 WS-CLIENT.
          05 WS-NUM-CPT PIC X(6).
          05 WS-COD-REG PIC 9(2).
          05 WS-NAT-CPT PIC 9(2).
          05 WS-NOM PIC X(10).
          05 WS-PRENOM PIC X(10).
          05 WS-DATE-NAIS PIC 9(8).
          05 WS-SEXE PIC X(1).
          05 WS-ACTI-PRO PIC 9(2).
          05 WS-SIT-SOC PIC X(1).
          05 WS-ADRESS PIC X(10).
          05 WS-SOLDE PIC 9(8)V9(2).
          05 WS-POSIT PIC X(2).
          05 FILLER PIC X(16).
       PROCEDURE DIVISION.
       MAIN-PARA.
           MOVE 80 TO WS-REC-LEN.
           MOVE 3 TO WS-KEY-LEN.
           EXEC CICS SEND MAP('MAP1')
                MAPSET('MAPPRJ')
                MAPONLY
                FREEKB
                ERASE
           END-EXEC.
           EXEC CICS RECEIVE MAP('MAP1')
                MAPSET('MAPPRJ')
           END-EXEC.
           MOVE CDECLTI TO WS-REC-KEY
           EXEC CICS DELETE FILE('FCLIEN')
                RIDFLD(WS-REC-KEY)
                KEYLENGTH(WS-KEY-LEN)
                GENERIC
                NUMREC(WS-NUM-REC)
                RESP(WS-RESPCODE)
           END-EXEC
           MOVE WS-NUM-REC TO WS-TEMP
           IF WS-RESPCODE = DFHRESP(NORMAL)
              STRING 'NB DELE : ' DELIMITED SIZE
                     WS-TEMP DELIMITED SPACE
                     ' SUPPRIMER' DELIMITED SIZE
                     INTO MSGINFO
              END-STRING
              EXEC CICS SEND MAP('MAP3')
                   MAPSET('MAPPRJ')
                   FREEKB
                   ERASE
              END-EXEC
           ELSE
              MOVE 'SUPRESSION IMPOSSIBLE' TO MSGINFO
              EXEC CICS SEND MAP('MAP3')
                   MAPSET('MAPPRJ')
                   FREEKB
                   ERASE
              END-EXEC
           END-IF
           EXEC CICS
                RETURN
           END-EXEC.
