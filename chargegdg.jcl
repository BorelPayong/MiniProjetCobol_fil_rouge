//CREAGDG  JOB ,,MSGLEVEL=(1,1),MSGCLASS=C,CLASS=A,PRTY=4,             
//         NOTIFY=&SYSUID                                              
//STGDG    EXEC PGM=IEBGENER                                           
//SYSPRINT DD SYSOUT=*                                                 
//SYSUT1 DD *                                                          
110PAIEMENTSERVICE174096DBVIR2025/01/01                                
110ACHATMARCHANDIS357769CRCHQ2025/01/01                                
110VIREMENTCLIENT 350455DBVIR2025/01/02                                
110ACHATSTOCK     381831CRVIR2025/01/02                                
110REMBOURSEMENT  761591CRVIR2025/01/03                                
110ENCAISSEMENTVER761609DBCHQ2025/01/04                                
110ACHATFOURNITURE715716DBCHQ2025/01/04                                
110VERSEMENTGUICHE694077DBCHQ2025/01/05                                
110VIREMENTSALAIRE005572CRVIR2025/01/09                                
110DEPOTCHEQUE    894690DBVER2025/01/10                                
/*      
//SYSUT2 DD DSN=FRANCK.GDG.CLIENT(+1),                              
//          DISP=(NEW,CATLG,DELETE),STORCLAS=MFI,                   
//          UNIT=SYSDA,DCB=(RECFM=FB,LRECL=80,BLKSIZE=0),           
//          SPACE=(TRK,1),VOL=SER=FDDBAS                            
//SYSIN DD DUMMY                                                    
/*                                                                  
//                                                                  
                                                               