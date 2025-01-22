      ************************************************************** 
      *PROGRAMME POUR FAIRE LE CALCUL DU MONTANT GENERAL DES       * 
      *DEBITEURS ET CREDITEUR AINSI QUE DU LEURS MOYENNES          * 
      ************************************************************** 
        IDENTIFICATION DIVISION.                                     
        PROGRAM-ID. QUEST15.                                         
        ENVIRONMENT DIVISION.                                        
        INPUT-OUTPUT SECTION.                                        
        FILE-CONTROL.                                                
           SELECT FCLIENT ASSIGN TO DDCLIENT                         
           ORGANIZATION IS INDEXED                                   
           ACCESS IS SEQUENTIAL                                      
           RECORD KEY IS NUM-COMPTE                                  
           FILE STATUS IS FS-CLIENT.                                 
           SELECT FPRINT1 ASSIGN TO DDPRINT                          
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
        01 WS-LIGNE01 PIC X(80) VALUE ALL '*'.    
        01 WS-LIGNE02.                                             
           05 FILLER PIC X(1) VALUE '*'.                           
           05 FILLER PIC X(17) VALUE ' MONTANT GENERAL '.          
           05 WS-MONT-LIBELLE PIC X(13).                           
           05 FILLER PIC X(9) VALUE ALL ' '.                       
           05 FILLER PIC X(1) VALUE '*'.                           
           05 FILLER PIC X(9) VALUE ALL ' '.                       
           05 WS-MONT-VALUE PIC 9999999999999999.                  
           05 FILLER PIC X(9) VALUE ALL ' '.                       
           05 FILLER PIC X(1) VALUE '*'.   
        01 WS-LIGNE03.                                         
           05 FILLER PIC X(1) VALUE '*'.                       
           05 FILLER PIC X(9) VALUE ' MONTANT '.               
           05 WS-MONT-MOYE PIC X(14).                          
           05 FILLER PIC X(7) VALUE ' MOYEN '.                 
           05 FILLER PIC X(9) VALUE ALL ' '.                   
           05 FILLER PIC X(1) VALUE '*'.                       
           05 FILLER PIC X(9) VALUE ALL ' '.                   
           05 WS-MONT-MOYE-LIB PIC 9999999999999999.99 .       
           05 FILLER PIC X(9) VALUE ALL ' '.                   
           05 FILLER PIC X(1) VALUE '*'.   
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
        01 WS-SOLDE-TOTAL-DB PIC 9(16).         
        01 WS-SOLDE-TOTAL-CR PIC 9(16).         
        01 WS-T-NBR-DB PIC 9(2) VALUE 0.    
        01 WS-T-NBR-CR PIC 9(2) VALUE 0.                             
        01 WS-MOYEN-DB PIC 9(10)V9(2).                               
        01 WS-MOYEN-CR PIC 9(10)V9(2).                               
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
           PERFORM FONCTION-CALC-SOLD-NBR-DBCR                      
           PERFORM FONCTION-CALC-MOY-NBR-DBCR                       
           PERFORM FONCTION-PRINT-DB-CR.                            
        FONCTION-CALC-SOLD-NBR-DBCR.                                
           PERFORM FONCTION-READ-CLIENT                             
           PERFORM UNTIL WS-END-OF-FILE = 'Y'                       
              IF WS-POSIT = 'DB'                                    
                MOVE WS-SOLDE TO WS-SOLDE-TOTAL-DB                  
                ADD 1 TO WS-T-NBR-DB                                
              ELSE                                                  
                MOVE WS-SOLDE TO WS-SOLDE-TOTAL-CR                  
                ADD 1 TO WS-T-NBR-CR                                
              END-IF                                                
              PERFORM FONCTION-READ-CLIENT                          
           END-PERFORM.   
        FONCTION-CALC-MOY-NBR-DBCR.                       
           COMPUTE WS-MOYEN-DB = WS-SOLDE-TOTAL-DB /      
                                      WS-T-NBR-DB         
           COMPUTE WS-MOYEN-CR = WS-SOLDE-TOTAL-CR /      
                                      WS-T-NBR-CR.      
        FONCTION-PRINT-DB-CR.                         
           MOVE WS-LIGNE01 TO REC-PRT1                
           WRITE REC-PRT1                             
           MOVE ' DEBITEUR ' TO WS-MONT-LIBELLE       
           MOVE WS-SOLDE-TOTAL-DB TO WS-MONT-VALUE    
           MOVE WS-LIGNE02 TO REC-PRT1                
           WRITE REC-PRT1                             
           MOVE WS-LIGNE01 TO REC-PRT1                
           WRITE REC-PRT1                             
           MOVE ' CREDITEUR ' TO WS-MONT-LIBELLE      
           MOVE WS-SOLDE-TOTAL-CR TO WS-MONT-VALUE    
           MOVE WS-LIGNE02 TO REC-PRT1                
           WRITE REC-PRT1                             
           MOVE WS-LIGNE01 TO REC-PRT1                
           WRITE REC-PRT1                             
           MOVE ' DEBITEUR ' TO WS-MONT-MOYE          
           MOVE WS-MOYEN-DB TO WS-MONT-MOYE-LIB       
           MOVE WS-LIGNE03 TO REC-PRT1                
           WRITE REC-PRT1      
           MOVE WS-LIGNE01 TO REC-PRT1                     
           WRITE REC-PRT1                                  
           MOVE ' CREDITEUR ' TO WS-MONT-MOYE              
           MOVE WS-MOYEN-CR TO WS-MONT-MOYE-LIB            
           MOVE WS-LIGNE03 TO REC-PRT1                     
           WRITE REC-PRT1                                  
           MOVE WS-LIGNE01 TO REC-PRT1                     
           WRITE REC-PRT1.                                 
        FONCTION-READ-CLIENT.                              
           READ FCLIENT INTO WS-CLIENT                     
           AT END MOVE 'Y' TO WS-END-OF-FILE               
           END-READ.                                       
        FONCTION-FIN-PROGRAMME.                            
           CLOSE FCLIENT.                                  
           CLOSE FPRINT1.                                  
           STOP RUN.                                                                                                                                                                                                                                                                                                                                                                                                                                               