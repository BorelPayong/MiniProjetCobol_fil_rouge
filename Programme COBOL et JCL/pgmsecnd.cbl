      ************************************************************** 
      *SOUS PROGRAMME POUR FAIRE L'EDITION                         * 
      ************************************************************** 
        IDENTIFICATION DIVISION.                                     
        PROGRAM-ID. PGMSECND.                                        
        ENVIRONMENT DIVISION.                                        
        INPUT-OUTPUT SECTION.                                        
        FILE-CONTROL.                                                
           SELECT FPRINT ASSIGN TO DDPRINT                           
           ORGANIZATION IS SEQUENTIAL                                
           ACCESS MODE IS SEQUENTIAL                                 
           FILE STATUS IS FS-PRINT.                                  
        DATA DIVISION.                                               
        FILE SECTION.                                                
        FD FPRINT.                                                   
        01 REC-PRT.                                                  
           05 ENR-PRT PIC X(80).      
        WORKING-STORAGE SECTION.                            
        01 FS-PRINT PIC 9(2).                               
        01 WS-LIGNE01 PIC X(80) VALUE ALL '*'.              
        01 WS-LIGNE02.                                      
           05 FILLER PIC X(1) VALUE '!'.                    
           05 FILLER PIC X(29) VALUE ALL ' '.               
           05 WS-ENTETE PIC X(20).                          
           05 FILLER PIC X(29) VALUE ALL ' '.               
           05 FILLER PIC X(1) VALUE '!'.                    
        01 WS-LIGNE03.                                      
           05 FILLER PIC X(1) VALUE '!'.                    
           05 WS-CODE PIC X(10) VALUE ' CODE : '.           
           05 FILLER PIC X(8) VALUE ALL ' '.                
           05 WS-CODE-VALUE PIC X(10).                      
           05 FILLER PIC X(1) VALUE '*'.                    
           05 WS-LIBELLE PIC X(11) VALUE ' LIBELLE : '.     
           05 FILLER PIC X(8) VALUE ALL ' '.                
           05 WS-LIBELLE-VALUE PIC X(30).                   
           05 FILLER PIC X(1) VALUE '!'.     
        LINKAGE SECTION.                                            
        01 LS-CODE PIC X(2).                                        
        01 LS-LIBELLE PIC X(30).                                    
        01 LS-FIRST-ENR PIC X(1).                                   
        01 LS-ENTETE PIC X(1).                                      
        PROCEDURE DIVISION USING LS-CODE, LS-LIBELLE,               
                                 LS-FIRST-ENR, LS-ENTETE.           
           PERFORM FONCTION-DEBUT-PROGRAMME                         
           PERFORM FONCTION-PROGRAMME                               
           PERFORM FONCTION-FIN-PROGRAMME.
        FONCTION-DEBUT-PROGRAMME.                                   
           DISPLAY 'DEBUT DU PROGRAMME'                             
           IF LS-FIRST-ENR = 'O'                                    
              OPEN OUTPUT FPRINT                                    
              IF FS-PRINT = 00                                      
                 DISPLAY ' FILE PRINT OPEN SUCCES : ' FS-PRINT      
              ELSE                                                  
                 DISPLAY ' FILE PRINT NOT OPEN : ' FS-PRINT         
                 PERFORM FONCTION-FIN-PROGRAMME                     
              END-IF                                                
           END-IF.                                                  
           IF LS-FIRST-ENR = 'C'                                    
              CLOSE FPRINT                                          
              PERFORM FONCTION-FIN-PROGRAMME                        
           END-IF.         
        FONCTION-PROGRAMME.                                            
           IF LS-FIRST-ENR = 'O'                                       
              MOVE WS-LIGNE01 TO REC-PRT                               
              WRITE REC-PRT AFTER ADVANCING PAGE                       
              EVALUATE LS-ENTETE                                       
                 WHEN 'R'                                              
                      MOVE ' REGION ' TO WS-ENTETE                     
                 WHEN 'A'                                              
                      MOVE ' ACTIVITE PROFESSIONNELLE ' TO WS-ENTETE   
                 WHEN 'N'                                              
                      MOVE ' NATURE DU COMPTE ' TO WS-ENTETE           
                 WHEN OTHER                                            
                      MOVE ' ENTETE ' TO WS-ENTETE                     
              END-EVALUATE                                             
              MOVE WS-LIGNE02 TO REC-PRT                               
              WRITE REC-PRT                                            
              MOVE WS-LIGNE01 TO REC-PRT                               
              WRITE REC-PRT                                            
           END-IF.                                                  
           MOVE LS-CODE TO WS-CODE-VALUE                        
           MOVE LS-LIBELLE TO WS-LIBELLE-VALUE                  
           MOVE WS-LIGNE03 TO REC-PRT                           
           WRITE REC-PRT AFTER ADVANCING 2 LINES.               
        FONCTION-FIN-PROGRAMME.                                 
           EXIT PROGRAM.                                                                                                                                                                                                                                                    
