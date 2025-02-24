      *PROGRAMME POUR FAIRE LA MISE A JOUR D UN
      *ENREGISTREMENT 
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PGREWRIT.
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
          05 WS-SOLDE PIC 9(10).
          05 WS-POSIT PIC X(2).
          05 FILLER PIC X(16).
       PROCEDURE DIVISION.
           PERFORM MAIN-PARA
           PERFORM FIN-PROGRAMME.
       MAIN-PARA.
           MOVE 80 TO WS-REC-LEN.
           MOVE 6 TO WS-KEY-LEN.
           MOVE 'O' TO FLAGERRI
           PERFORM FONCTION-REECRIRE UNTIL FLAGERRI = 'N'.
       FONCTION-REECRIRE.
           EXEC CICS SEND MAP('MAP1')
                MAPSET('MAPPRJ')
                MAPONLY
                FREEKB
                ERASE
           END-EXEC.
           EXEC CICS RECEIVE MAP('MAP1')
                MAPSET('MAPPRJ')
           END-EXEC
           MOVE CDECLTI TO WS-REC-KEY
           EXEC CICS READ FILE('FCLIEN') INTO (WS-CLIENT)
                LENGTH(WS-REC-LEN)
                RIDFLD(WS-REC-KEY)
                KEYLENGTH(WS-KEY-LEN)
                RESP(WS-RESPCODE)
                UPDATE
           END-EXEC
           IF WS-RESPCODE IS NOT = DFHRESP(NORMAL)
              MOVE 'CLIENT INEXISTANT, CONTINUEZ ?' TO MSGINFO
           ELSE
              MOVE WS-NUM-CPT TO CDECLTO
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
              EXEC CICS SEND MAP('MAP2')
                   MAPSET('MAPPRJ')
                   MAPONLY
                   FREEKB
                   FRSET
              END-EXEC
              EXEC CICS SEND MAP('MAP2')
                   MAPSET('MAPPRJ')
                   DATAONLY
                   FREEKB
              END-EXEC
              EXEC CICS RECEIVE MAP('MAP2')
                   MAPSET('MAPPRJ')
              END-EXEC
              MOVE CDECLTI TO WS-NUM-CPT
              MOVE CODREGI TO WS-COD-REG
              MOVE NATCPTI TO WS-NAT-CPT
              MOVE NOMCPTI TO WS-NOM
              MOVE PRNCPTI TO WS-PRENOM
              MOVE DTNCPTI TO WS-DATE-NAIS
              MOVE SEXCPTI TO WS-SEXE
              MOVE APRCPTI TO WS-ACTI-PRO
              MOVE SOCCPTI TO WS-SIT-SOC
              MOVE ADRCPTI TO WS-ADRESS
              MOVE SLDCPTI TO WS-SOLDE
              MOVE POSCPTI TO WS-POSIT
              EXEC CICS REWRITE FILE('FCLIEN') FROM (WS-CLIENT)
                   LENGTH(WS-REC-LEN)
                   RESP(WS-RESPCODE)
              END-EXEC
              MOVE 'MIS A JOUR VALIDE, CONTINUEZ ?' TO MSGINFO
           END-IF.
           EXEC CICS SEND MAP('MAP3')
                MAPSET('MAPPRJ')
                FREEKB
           END-EXEC
           EXEC CICS RECEIVE MAP('MAP3')
                MAPSET('MAPPRJ')
           END-EXEC.
       FIN-PROGRAMME.
           EXEC CICS
                RETURN
           END-EXEC.
