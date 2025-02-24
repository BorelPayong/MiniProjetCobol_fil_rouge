      *PROGRAMME POUR AJOUTER UN ENREGISTREMENT 
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PGWRITE.
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
           PERFORM FONCTION-ECRIRE UNTIL FLAGERRI = 'N'.
       FONCTION-ECRIRE.
           EXEC CICS SEND MAP('MAP1')
                MAPSET('MAPPRJ')
                MAPONLY
                FREEKB
                ERASE
           END-EXEC
           EXEC CICS RECEIVE MAP('MAP1')
                MAPSET('MAPPRJ')
           END-EXEC
           MOVE CDECLTI TO WS-REC-KEY
           EXEC CICS READ FILE('FCLIEN') INTO (WS-CLIENT)
                LENGTH(WS-REC-LEN)
                RIDFLD(WS-REC-KEY)
                KEYLENGTH(WS-KEY-LEN)
                RESP(WS-RESPCODE)
           END-EXEC
           IF WS-RESPCODE = DFHRESP(NORMAL)
              EXEC CICS SEND MAP('MAP3')
                   MAPSET('MAPPRJ')
                   MAPONLY
                   FREEKB
              END-EXEC
              MOVE 'ECRITURE DOUBLE. CONTINUEZ ? ' TO MSGINFO
              EXEC CICS SEND MAP('MAP3')
                   MAPSET('MAPPRJ')
                   DATAONLY
                   FREEKB
              END-EXEC
              EXEC CICS RECEIVE MAP('MAP3')
                   MAPSET('MAPPRJ')
              END-EXEC
           ELSE
              EXEC CICS SEND MAP('MAP2')
                   MAPSET('MAPPRJ')
                   MAPONLY
                   FREEKB
              END-EXEC
              EXEC CICS RECEIVE MAP('MAP2')
                   MAPSET('MAPPRJ')
              END-EXEC
              MOVE CDECLTI TO WS-REC-KEY WS-NUM-CPT
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
              EXEC CICS WRITE FILE('FCLIEN') FROM (WS-CLIENT)
                   LENGTH(WS-REC-LEN)
                   RIDFLD(WS-REC-KEY)
                   KEYLENGTH(WS-KEY-LEN)
                   RESP(WS-RESPCODE)
              END-EXEC
              EXEC CICS SEND MAP('MAP3')
                   MAPSET('MAPPRJ')
                   MAPONLY
                   FREEKB
              END-EXEC
              EVALUATE TRUE
                 WHEN WS-RESPCODE = DFHRESP(FILENOTFOUND)
                    MOVE 'ECRITURE FICHIER INEXISTANT ' TO MSGINFO
                 WHEN WS-RESPCODE = DFHRESP(IOERR)
                    MOVE 'ERREUR E/S SUR LE FICHIER ' TO MSGINFO
                 WHEN WS-RESPCODE = DFHRESP(INVREQ)
                    MOVE 'REQUETE INVALIDE  ' TO MSGINFO
                 WHEN WS-RESPCODE = DFHRESP(NORMAL)
                    MOVE 'ECRITURE VALIDE ' TO MSGINFO
                 WHEN OTHER
                    MOVE 'WHEN OTHER ' TO MSGINFO
              END-EVALUATE
              EXEC CICS SEND MAP('MAP3')
                   MAPSET('MAPPRJ')
                   MAPONLY
                   FREEKB
              END-EXEC
              MOVE 'ECRITURE VALIDE. CONTINUEZ ? ' TO MSGINFO
              EXEC CICS SEND MAP('MAP3')
                   MAPSET('MAPPRJ')
                   DATAONLY
                   FREEKB
              END-EXEC
              EXEC CICS RECEIVE MAP('MAP3')
                   MAPSET('MAPPRJ')
              END-EXEC
           END-IF
           .
       FIN-PROGRAMME.
           EXEC CICS
                RETURN
           END-EXEC.
