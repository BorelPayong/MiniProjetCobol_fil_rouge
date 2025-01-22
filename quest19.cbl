      **************************************************************   
      *PROGRAMME POUR EXTRAIRE LES ENREGITREMENT D'UN CLIENT DONNE *   
      *ET CALCUL DU NOMBRE DE MOUVEMENT DE CES COMPTE AINSI QUE DU *   
      *MONTANT TOTAL DES MOUVEMENTS                                *   
      **************************************************************   
        IDENTIFICATION DIVISION.                                       
        PROGRAM-ID. QUEST19.                                           
        ENVIRONMENT DIVISION.                                          
        INPUT-OUTPUT SECTION.                                          
        FILE-CONTROL.                                                  
           SELECT FMOUVEM ASSIGN TO DDMOUVEM                           
           ORGANIZATION IS SEQUENTIAL                                  
           ACCESS IS SEQUENTIAL                                        
           FILE STATUS IS FS-MOUVEM.                                   
           SELECT FMOUVEM-WK ASSIGN TO FWORK.                          
           SELECT FMOUVEM-OUT ASSIGN TO FOUT.                          
        DATA DIVISION.                                                 
        FILE SECTION. 
        FD FMOUVEM.                                            
        01 MOUVEM.                                             
           05 NUM-COMPTE PIC X(3).                             
           05 LIBELLE-MOUV PIC X(15).                          
           05 MONT-MOUV PIC 9(6).                              
           05 SENS-MOUV PIC X(2).                              
           05 NAT-MOUV PIC X(3).                               
           05 DATE-MOUV PIC X(10).                             
           05 FILLER PIC X(43).                                
        FD FMOUVEM-OUT.                                        
        01 MOUVEM-OUT.                                         
           05 FILLER PIC X(80).     
        SD FMOUVEM-WK.                                          
        01 MOUVEM-WK.                                           
           05 NUM-COMPTE-WK PIC X(3).                           
           05 LIBELLE-MOUV-WK PIC X(15).                        
           05 MONT-MOUV-WK PIC 9(6).                            
           05 SENS-MOUV-WK PIC X(2).                            
           05 NAT-MOUV-WK PIC X(3).                             
           05 DATE-MOUV-WK PIC X(10).                           
           05 FILLER PIC X(43).                                 
        WORKING-STORAGE SECTION.                                
        01 WS-MOUVEM.                                           
           05 WS-NUM-COMPTE PIC X(3).                           
           05 WS-LIBELLE-MOUV PIC X(15).                        
           05 WS-MONT-MOUV PIC 9(6).                            
           05 WS-SENS-MOUV PIC X(2).                            
           05 WS-NAT-MOUV PIC X(3).                             
           05 WS-DATE-MOUV PIC X(10).                           
           05 FILLER PIC X(43).   
        01 FS-MOUVEM PIC X(2).                                    
        01 WS-END-OF-FILE PIC X(1).                               
        01 WS-CLIENT-NUM-COMPTE PIC X(3).                         
        01 WS-NBRE-MOUV PIC 9(2) VALUE 0.                         
        01 WS-T-MONT-MOUV PIC S9(7) VALUE 0.                      
        01 WS-T-MONT-AFF PIC -9(7).                               
        PROCEDURE DIVISION.                                       
           PERFORM FONCTION-DEBUT-PROGRAMME.                      
           PERFORM FONCTION-PROGRAMME.                            
           PERFORM FONCTION-FIN-PROGRAMME.   
        FONCTION-DEBUT-PROGRAMME.                                      
           DISPLAY 'DEBUT DU PROGRAMME'.                               
           OPEN INPUT FMOUVEM                                          
           IF FS-MOUVEM = '00'                                         
              DISPLAY ' FILE MOUVEM OPEN SUCCES : ' FS-MOUVEM          
           ELSE                                                        
              DISPLAY ' FILE MOUVEM NOT OPEN : ' FS-MOUVEM             
              PERFORM FONCTION-FIN-PROGRAMME                           
           END-IF.                                                     
           DISPLAY ' VEUILLEZ ENTRE LE NUMERO DE COMPTE DU CLIENT : '  
           ACCEPT WS-CLIENT-NUM-COMPTE.                                
        FONCTION-PROGRAMME.                                            
           SORT FMOUVEM-WK                                             
                ON ASCENDING KEY NUM-COMPTE-WK                         
                INPUT PROCEDURE FONCTION-RECUP-CLIENT                  
                OUTPUT PROCEDURE IS FONCTION-CALC-MOUV                 
           IF SORT-RETURN > 0 DISPLAY ' SORT FILED '                   
           DISPLAY ' FIN DU TRI '.    
        FONCTION-RECUP-CLIENT.                                    
           PERFORM FONCTION-READ-FMOUV                            
           PERFORM UNTIL WS-END-OF-FILE = 'Y'                     
              IF NUM-COMPTE = WS-CLIENT-NUM-COMPTE                
                 RELEASE MOUVEM-WK FROM MOUVEM                    
              END-IF                                              
              PERFORM FONCTION-READ-FMOUV                         
              DISPLAY ' MOUVEM ' MOUVEM                           
           END-PERFORM                                            
           CLOSE FMOUVEM.  
        FONCTION-CALC-MOUV.                                          
           OPEN OUTPUT FMOUVEM-OUT                                   
           MOVE 'O' TO WS-END-OF-FILE                                
           PERFORM FONCTION-READ-FMOUV-OUT                           
           PERFORM UNTIL WS-END-OF-FILE = 'Y'                        
              IF SENS-MOUV-WK = 'CR'                                 
                 ADD MONT-MOUV-WK TO WS-T-MONT-MOUV                  
              ELSE                                                   
                 SUBTRACT MONT-MOUV-WK FROM WS-T-MONT-MOUV           
              END-IF                                                 
              ADD 1 TO WS-NBRE-MOUV                                  
              WRITE MOUVEM-OUT FROM WS-MOUVEM                        
              PERFORM FONCTION-READ-FMOUV-OUT                        
           END-PERFORM                                               
           CLOSE FMOUVEM-OUT                                         
           PERFORM FONCTION-AFFICHER-MOUV.                           
        FONCTION-READ-FMOUV.                                         
           READ FMOUVEM AT END MOVE 'Y' TO WS-END-OF-FILE            
           END-READ. 
        FONCTION-READ-FMOUV-OUT.                                   
           RETURN FMOUVEM-WK INTO WS-MOUVEM                        
              AT END MOVE 'Y' TO WS-END-OF-FILE                    
           END-RETURN.                                             
        FONCTION-AFFICHER-MOUV.                                    
           MOVE WS-T-MONT-MOUV TO WS-T-MONT-AFF                    
           DISPLAY ' POUR LE CLIENT : ' WS-CLIENT-NUM-COMPTE       
           DISPLAY ' NOMBRE DE MOUVEMENT : ' WS-NBRE-MOUV          
           DISPLAY ' MONTANT DES MOUVEMENT : ' WS-T-MONT-AFF.      
        FONCTION-FIN-PROGRAMME.                                    
           STOP RUN.                                                                                                                                                                                                                                                                                                                                                                                