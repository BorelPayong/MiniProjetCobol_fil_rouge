      **************************************************************  
      *PROGRAMME POUR FAIRE L EDITION D UN RELEVE DE COMPTE D UN   *  
      *CLIENT DONNEE                                               *  
      **************************************************************  
        IDENTIFICATION DIVISION.                                      
        PROGRAM-ID. QUEST20.                                          
        ENVIRONMENT DIVISION.                                         
        INPUT-OUTPUT SECTION.                                         
        FILE-CONTROL.                                                 
           SELECT FMOUVEM ASSIGN TO DDMOUV                            
           ORGANIZATION IS SEQUENTIAL                                 
           ACCESS IS SEQUENTIAL                                       
           FILE STATUS IS FS-MOUVEM.                                  
           SELECT FCLIENT ASSIGN TO DDCLIENT                          
           ORGANIZATION IS INDEXED                                    
           ACCESS IS RANDOM                                           
           RECORD KEY IS NU-COMPTE                                    
           FILE STATUS IS FS-CLIENT.
           SELECT FPRINT ASSIGN TO DDPRINT                          
           ORGANIZATION IS SEQUENTIAL                               
           ACCESS MODE IS SEQUENTIAL                                
           FILE STATUS IS FS-PRINT.                                 
        DATA DIVISION.                                              
        FILE SECTION.                                               
        FD FPRINT.                                                  
        01 REC-PRT.                                                 
           05 ENR-PRT PIC X(80).     
        FD FCLIENT.                                      
        01 CLIENT.                                       
           05 NU-COMPTE PIC X(3).                        
           05 CODE-REGION PIC 9(2).                      
           05 NAT-COMPTE PIC 9(2).                       
           05 NOM-CLIENT PIC X(10).                      
           05 PRENOM-CLIENT PIC X(10).                   
           05 DATE-NAIS PIC 9(8).                        
           05 SEXE PIC X(1).                             
           05 ACTI-PRO PIC 9(2).                         
           05 SIT-SOCIAL PIC X(1).                       
           05 ADRESSE PIC X(10).                         
           05 SOLDE PIC 9(10).                           
           05 POSIT PIC X(2).                            
           05 FILLER PIC X(19).   
        FD FMOUVEM.                                           
        01 MOUVEM.                                            
           05 NUM-COMPTE PIC X(3).                            
           05 LIBELLE-MOUV PIC X(15).                         
           05 MONT-MOUV PIC 9(6).                             
           05 SENS-MOUV PIC X(2).                             
           05 NAT-MOUV PIC X(3).                              
           05 DATE-MOUV PIC X(10).                            
           05 FILLER PIC X(41).   
        WORKING-STORAGE SECTION.                                    
        01 WS-CLIENT.                                               
            05 WS-NU-COMPTE PIC X(3).                               
            05 WS-CODE-REGION PIC 9(2).                             
            05 WS-NAT-COMPTE PIC 9(2).                              
            05 WS-NOM-CLIENT PIC X(10).                             
            05 WS-PRENOM-CLIENT PIC X(10).                          
            05 WS-DATE-NAIS PIC 9(8).                               
            05 WS-SEXE PIC X(1).                                    
            05 WS-ACTI-PRO PIC 9(2).                                
            05 WS-SIT-SOCIAL PIC X(1).                              
            05 WS-ADRESSE PIC X(10).                                
            05 WS-SOLDE PIC 9(10).                                  
            05 WS-POSIT PIC X(2).                                   
            05 FILLER PIC X(19).                                    
        01 FS-CLIENT PIC 9(2).      
        01 WS-MOUVEM.                                               
           05 WS-NUM-COMPTE PIC X(3).                               
           05 WS-LIBELLE-MOUV PIC X(15).                            
           05 WS-MONT-MOUV PIC 9(6).                                
           05 WS-SENS-MOUV PIC X(2).                                
           05 WS-NAT-MOUV PIC X(3).                                 
           05 WS-DATE-MOUV PIC X(10).                               
           05 FILLER PIC X(41).                                     
        01 FS-MOUVEM PIC 9(2).                                      
        01 FS-PRINT PIC 9(2).                                       
        01 WS-END-OF-FILE PIC X(1).                                 
        01 WS-CLIENT-NUM-COMPTE PIC X(3).                           
        01 WS-LIGNE01 PIC X(80) VALUE ALL '*'. 
        01 WS-LIGNE02.                                                
           05 FILLER PIC X(1) VALUE '*'.                              
           05 FILLER PIC X(15) VALUE ' NOM CLIENT : '.                
           05 WS-PRINT-NOM PIC X(10).                                 
           05 FILLER PIC X(13) VALUE ALL ' '.                         
           05 FILLER PIC X(1) VALUE '*'.                              
           05 FILLER PIC X(20) VALUE ' NUMERO DE COMPTE : '.          
           05 WS-PRINT-NUM PIC 9(3).                                  
           05 FILLER PIC X(15) VALUE ALL ' '.                         
           05 FILLER PIC X(1) VALUE '*'.  
        01 WS-LIGNE03.                                               
           05 FILLER PIC X(1) VALUE '*'.                             
           05 FILLER PIC X(18) VALUE ' DATE D OPERATION '.           
           05 FILLER PIC X(2) VALUE '**'.                            
           05 FILLER PIC X(18) VALUE ' LIBELLE '.                    
           05 FILLER PIC X(2) VALUE '**'.                            
           05 FILLER PIC X(18) VALUE ' CREDIT  '.                    
           05 FILLER PIC X(2) VALUE '**'.                            
           05 FILLER PIC X(18) VALUE ' DEBIT '.                      
           05 FILLER PIC X(2) VALUE '**'.  
        01 WS-LIGNE04.                                               
           05 FILLER PIC X(1) VALUE '*'.                             
           05 WS-PRINT-DATE PIC X(18).                               
           05 FILLER PIC X(2) VALUE '**'.                            
           05 WS-PRINT-LIBELLE PIC X(18).                            
           05 FILLER PIC X(2) VALUE '**'.                            
           05 WS-PRINT-CR PIC X(18) VALUE ALL ' '.                   
           05 FILLER PIC X(2) VALUE '**'.                            
           05 WS-PRINT-DB PIC X(18) VALUE ALL ' '.                   
           05 FILLER PIC X(2) VALUE '**'.                            
        PROCEDURE DIVISION.                                          
           PERFORM FONCTION-DEBUT-PROGRAMME.                         
           PERFORM FONCTION-PROGRAMME.                               
           PERFORM FONCTION-FIN-PROGRAMME.   
        FONCTION-DEBUT-PROGRAMME.                                      
           DISPLAY 'DEBUT DU PROGRAMME'.                               
           OPEN INPUT FMOUVEM                                          
           IF FS-MOUVEM = 00                                           
              DISPLAY ' FILE MOUVEM OPEN SUCCES : ' FS-MOUVEM          
           ELSE                                                        
              DISPLAY ' FILE MOUVEM NOT OPEN : ' FS-MOUVEM             
              PERFORM FONCTION-FIN-PROGRAMME                           
           END-IF.                                                     
           OPEN I-O FCLIENT.                                           
           IF FS-CLIENT = 00                                           
              DISPLAY ' FILE CLIENT OPEN SUCCES : ' FS-CLIENT          
           ELSE                                                        
              DISPLAY ' FILE CLIENT NOT OPEN : ' FS-CLIENT             
           END-IF.  
           OPEN OUTPUT FPRINT                                         
           IF FS-PRINT = 00                                           
              DISPLAY ' FILE PRINT OPEN SUCCES : ' FS-PRINT           
           ELSE                                                       
              DISPLAY ' FILE PRINT NOT OPEN : ' FS-PRINT              
              PERFORM FONCTION-FIN-PROGRAMME                          
           END-IF.                                                    
        FONCTION-PROGRAMME.                                           
           READ FMOUVEM INTO WS-MOUVEM                                
              AT END MOVE 'Y' TO WS-END-OF-FILE                       
              NOT AT END                                              
                         MOVE WS-NUM-COMPTE TO WS-CLIENT-NUM-COMPTE   
                         PERFORM FONCTION-PRINT-ENTETE                
                         PERFORM FONCTION-PRINT-TAB                   
           END-READ. 
        FONCTION-PRINT-TAB.                                    
           PERFORM UNTIL WS-END-OF-FILE = 'Y'                  
              MOVE WS-DATE-MOUV TO WS-PRINT-DATE               
              MOVE WS-LIBELLE-MOUV TO WS-PRINT-LIBELLE         
              IF WS-SENS-MOUV = 'CR'                           
                 MOVE WS-MONT-MOUV TO WS-PRINT-CR              
                 MOVE ' ' TO WS-PRINT-DB                       
              ELSE                                             
                 MOVE WS-MONT-MOUV TO WS-PRINT-DB              
                 MOVE ' ' TO WS-PRINT-CR                       
              END-IF                                           
              MOVE WS-LIGNE04 TO REC-PRT                       
              WRITE REC-PRT                                    
              MOVE WS-LIGNE01 TO REC-PRT                       
              WRITE REC-PRT                                    
              PERFORM FONCTION-READ-FMOUV                      
           END-PERFORM. 
        FONCTION-READ-FMOUV.                                     
           READ FMOUVEM INTO WS-MOUVEM                           
              AT END MOVE 'Y' TO WS-END-OF-FILE                  
           END-READ.                                             
        FONCTION-PRINT-ENTETE.                                   
           MOVE WS-LIGNE01 TO REC-PRT                            
           WRITE REC-PRT                                         
           PERFORM FONCTION-CHERCH-NOMCLIENT                     
           MOVE WS-CLIENT-NUM-COMPTE TO WS-PRINT-NUM             
           MOVE WS-LIGNE02 TO REC-PRT                            
           WRITE REC-PRT                                         
           MOVE WS-LIGNE01 TO REC-PRT                            
           WRITE REC-PRT                                         
           MOVE WS-LIGNE03 TO REC-PRT                            
           WRITE REC-PRT                                         
           MOVE WS-LIGNE01 TO REC-PRT                            
           WRITE REC-PRT.  
        FONCTION-CHERCH-NOMCLIENT.                                    
           MOVE WS-CLIENT-NUM-COMPTE TO NU-COMPTE                     
           READ FCLIENT INTO WS-CLIENT                                
             KEY IS NU-COMPTE                                         
             INVALID KEY DISPLAY ' CLIENT NOT FOUND '                 
             NOT INVALID KEY MOVE WS-NOM-CLIENT TO WS-PRINT-NOM       
           END-READ.                                                  
        FONCTION-FIN-PROGRAMME.                                       
           CLOSE FCLIENT                                              
           CLOSE FPRINT                                               
           STOP RUN.                                                            