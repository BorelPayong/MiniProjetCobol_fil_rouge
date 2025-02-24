      *PROGRAMME POUR FAIRE LE CALCUL, A PARTIR D UNE REGION
      *DONNEE ON RECUPERE LE NOMBRE DE CLIENT DE CETTE REGION
      *ON AFFICHE LE TOTAL DES MONTANT DB ET CR AINSI QUE LES CLIENTS
      *LES CLIENTS DB ET CR  
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PGREGION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY MAPREG.
       01 WS-MONT-DB PIC 9(10) VALUE 0.
       01 WS-MONT-CR PIC 9(10) VALUE 0.
       01 WS-NB-CLI-DB PIC 9(3) VALUE 0.
       01 WS-NB-CLI-CR PIC 9(3) VALUE 0.
       01 WS-NB-CLI PIC 9(3) VALUE 0.
       01 WS-RESPCODE PIC S9(8) COMP.
       01 WS-REC-LEN PIC S9(4) COMP.
       01 WS-KEY-LEN PIC S9(4) COMP.
       01 WS-REC-KEY PIC X(2).
       01 WS-END-OF-FILE PIC X(1).
       01 WS-CLIENT.
          05 WS-NUM-CPT PIC X(6).
          05 WS-COD-REG PIC X(2).
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
           MOVE 80 TO WS-REC-LEN.
           MOVE 2 TO WS-KEY-LEN.
           EXEC CICS SEND MAP('MAP1')
                MAPSET('MAPREG')
                MAPONLY
                FREEKB
                ERASE
           END-EXEC.
           EXEC CICS RECEIVE MAP('MAP1')
                MAPSET('MAPREG')
           END-EXEC
           MOVE CODREGI TO WS-REC-KEY
           EXEC CICS STARTBR FILE('PCLIEN')
                RIDFLD(WS-REC-KEY)
                REQID(01)
                KEYLENGTH(2)
           END-EXEC
           MOVE 'N' TO WS-END-OF-FILE
           PERFORM READ-NEXT UNTIL WS-END-OF-FILE = 'Y'.
       READ-NEXT.
           EXEC CICS READNEXT FILE('PCLIEN') INTO (WS-CLIENT)
                LENGTH(WS-REC-LEN)
                RIDFLD(WS-REC-KEY)
                KEYLENGTH(WS-KEY-LEN)
                REQID(01)
                RESP(WS-RESPCODE)
           END-EXEC
           IF WS-RESPCODE = DFHRESP(DUPKEY)
              PERFORM CALCUL-CLIENT
           ELSE
              IF WS-RESPCODE = DFHRESP(NORMAL)
                 PERFORM CALCUL-CLIENT
                 MOVE 'Y' TO WS-END-OF-FILE
                 PERFORM AFFECT-DONNEE
                 EXEC CICS SEND MAP('MAP2')
                      MAPSET('MAPREG')
                      FREEKB
                      ERASE
                 END-EXEC
                 EXEC CICS ENDBR FILE('PCLIEN')
                      REQID(01)
                 END-EXEC
                 GO TO FIN-PROGRAM
              ELSE
                 GO TO FIN-PROGRAM
              END-IF
           END-IF
              .
       CALCUL-CLIENT.
           IF WS-COD-REG = CODREGI
              ADD 1 TO WS-NB-CLI
              IF WS-POSIT = 'DB'
                 ADD WS-SOLDE TO WS-MONT-DB
                 ADD 1 TO WS-NB-CLI-DB
              ELSE
                 ADD WS-SOLDE TO WS-MONT-CR
                 ADD 1 TO WS-NB-CLI-CR
              END-IF
           END-IF
              .
       AFFECT-DONNEE.
           MOVE WS-NB-CLI TO NBCLIEO
           MOVE WS-MONT-DB TO MCLIDBO
           MOVE WS-NB-CLI-DB TO NCLIDBO
           MOVE WS-MONT-CR TO MCLICRO
           MOVE WS-NB-CLI-CR TO NCLICRO
           .
       FIN-PROGRAM.
           EXEC CICS
                RETURN
           END-EXEC.
