      *PROGRAMME POUR FAIRE LA SUPPRESSION D UN ENREGISTREMENT 
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PGDELETE.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY MAPPRJ.
       01 WS-RESPCODE PIC S9(8) COMP.
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
           PERFORM MAIN-PARA
           PERFORM FIN-PROGRAMME.
       MAIN-PARA.
           MOVE 80 TO WS-REC-LEN.
           MOVE 6 TO WS-KEY-LEN.
           MOVE 'O' TO FLAGERRI
           PERFORM FONCTION-DELETE UNTIL FLAGERRI = 'N'.
       FONCTION-DELETE.
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
                RESP(WS-RESPCODE)
           END-EXEC.
           EVALUATE TRUE
              WHEN WS-RESPCODE = DFHRESP(FILENOTFOUND)
                 MOVE 'FICHIER INEXISTANT, CONTINUEZ?' TO MSGINFO
              WHEN WS-RESPCODE = DFHRESP(NOTFND)
                 MOVE 'ENREGISTREMENT INEXISTANT, CONTINUEZ?' TO MSGINFO
              WHEN WS-RESPCODE = DFHRESP(INVREQ)
                 MOVE 'REQUETE INVALIDE, CONTINUEZ?' TO MSGINFO
              WHEN WS-RESPCODE = DFHRESP(NORMAL)
                 MOVE 'SUPPRESSION VALIDE, CONTINUEZ?' TO MSGINFO
              WHEN OTHER
                 MOVE 'WHEN OTHER, CONTINUEZ?' TO MSGINFO
           END-EVALUATE.
           EXEC CICS SEND MAP('MAP3')
                MAPSET('MAPPRJ')
                FREEKB
           END-EXEC.
           EXEC CICS RECEIVE MAP('MAP3')
                MAPSET('MAPPRJ')
           END-EXEC.
       FIN-PROGRAMME.
           EXEC CICS
                RETURN
           END-EXEC.
