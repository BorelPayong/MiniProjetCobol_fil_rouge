      **************************************************************   
      *PROGRAMME POUR AFFICHER LES 5 PREMIER CLIENT DEBITEUR       *   
      **************************************************************   
        IDENTIFICATION DIVISION.                                       
        PROGRAM-ID. QUEST17.                                           
        ENVIRONMENT DIVISION.                                          
        INPUT-OUTPUT SECTION.                                          
        FILE-CONTROL.                                                  
           SELECT FCLIENT ASSIGN TO DDCLIENT                           
           ORGANIZATION IS INDEXED                                     
           ACCESS IS SEQUENTIAL                                        
           RECORD KEY IS NUM-COMPTE                                    
           FILE STATUS IS FS-CLIENT.                                   
        DATA DIVISION.                                                 
        FILE SECTION.                                                  
        FD FCLIENT.    
        01 CLIENT.                                                  
           05 NUM-COMPTE PIC X(3).                                  
           05 CODE-REGION PIC 9(2).                                 
           05 NAT-COMPTE PIC 9(2).                                  
           05 NOM-CLIENT PIC X(10).                                 
           05 PRENOM-CLIENT PIC X(10).                              
           05 DATE-NAIS PIC 9(8).                                   
           05 SEXE PIC X(1).                                        
           05 ACTI-PRO PIC X(2).                                    
           05 SIT-SOCIAL PIC X(1).                                  
           05 ADRESSE PIC X(10).                                    
           05 SOLDE PIC 9(10).                                      
           05 POSIT PIC X(2).                                       
           05 FILLER PIC X(19).   
        WORKING-STORAGE SECTION.                                   
        01 WS-CLIENT.                                              
           05 WS-NUM-COMPTE PIC X(3).                              
           05 WS-CODE-REGION PIC 9(2).                             
           05 WS-NAT-COMPTE PIC 9(2).                              
           05 WS-NOM-CLIENT PIC X(10).                             
           05 WS-PRENOM-CLIENT PIC X(10).                          
           05 WS-DATE-NAIS PIC 9(8).                               
           05 WS-SEXE PIC X(1).                                    
           05 WS-ACTI-PRO PIC X(2).                                
           05 WS-SIT-SOCIAL PIC X(1).                              
           05 WS-ADRESSE PIC X(10).                                
           05 WS-SOLDE PIC 9(10).                                  
           05 WS-POSIT PIC X(2).                                   
           05 FILLER PIC X(19).                                    
        01 FS-CLIENT PIC X(2).                                     
        01 WS-END-OF-FILE PIC X(1).                                
        01 WS-COMPTEUR PIC 9(1). 
        PROCEDURE DIVISION.                                           
           PERFORM FONCTION-DEBUT-PROGRAMME.                          
           PERFORM FONCTION-PROGRAMME.                                
           PERFORM FONCTION-FIN-PROGRAMME.                            
        FONCTION-DEBUT-PROGRAMME.                                     
           DISPLAY 'DEBUT DU PROGRAMME'.                              
           OPEN I-O FCLIENT.                                          
           IF FS-CLIENT = '00'                                        
              DISPLAY ' FILE CLIENT OPEN SUCCES : ' FS-CLIENT         
           ELSE                                                       
              DISPLAY ' FILE CLIENT NOT OPEN : ' FS-CLIENT            
              PERFORM FONCTION-FIN-PROGRAMME                          
           END-IF.                                                    
        FONCTION-PROGRAMME.                                           
           PERFORM FONCTION-AFFICHER-CLIENT. 
        FONCTION-AFFICHER-CLIENT.                                 
           PERFORM FONCTION-READ-CLIENT                           
           MOVE 0 TO WS-COMPTEUR                                  
           PERFORM UNTIL WS-COMPTEUR = 5                          
               IF WS-POSIT = 'DB'                                 
                  DISPLAY WS-CLIENT                               
                  ADD 1 TO WS-COMPTEUR                            
               END-IF                                             
               PERFORM FONCTION-READ-CLIENT                       
           END-PERFORM.                                           
        FONCTION-READ-CLIENT.                                     
           READ FCLIENT INTO WS-CLIENT                            
           AT END MOVE 'Y' TO WS-END-OF-FILE                      
           END-READ.                                              
        FONCTION-FIN-PROGRAMME.                                   
           CLOSE FCLIENT.                                         
           STOP RUN.                                                                                                                                                                                                                                 