      **************************************************************  
      *PROGRAMME POUR AJOUTER UN ENREGISTREMENT DANS LE KSDS CLIENT*  
      **************************************************************  
        IDENTIFICATION DIVISION.                                      
        PROGRAM-ID. QUEST13.                                          
        ENVIRONMENT DIVISION.                                         
        INPUT-OUTPUT SECTION.                                         
        FILE-CONTROL.                                                 
           SELECT FCLIENT ASSIGN TO DDCLIENT                          
           ORGANIZATION IS INDEXED                                    
           ACCESS IS RANDOM                                           
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
           05 ACTI-PRO PIC 9(2).                 
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
           05 WS-ACTI-PRO PIC 9(2).                      
           05 WS-SIT-SOCIAL PIC X(1).                    
           05 WS-ADRESSE PIC X(10).                      
           05 WS-SOLDE PIC 9(10).                        
           05 WS-POSIT PIC X(2).                         
           05 FILLER PIC X(19).                          
        01 FS-CLIENT PIC 9(2).     
        PROCEDURE DIVISION.                                          
           PERFORM FONCTION-DEBUT-PROGRAMME.                         
           PERFORM FONCTION-PROGRAMME.                               
           PERFORM FONCTION-FIN-PROGRAMME.                           
        FONCTION-DEBUT-PROGRAMME.                                    
           DISPLAY 'DEBUT DU PROGRAMME'.                             
           OPEN I-O FCLIENT.                                         
           IF FS-CLIENT = 00                                         
              DISPLAY ' FILE CLIENT OPEN SUCCES : ' FS-CLIENT        
           ELSE                                                      
              DISPLAY ' FILE CLIENT NOT OPEN : ' FS-CLIENT           
           END-IF.                                                   
        FONCTION-PROGRAMME.                                          
           PERFORM FONCTION-ADD-CLIENT.                              
           PERFORM FONCTION-READ-CLIENT.   
        FONCTION-ADD-CLIENT.                                        
           MOVE '999' TO WS-NUM-COMPTE                              
           MOVE 01 TO  WS-CODE-REGION                               
           MOVE 40 TO  WS-NAT-COMPTE                                
           MOVE 'FRANCK' TO WS-NOM-CLIENT                           
           MOVE 'BOREL' TO WS-PRENOM-CLIENT                         
           MOVE 20000603 TO WS-DATE-NAIS                            
           MOVE 'M' TO WS-SEXE                                      
           MOVE 10 TO WS-ACTI-PRO                                   
           MOVE 'C' TO WS-SIT-SOCIAL                                
           MOVE '95170DEUIL' TO WS-ADRESSE                          
           MOVE 25000 TO WS-SOLDE                                   
           MOVE 'CR' TO WS-POSIT.                                   
           MOVE WS-CLIENT TO CLIENT                                 
           WRITE CLIENT                                             
              INVALID KEY DISPLAY ' NUM EXIST '                     
              NOT INVALID KEY DISPLAY ' CLIENT SAVE SUCCES '        
           END-WRITE.     
        FONCTION-READ-CLIENT.                                      
           MOVE '999' TO NUM-COMPTE                                
           READ FCLIENT                                            
             KEY IS NUM-COMPTE                                     
             INVALID KEY DISPLAY ' RECORD NOT FOUND '              
             NOT INVALID KEY DISPLAY ' RECORD IS : ' WS-CLIENT     
           END-READ.                                               
        FONCTION-FIN-PROGRAMME.                                    
           CLOSE FCLIENT.                                          
           STOP RUN.                                                                                                                                                                                                                                                         