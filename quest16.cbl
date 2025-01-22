      **************************************************************    
      *PROGRAMME POUR AFFICHER LE SOMME TOTAL DES DB ET CR PAR     *    
      *REGION                                                      *    
      **************************************************************    
        IDENTIFICATION DIVISION.                                        
        PROGRAM-ID. QUEST16.                                            
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
        01 WS-SOLDE-T-DB1 PIC 9(10) VALUE 0.                 
        01 WS-SOLDE-T-DB2 PIC 9(10) VALUE 0.                 
        01 WS-SOLDE-T-DB3 PIC 9(10) VALUE 0.                 
        01 WS-SOLDE-T-DB4 PIC 9(10) VALUE 0.                 
        01 WS-SOLDE-T-CR1 PIC 9(10) VALUE 0.                 
        01 WS-SOLDE-T-CR2 PIC 9(10) VALUE 0.                 
        01 WS-SOLDE-T-CR3 PIC 9(10) VALUE 0.                 
        01 WS-SOLDE-T-CR4 PIC 9(10) VALUE 0.                 
        01 WS-REGION-VALUE PIC 9(2).                         
           88 REGION-01 VALUE 01.                            
           88 REGION-02 VALUE 02.                            
           88 REGION-03 VALUE 03.                            
           88 REGION-04 VALUE 04.   
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
           PERFORM FONCTION-CALCL-REGION                              
           PERFORM FONCTION-AFFICHER-REGION.  
        FONCTION-CALCL-REGION.                                       
           PERFORM FONCTION-READ-CLIENT                              
           PERFORM UNTIL WS-END-OF-FILE = 'Y'                        
              MOVE WS-CODE-REGION TO WS-REGION-VALUE                 
              PERFORM FONCTION-CALC-DBCR-REG                         
              PERFORM FONCTION-READ-CLIENT                           
           END-PERFORM.   
        FONCTION-CALC-DBCR-REG.                                   
           EVALUATE TRUE                                          
              WHEN REGION-01                                      
                   IF WS-POSIT = 'DB'                             
                      ADD WS-SOLDE TO WS-SOLDE-T-DB1              
                   ELSE                                           
                      ADD WS-SOLDE TO WS-SOLDE-T-CR1              
                   END-IF                                         
              WHEN REGION-02                                      
                   IF WS-POSIT = 'DB'                             
                      ADD WS-SOLDE TO WS-SOLDE-T-DB2              
                   ELSE                                           
                      ADD WS-SOLDE TO WS-SOLDE-T-CR2              
                   END-IF                                         
              WHEN REGION-03                                      
                   IF WS-POSIT = 'DB'                             
                      ADD WS-SOLDE TO WS-SOLDE-T-DB3              
                   ELSE                                           
                      ADD WS-SOLDE TO WS-SOLDE-T-CR3              
                   END-IF   
             WHEN REGION-04                                       
                  IF WS-POSIT = 'DB'                              
                     ADD WS-SOLDE TO WS-SOLDE-T-DB4               
                  ELSE                                            
                     ADD WS-SOLDE TO WS-SOLDE-T-CR4               
                  END-IF                                          
             WHEN OTHER                                           
                  DISPLAY ' REGION NOT FOUND '                    
           END-EVALUATE. 
        FONCTION-AFFICHER-REGION.                                       
           DISPLAY ' REGION 01 : '                                      
           DISPLAY ' MONTANT TOTAL DEBITEUR : ' WS-SOLDE-T-DB1          
           DISPLAY ' MONTANT TOTAL CREDITEUR : ' WS-SOLDE-T-CR1         
           DISPLAY ' REGION 02 : '                                      
           DISPLAY ' MONTANT TOTAL DEBITEUR : ' WS-SOLDE-T-DB2          
           DISPLAY ' MONTANT TOTAL CREDITEUR : ' WS-SOLDE-T-CR2         
           DISPLAY ' REGION 03 : '                                      
           DISPLAY ' MONTANT TOTAL DEBITEUR : ' WS-SOLDE-T-DB3          
           DISPLAY ' MONTANT TOTAL CREDITEUR : ' WS-SOLDE-T-CR3         
           DISPLAY ' REGION 04 : '                                      
           DISPLAY ' MONTANT TOTAL DEBITEUR : ' WS-SOLDE-T-DB4          
           DISPLAY ' MONTANT TOTAL CREDITEUR : ' WS-SOLDE-T-CR4. 
        FONCTION-READ-CLIENT.                                
           READ FCLIENT INTO WS-CLIENT                       
           AT END MOVE 'Y' TO WS-END-OF-FILE                 
           END-READ.                                         
        FONCTION-FIN-PROGRAMME.                              
           CLOSE FCLIENT.                                    
           STOP RUN.                                         
                                                                                                                                                                                                                                                                                                                                                                                                                                    