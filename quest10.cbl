      ************************************************************** 
      *PROGRAMME POUR FAIRE LE PRINT DE MON FICHIER CLIENT AVEC    * 
      *AVEC DES SAUT DE LIGNE SELON LA REGION ET SELON             * 
      *L'ACTIVITE PRO                                              * 
      ************************************************************** 
        IDENTIFICATION DIVISION.                                     
        PROGRAM-ID. QUEST10.                                         
        ENVIRONMENT DIVISION.                                        
        INPUT-OUTPUT SECTION.                                        
        FILE-CONTROL.                                                
           SELECT FCLIENT ASSIGN TO DDCLIENT                         
           ORGANIZATION IS INDEXED                                   
           ACCESS IS SEQUENTIAL                                      
           RECORD KEY IS NUM-COMPTE                                  
           ALTERNATE RECORD KEY IS CODE-REGION                       
           ALTERNATE RECORD KEY IS ACTI-PRO                          
           FILE STATUS IS FS-CLIENT.    
           SELECT FPRINT1 ASSIGN TO DPRIN1                
           ORGANIZATION IS SEQUENTIAL                     
           ACCESS MODE IS SEQUENTIAL                      
           FILE STATUS IS FS-PRINT1.                      
        DATA DIVISION.                                    
        FILE SECTION.                                     
        FD FPRINT1.                                       
        01 REC-PRT1.                                      
           05 ENR-PRT1 PIC X(80).   
        FD FCLIENT.                                       
        01 CLIENT.                                        
           05 NUM-COMPTE PIC X(3).                        
           05 CODE-REGION PIC X(2).                       
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
        01 WS-VAR-IMPRE.                                               
           05 WS-ETOILE PIC X(80) VALUE ALL '*'.                       
           05 WS-ACTIPRO PIC X(30) VALUE 'CLASSEMENT PAR ACTIVITE PRO'.
           05 WS-REGION PIC X(30) VALUE ' CLASSEMENT PAR REGION '.     
        01 WS-CLIENT.                                                  
           05 WS-NUM-COMPTE PIC X(3).                                  
           05 WS-CODE-REGION PIC X(2).                                 
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
        01 FS-PRINT1 PIC X(2).                                  
        01 WS-END-OF-FILE PIC X(1).                             
        01 WS-PREVIOUS-REGION PIC 9(2).                         
        01 WS-PREVIOUS-ACTI-PRO PIC 9(2).                       
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
           OPEN OUTPUT FPRINT1                                    
           IF FS-PRINT1 = '00'                                    
              DISPLAY ' FILE PRINT OPEN SUCCES : ' FS-PRINT1      
           ELSE                                                   
              DISPLAY ' FILE PRINT NOT OPEN : ' FS-PRINT1         
              PERFORM FONCTION-FIN-PROGRAMME                      
           END-IF.    
        FONCTION-PROGRAMME.                        
           PERFORM FONCTION-WRITE-REGION.          
           PERFORM FONCTION-WRITE-ACTIPRO.  
        FONCTION-WRITE-REGION.                            
           MOVE 0 TO WS-CODE-REGION                       
           MOVE WS-ETOILE TO REC-PRT1                     
           WRITE REC-PRT1                                 
           MOVE WS-REGION TO REC-PRT1                     
           WRITE REC-PRT1                                 
           MOVE WS-ETOILE TO REC-PRT1                     
           WRITE REC-PRT1                                 
           START FCLIENT KEY IS >= CODE-REGION            
           PERFORM FONCTION-READ-CLIENT.                  
           MOVE CODE-REGION TO WS-PREVIOUS-REGION.  
           PERFORM UNTIL WS-END-OF-FILE = 'Y'                      
              MOVE WS-CLIENT TO REC-PRT1                           
              IF CODE-REGION = WS-PREVIOUS-REGION                  
                WRITE REC-PRT1                                     
              ELSE                                                 
                WRITE REC-PRT1 AFTER ADVANCING 2 LINES             
              END-IF                                               
              MOVE CODE-REGION TO WS-PREVIOUS-REGION               
              PERFORM FONCTION-READ-CLIENT                         
           END-PERFORM.    
        FONCTION-WRITE-ACTIPRO.                         
           MOVE 'O' TO WS-END-OF-FILE                   
           MOVE 0 TO WS-ACTI-PRO                        
           MOVE WS-ETOILE TO REC-PRT1                   
           WRITE REC-PRT1                               
           MOVE WS-ACTIPRO TO REC-PRT1                  
           WRITE REC-PRT1                               
           MOVE WS-ETOILE TO REC-PRT1                   
           WRITE REC-PRT1                               
           START FCLIENT KEY IS >= ACTI-PRO             
           PERFORM FONCTION-READ-CLIENT                 
           MOVE ACTI-PRO TO WS-PREVIOUS-ACTI-PRO 
           PERFORM UNTIL WS-END-OF-FILE = 'Y'                  
              MOVE WS-CLIENT TO REC-PRT1                       
              IF ACTI-PRO = WS-PREVIOUS-ACTI-PRO               
                WRITE REC-PRT1                                 
              ELSE                                             
                WRITE REC-PRT1 AFTER ADVANCING 2 LINES         
              END-IF                                           
              MOVE ACTI-PRO TO WS-PREVIOUS-ACTI-PRO            
              PERFORM FONCTION-READ-CLIENT                     
           END-PERFORM.  
        FONCTION-READ-CLIENT.                       
           READ FCLIENT INTO WS-CLIENT              
           AT END MOVE 'Y' TO WS-END-OF-FILE        
           END-READ.                                
        FONCTION-FIN-PROGRAMME.                     
           CLOSE FCLIENT.                           
           CLOSE FPRINT1.                           
           STOP RUN.                                                                                                                                                                                                                                                                                                                                                                                                                  