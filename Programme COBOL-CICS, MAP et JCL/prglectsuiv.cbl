      *PROGRAMME POUR FAIRE LA LECTURE DES ENREGISTREMENTS
      *QUI COMMENCE A PARTIR DES 3 PREMIER VALEUR DU 
      *NUMERO DE COMPTE 
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PGLECTSU.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY MAPPRJ.
       01 WS-RESPCODE PIC S9(8) COMP.
       01 WS-REC-LEN PIC S9(4) COMP.
       01 WS-KEY-LEN PIC S9(4) COMP.
       01 WS-REC-KEY PIC X(6).
       01 WS-REC-KEY-TEMP PIC X(3).
       01 WS-ATTENDRE-MESS PIC X(30).
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
          05 WS-SOLDE PIC 9(10).
          05 WS-POSIT PIC X(2).
          05 FILLER PIC X(16).
       PROCEDURE DIVISION.
           PERFORM MAIN-PARA
           PERFORM FIN-PROGRAM.
       MAIN-PARA.
           MOVE 'TAPEZ ENTRE' TO WS-ATTENDRE-MESS
           EXEC CICS HANDLE AID ENTER
           END-EXEC
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
           END-EXEC
           MOVE CDECLTI TO WS-REC-KEY WS-REC-KEY-TEMP
           EXEC CICS STARTBR FILE('FCLIEN')
                RIDFLD(WS-REC-KEY)
                GENERIC
                REQID(01)
                KEYLENGTH(3)
           END-EXEC
           MOVE 'O' TO FLAGERRI
           PERFORM UNTIL FLAGERRI = 'N'
              PERFORM READ-NEXT
           END-PERFORM.
       READ-NEXT.
           EXEC CICS READNEXT FILE('FCLIEN') INTO (WS-CLIENT)
                LENGTH(WS-REC-LEN)
                RIDFLD(WS-REC-KEY)
                KEYLENGTH(WS-KEY-LEN)
                REQID(01)
                RESP(WS-RESPCODE)
           END-EXEC
           IF WS-NUM-CPT(1:3) = WS-REC-KEY-TEMP
              PERFORM AFFICHE-MAP2
           ELSE
              IF WS-RESPCODE = DFHRESP(ENDFILE)
                 GO TO FIN-PROGRAM
              ELSE
                 MOVE 'N' TO FLAGERRI
                 GO TO FIN-PROGRAM
              END-IF
           END-IF
           MOVE 'CONTINUEZ ? (O/N)' TO MSGINFO
           EXEC CICS SEND MAP('MAP3')
                MAPSET('MAPPRJ')
                FREEKB
           END-EXEC
           EXEC CICS RECEIVE MAP('MAP3')
                MAPSET('MAPPRJ')
           END-EXEC.
       AFFICHE-MAP2.
           PERFORM AFFECT-DONNEE
           EXEC CICS SEND MAP('MAP2')
                MAPSET('MAPPRJ')
                FREEKB
           END-EXEC
           EXEC CICS SEND TEXT FROM (WS-ATTENDRE-MESS)
                LENGTH(30)
                JUSTLAST
           END-EXEC
           EXEC CICS RECEIVE
           END-EXEC
              .
       AFFECT-DONNEE.
           MOVE WS-COD-REG TO CODREGO
           MOVE WS-NAT-CPT TO NATCPTO
           MOVE WS-NOM TO NOMCPTO
           MOVE WS-PRENOM TO PRNCPTO
           MOVE WS-DATE-NAIS TO DTNCPTO
           MOVE WS-SEXE TO SEXCPTO
           MOVE WS-ACTI-PRO TO APRCPTO
           MOVE WS-SIT-SOC TO SOCCPTO
           MOVE WS-ADRESS TO ADRCPTO
           MOVE WS-SOLDE TO SLDCPTO
           MOVE WS-POSIT TO POSCPTO
           .
       FIN-PROGRAM.
           EXEC CICS ENDBR FILE('FCLIEN')
                REQID(01)
           END-EXEC
           EXEC CICS
                RETURN
           END-EXEC.
