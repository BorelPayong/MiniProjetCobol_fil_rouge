     **************************************************************
      *PROGRAMME POUR FAIRE LE PRINT DES FICHIER REGION            *
      *DES ACTIVITE PRO ET DE LA NATURE DES COMPTE. ILS SERONT     *
      *EDITE DANS UN SOUS PROGRAMME SOUS FORME DE TABLEAU AVEC     *
      *UN SAUT DE 2 LIGNE D'UN DATASET A UN AUTRE ET UN SAUT D'UNE* 
      *LIGNE ENTRE CHAQUE ENREGISTREMENT                           *
      **************************************************************
        IDENTIFICATION DIVISION.                                      
        PROGRAM-ID. QUEST14.                                          
        ENVIRONMENT DIVISION.                                         
        INPUT-OUTPUT SECTION.                                         
        FILE-CONTROL.                                                 
           SELECT FREGION ASSIGN TO DDREGION                          
           ORGANIZATION IS INDEXED                                    
           ACCESS IS SEQUENTIAL                                       
           RECORD KEY IS CODE-REGION                                  
           FILE STATUS IS FS-REGION.      
           SELECT FACTIPRO ASSIGN TO DDACTIPR               
           ORGANIZATION IS INDEXED                          
           ACCESS IS SEQUENTIAL                             
           RECORD KEY IS CODE-PROFESSION                    
           FILE STATUS IS FS-ACTIPRO.                       
           SELECT FNATCOMP ASSIGN TO DDNATCOM               
           ORGANIZATION IS INDEXED                          
           ACCESS IS SEQUENTIAL                             
           RECORD KEY IS CODE-COMPTE                        
           FILE STATUS IS FS-NATCOMP.                       
        DATA DIVISION.                                      
        FILE SECTION.                                       
        FD FREGION.                                         
        01 REGION.                                          
           05 CODE-REGION PIC X(2).                         
           05 NOM-REGION PIC X(15).                         
           05 FILLER PIC X(63).   
        FD FACTIPRO.                                              
        01 ACTI-PRO.                                              
           05 CODE-PROFESSION PIC X(2).                           
           05 LIBELLE-PROFESSION PIC X(20).                       
           05 FILLER PIC X(58).                                   
        FD FNATCOMP.                                              
        01 NAT-COMPTE.                                            
           05 CODE-COMPTE PIC X(2).                               
           05 NATURE-COMPTE PIC X(30).                            
           05 FILLER PIC X(48).    
        WORKING-STORAGE SECTION.                               
        01 WS-REGION.                                          
           05 WS-CODE-REGION PIC X(2).                         
           05 WS-NOM-REGION PIC X(15).                         
           05 FILLER PIC X(63).                                
        01 FS-REGION PIC X(2).                                 
        01 WS-ACTI-PRO.                                        
           05 WS-CODE-PROFESSION PIC X(2).                     
           05 WS-LIBELLE-PROFESSION PIC X(20).                 
           05 FILLER PIC X(58).                                
        01 FS-ACTIPRO PIC X(2).                                
        01 WS-NAT-COMPTE.                                      
           05 WS-CODE-COMPTE PIC X(2).                         
           05 WS-NATURE-COMPTE PIC X(20).                      
           05 FILLER PIC X(58).                                
        01 FS-NATCOMP PIC X(2).                                
        01 WS-END-OF-FILE PIC X(1).                            
        01 WS-FIRST-ENR PIC X(1).                              
        01 WS-ENTETE PIC X(1).                                 
        PROCEDURE DIVISION.  
           PERFORM FONCTION-DEBUT-PROGRAMME   
           PERFORM FONCTION-PROGRAMME         
           PERFORM FONCTION-FIN-PROGRAMME.  
        FONCTION-DEBUT-PROGRAMME.                                  
           DISPLAY 'DEBUT DU PROGRAMME'                            
           OPEN I-O FREGION                                        
           IF FS-REGION = '00'                                     
              DISPLAY ' FILE REGION OPEN SUCCES : ' FS-REGION      
           ELSE                                                    
              DISPLAY ' FILE REGION NOT OPEN : ' FS-REGION         
              PERFORM FONCTION-FIN-PROGRAMME                       
           END-IF.                                                 
           OPEN I-O FACTIPRO.                                      
           IF FS-ACTIPRO = '00'                                    
              DISPLAY ' FILE REGION OPEN SUCCES : ' FS-ACTIPRO     
           ELSE                                                    
              DISPLAY ' FILE REGION NOT OPEN : ' FS-ACTIPRO        
              PERFORM FONCTION-FIN-PROGRAMME                       
           END-IF.                                                 
           OPEN I-O FNATCOMP.                                      
           IF FS-NATCOMP = '00'                                    
              DISPLAY ' FILE NATURE COMPTE OPEN : ' FS-NATCOMP     
           ELSE  
              DISPLAY ' FILE NATURE COMPTE NOT OPEN : ' FS-NATCOMP        
              PERFORM FONCTION-FIN-PROGRAMME
           END-IF.
        FONCTION-PROGRAMME.                                       
           PERFORM FONCTION-PRINT-REGION                          
           PERFORM FONCTION-PRINT-ACTIPRO                         
           PERFORM FONCTION-PRINT-NATCOMP.    
        FONCTION-PRINT-REGION.                                       
           MOVE 'O' TO WS-FIRST-ENR                                  
           MOVE 'O' TO WS-END-OF-FILE                                
           MOVE 'R' TO WS-ENTETE                                     
           PERFORM FONCTION-READ-REGION                              
           PERFORM UNTIL WS-END-OF-FILE = 'Y'                        
              CALL 'PGMSECND' USING WS-CODE-REGION, WS-NOM-REGION,   
                                    WS-FIRST-ENR, WS-ENTETE          
              PERFORM FONCTION-READ-REGION                           
              MOVE 'N' TO WS-FIRST-ENR                               
           END-PERFORM.                                              
           IF WS-END-OF-FILE = 'Y'                                   
              MOVE 'C' TO WS-FIRST-ENR                               
              CALL 'PGMSECND' USING WS-CODE-REGION, WS-NOM-REGION,   
                                    WS-FIRST-ENR, WS-ENTETE          
           END-IF.         
        FONCTION-PRINT-ACTIPRO.                                      
           MOVE 'O' TO WS-FIRST-ENR                                  
           MOVE 'O' TO WS-END-OF-FILE                                
           MOVE 'A' TO WS-ENTETE                                     
           PERFORM FONCTION-READ-ACTIPRO                             
           PERFORM UNTIL WS-END-OF-FILE = 'Y'                        
              CALL 'PGMSECND' USING WS-CODE-PROFESSION,              
                                    WS-LIBELLE-PROFESSION,           
                                    WS-FIRST-ENR, WS-ENTETE          
              PERFORM FONCTION-READ-ACTIPRO                          
              MOVE 'N' TO WS-FIRST-ENR                               
           END-PERFORM.                                              
           IF WS-END-OF-FILE = 'Y'                                   
              MOVE 'C' TO WS-FIRST-ENR                               
              CALL 'PGMSECND' USING WS-CODE-PROFESSION,              
                                    WS-LIBELLE-PROFESSION,           
                                    WS-FIRST-ENR, WS-ENTETE          
           END-IF.     
        FONCTION-PRINT-NATCOMP.                                        
           MOVE 'O' TO WS-FIRST-ENR                                    
           MOVE 'O' TO WS-END-OF-FILE                                  
           MOVE 'N' TO WS-ENTETE                                       
           PERFORM FONCTION-READ-NATCOMP                               
           PERFORM UNTIL WS-END-OF-FILE = 'Y'                          
              CALL 'PGMSECND' USING WS-CODE-COMPTE, WS-NATURE-COMPTE,  
                                    WS-FIRST-ENR, WS-ENTETE            
              PERFORM FONCTION-READ-NATCOMP                            
              MOVE 'N' TO WS-FIRST-ENR                                 
           END-PERFORM.                                                
           IF WS-END-OF-FILE = 'Y'                                     
              MOVE 'C' TO WS-FIRST-ENR                                 
              CALL 'PGMSECND' USING WS-CODE-COMPTE, WS-NATURE-COMPTE,  
                                    WS-FIRST-ENR, WS-ENTETE            
           END-IF.     
        FONCTION-READ-REGION.                             
           READ FREGION INTO WS-REGION                    
              AT END MOVE 'Y' TO WS-END-OF-FILE           
           END-READ.                                      
        FONCTION-READ-ACTIPRO.                            
           READ FACTIPRO INTO WS-ACTI-PRO                 
              AT END MOVE 'Y' TO WS-END-OF-FILE           
           END-READ.                                      
        FONCTION-READ-NATCOMP.                            
           READ FNATCOMP INTO WS-NAT-COMPTE               
              AT END MOVE 'Y' TO WS-END-OF-FILE           
           END-READ.                                      
        FONCTION-FIN-PROGRAMME.                           
           CLOSE FREGION                                  
           CLOSE FACTIPRO                                 
           CLOSE FNATCOMP                                 
           STOP RUN.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
