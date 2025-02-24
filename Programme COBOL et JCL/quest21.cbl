      **************************************************************  
      *PROGRAMME POUR FUSIONNE LES FICHIER DES MOUVEMENT DE COMPTE *  
      *SUR 3 MOIS                                                  *  
      **************************************************************  
        IDENTIFICATION DIVISION.                                      
        PROGRAM-ID. QUEST21.                                          
        ENVIRONMENT DIVISION.                                         
        INPUT-OUTPUT SECTION.                                         
        FILE-CONTROL.                                                 
           SELECT FMOUVE1 ASSIGN TO DDMOUVE1                          
           ORGANIZATION IS SEQUENTIAL                                 
           ACCESS IS SEQUENTIAL                                       
           FILE STATUS IS FS-MOUVE1.                                  
           SELECT FMOUVE2 ASSIGN TO DDMOUVE2                          
           ORGANIZATION IS SEQUENTIAL                                 
           ACCESS IS SEQUENTIAL                                       
           FILE STATUS IS FS-MOUVE2.
           SELECT FMOUVE3 ASSIGN TO DDMOUVE3                        
           ORGANIZATION IS SEQUENTIAL                               
           ACCESS IS SEQUENTIAL                                     
           FILE STATUS IS FS-MOUVE3.                                
           SELECT FMOUVEM-WK ASSIGN TO FWORK.                       
           SELECT FMOUVEM-OUT ASSIGN TO FOUT.                       
        DATA DIVISION.                                              
        FILE SECTION.                                               
        FD FMOUVE1.                                                 
        01 MOUVE1.                                                  
           05 FILLER PIC X(80).                                     
        FD FMOUVE2.                                                 
        01 MOUVE2.                                                  
           05 FILLER PIC X(80).                                     
        FD FMOUVE3.                                                 
        01 MOUVE3.                                                  
           05 FILLER PIC X(80).                                     
        FD FMOUVEM-OUT.                                             
        01 MOUVEM-OUT.                                              
           05 FILLER PIC X(80).       
        SD FMOUVEM-WK.                                         
        01 MOUVEM-WK.                                          
           05 FILLER PIC X(34).                                
           05 MOIS-WK PIC X(2).                                
           05 FILLER PIC X(44).                                
        WORKING-STORAGE SECTION.                               
        01 FS-MOUVE1 PIC X(2).                                 
        01 FS-MOUVE2 PIC X(2).                                 
        01 FS-MOUVE3 PIC X(2).                                 
        01 WS-END-OF-FILE PIC X(1).                            
        PROCEDURE DIVISION.                                    
           PERFORM FONCTION-DEBUT-PROGRAMME.                   
           PERFORM FONCTION-PROGRAMME.                         
           PERFORM FONCTION-FIN-PROGRAMME.   
        FONCTION-DEBUT-PROGRAMME.                                     
           DISPLAY 'DEBUT DU PROGRAMME'.                              
           OPEN INPUT FMOUVE1                                         
           IF FS-MOUVE1 = '00'                                        
              DISPLAY ' FILE MOUVEM OPEN SUCCES : ' FS-MOUVE1         
           ELSE                                                       
              DISPLAY ' FILE MOUVEM NOT OPEN : ' FS-MOUVE1            
              PERFORM FONCTION-FIN-PROGRAMME                          
           END-IF.                                                    
           OPEN INPUT FMOUVE2                                         
           IF FS-MOUVE2 = '00'                                        
              DISPLAY ' FILE MOUVEM OPEN SUCCES : ' FS-MOUVE2         
           ELSE                                                       
              DISPLAY ' FILE MOUVEM NOT OPEN : ' FS-MOUVE2            
              PERFORM FONCTION-FIN-PROGRAMME                          
           END-IF.  
           OPEN INPUT FMOUVE3                                         
           IF FS-MOUVE3 = '00'                                        
              DISPLAY ' FILE MOUVEM OPEN SUCCES : ' FS-MOUVE3         
           ELSE                                                       
              DISPLAY ' FILE MOUVEM NOT OPEN : ' FS-MOUVE3            
              PERFORM FONCTION-FIN-PROGRAMME                          
           END-IF.                                                    
        FONCTION-PROGRAMME.                                           
           MERGE FMOUVEM-WK                                           
                ON ASCENDING KEY MOIS-WK                              
                USING FMOUVE1, FMOUVE2, FMOUVE3                       
                GIVING FMOUVEM-OUT                                    
           DISPLAY ' FIN DU MERGE '.                                  
        FONCTION-FIN-PROGRAMME.                                       
           CLOSE FMOUVE1                                              
           CLOSE FMOUVE2                                              
           CLOSE FMOUVE3                                              
           STOP RUN.                                                                                                                                                                                                                                  