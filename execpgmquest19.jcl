//CREAEXEC JOB ,,MSGLEVEL=(1,1),REGION=4M,                
//            MSGCLASS=A,CLASS=A,NOTIFY=&SYSUID           
//*====================================================   
//* -> DELETE DES FICHIERS : IEFBR14                      
//*====================================================   
//STEPDEL EXEC PGM=IEFBR14                                
//DEL1 DD DSN=FRANCK.FINANCE.MOUV.OUT,                    
//           DISP=(OLD,DELETE,DELETE),                    
//           UNIT=3390                                    
//*===================================================    
//* -> STEP POUR EXECUTER LE PROGRAMME                    
//*===================================================    
//STEPEXE EXEC PGM=QUEST20                                       
//STEPLIB DD DSN=FRANCK.FINANCE.LOAD,DISP=SHR                    
//DDCLIENT DD DSN=FRANCK.FINANCE.CLIENT.KSDS,DISP=SHR            
//DDMOUVEM DD DSN=FRANCK.FINANCE.MOUV,DISP=SHR                   
//FOUT DD DSN=FRANCK.FINANCE.MOUV.OUT,DISP=(NEW,CATLG,DELETE),   
//         UNIT=3390,SPACE=(TRK,(4,1),RLSE),                     
//         DCB=(LRECL=80,BLKSIZE=800,RECFM=FB)                   
//FWORK DD DSN=FRANCK.FINANCE.MOUV.WK,DISP=(,DELETE,DELETE),     
//         UNIT=3390,SPACE=(TRK,(4,1),RLSE),                     
//         DCB=(LRECL=80,BLKSIZE=800,RECFM=FB)                   
//*SYSPRINT DD SYSOUT=A                                          
//*SYSOUT DD SYSOUT=*                                            
//DDPRINT DD SYSOUT=A                                            
//SYSIN DD DATA                                                  
638                                                              
/*                                                               
//                                                               