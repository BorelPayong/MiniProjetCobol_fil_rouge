//CREATEPS JOB ,,MSGLEVEL=(1,1),MSGCLASS=C,CLASS=A,PRTY=4,
//         NOTIFY=&SYSUID                                 
//*====================================================  
//* -> DELETE DES FICHIERS : IEFBR14                     
//*====================================================  
//STEPDEL EXEC PGM=IEFBR14                               
//DEL10 DD DSN=FRANCK.FINANCE.CLIENT.TRIEASC,            
//           DISP=(OLD,DELETE,DELETE),                   
//           UNIT=3390                                   
//DEL1 DD DSN=FRANCK.FINANCE.CLIENT.COMPTABL,            
//           DISP=(OLD,DELETE,DELETE),                   
//           UNIT=3390                                   
//DEL2 DD DSN=FRANCK.FINANCE.CLIENT.FONCTION,            
//           DISP=(OLD,DELETE,DELETE),                   
//           UNIT=3390                                   
//DEL3 DD DSN=FRANCK.FINANCE.CLIENT.MEDECIN,             
//           DISP=(OLD,DELETE,DELETE),                   
//           UNIT=3390         
//DEL4 DD DSN=FRANCK.FINANCE.CLIENT.CR,          
//           DISP=(OLD,DELETE,DELETE),           
//           UNIT=3390                           
//DEL5 DD DSN=FRANCK.FINANCE.CLIENT.DB,          
//           DISP=(OLD,DELETE,DELETE),           
//           UNIT=3390                           
//DEL6 DD DSN=FRANCK.FINANCE.CLIENT.PARIS,       
//           DISP=(OLD,DELETE,DELETE),           
//           UNIT=3390                           
//DEL7 DD DSN=FRANCK.FINANCE.CLIENT.MARSEILL,    
//           DISP=(OLD,DELETE,DELETE),           
//           UNIT=3390                           
//DEL8 DD DSN=FRANCK.FINANCE.CLIENT.LYON,        
//           DISP=(OLD,DELETE,DELETE),           
//           UNIT=3390                           
//DEL9 DD DSN=FRANCK.FINANCE.CLIENT.LILLE,       
//           DISP=(OLD,DELETE,DELETE),           
//           UNIT=3390        
//DEL13 DD DSN=FRANCK.FINANCE.CLIENT.FUSION,                       
//           DISP=(OLD,DELETE,DELETE),                             
//           UNIT=3390                                             
//DEL14 DD DSN=FRANCK.FINANCE.CLIENT.REDUIT,                       
//           DISP=(OLD,DELETE,DELETE),                             
//           UNIT=3390                                             
//*============================================================    
//* -> CREATION DU FICHIER DE LA LISTE DES CLIENTS TRIER           
//*============================================================    
//INCL10 EXEC PGM=SORT                                             
//SYSOUT DD SYSOUT=*                                               
//SORTIN DD DSN=FRANCK.FINANCE.CLIENT,DISP=SHR                     
//SORTOUT DD DSN=FRANCK.FINANCE.CLIENT.TRIEASC,                    
//           DISP=(NEW,CATLG,DELETE),                              
//           SPACE=(TRK,1),VOL=SER=FDDBAS,                         
//           DCB=(LRECL=80,BLKSIZE=800,RECFM=FB,DSORG=PS)          
//SYSIN DD *                                                       
   SORT FIELDS=(1,3,ZD,A)        
//*============================================================   
//* -> CREATION DU FICHIER DE LA LISTE DES CLIENTS COMPTABLE      
//* -> LES CLIENTS COMPTABLE ONT POUR CODE 15                     
//*============================================================   
//INCL1 EXEC PGM=SORT                                             
//SYSOUT DD SYSOUT=*                                              
//SORTIN DD DSN=FRANCK.FINANCE.CLIENT.TRIEASC,DISP=SHR            
//SORTOUT DD DSN=FRANCK.FINANCE.CLIENT.COMPTABL,                  
//           DISP=(NEW,CATLG,DELETE),                             
//           SPACE=(TRK,1),VOL=SER=FDDBAS,                        
//           DCB=(LRECL=80,BLKSIZE=800,RECFM=FB,DSORG=PS)         
//SYSIN DD *                                                      
   SORT FIELDS=COPY                                               
   INCLUDE COND=(37,2,ZD,EQ,15)        
//*============================================================   
//* -> CREATION DU FICHIER DE LA LISTE DES CLIENTS FONCTIONNAIRE  
//* -> LES CLIENTS FONCTIONNAIRE ONT POUR CODE 25                 
//*============================================================   
//INCL2 EXEC PGM=SORT                                             
//SYSOUT DD SYSOUT=*                                              
//SORTIN DD DSN=FRANCK.FINANCE.CLIENT.TRIEASC,DISP=SHR            
//SORTOUT DD DSN=FRANCK.FINANCE.CLIENT.FONCTION,                  
//           DISP=(NEW,CATLG,DELETE),                             
//           SPACE=(TRK,1),VOL=SER=FDDBAS,                        
//           DCB=(LRECL=80,BLKSIZE=800,RECFM=FB,DSORG=PS)         
//SYSIN DD *                                                      
   SORT FIELDS=COPY                                               
   INCLUDE COND=(37,2,ZD,EQ,25)         
//*============================================================ 
//* -> CREATION DU FICHIER DE LA LISTE DES CLIENTS MEDECIN      
//* -> LES CLIENTS MEDECIN ONT POUR CODE 05                     
//*============================================================ 
//INCL3 EXEC PGM=SORT                                           
//SYSOUT DD SYSOUT=*                                            
//SORTIN DD DSN=FRANCK.FINANCE.CLIENT.TRIEASC,DISP=SHR          
//SORTOUT DD DSN=FRANCK.FINANCE.CLIENT.MEDECIN,                 
//           DISP=(NEW,CATLG,DELETE),                           
//           SPACE=(TRK,1),VOL=SER=FDDBAS,                      
//           DCB=(LRECL=80,BLKSIZE=800,RECFM=FB,DSORG=PS)       
//SYSIN DD *                                                    
   SORT FIELDS=COPY                                             
   INCLUDE COND=(37,2,ZD,EQ,05)       
//*============================================================  
//* -> CREATION DU FICHIER DE LA LISTE DES CLIENTS CR            
//*============================================================  
//INCL4 EXEC PGM=SORT                                            
//SYSOUT DD SYSOUT=*                                             
//SORTIN DD DSN=FRANCK.FINANCE.CLIENT.TRIEASC,DISP=SHR           
//SORTOUT DD DSN=FRANCK.FINANCE.CLIENT.CR,                       
//           DISP=(NEW,CATLG,DELETE),                            
//           SPACE=(TRK,1),VOL=SER=FDDBAS,                       
//           DCB=(LRECL=80,BLKSIZE=800,RECFM=FB,DSORG=PS)        
//SYSIN DD *                                                     
   SORT FIELDS=COPY                                              
   INCLUDE COND=(60,2,CH,EQ,C'CR')        
//*============================================================      
//* -> CREATION DU FICHIER DE LA LISTE DES CLIENTS DB                
//*============================================================      
//INCL5 EXEC PGM=SORT                                                
//SYSOUT DD SYSOUT=*                                                 
//SORTIN DD DSN=FRANCK.FINANCE.CLIENT.TRIEASC,DISP=SHR               
//SORTOUT DD DSN=FRANCK.FINANCE.CLIENT.DB,                           
//           DISP=(NEW,CATLG,DELETE),                                
//           SPACE=(TRK,1),VOL=SER=FDDBAS,                           
//           DCB=(LRECL=80,BLKSIZE=800,RECFM=FB,DSORG=PS)            
//SYSIN DD *                                                         
   SORT FIELDS=COPY                                                  
   INCLUDE COND=(60,2,CH,EQ,C'DB')       
//*============================================================       
//* -> CREATION DU FICHIER DE LA LISTE DES CLIENTS REPARTIE PAR REGION
//* -> REGION DE PARIS A POUR CODE 01                                 
//*============================================================       
//INCL6 EXEC PGM=SORT                                                 
//SYSOUT DD SYSOUT=*                                                  
//SORTIN DD DSN=FRANCK.FINANCE.CLIENT.TRIEASC,DISP=SHR                
//SORTOUT DD DSN=FRANCK.FINANCE.CLIENT.PARIS,                         
//           DISP=(NEW,CATLG,DELETE),                                 
//           SPACE=(TRK,1),VOL=SER=FDDBAS,                            
//           DCB=(LRECL=80,BLKSIZE=800,RECFM=FB,DSORG=PS)             
//SYSIN DD *                                                          
   SORT FIELDS=COPY                                                   
   INCLUDE COND=(4,2,ZD,EQ,01)            
//*============================================================       
//* -> CREATION DU FICHIER DE LA LISTE DES CLIENTS REPARTIE PAR REGION
//* -> REGION DE MARSEILLE A POUR CODE 02                             
//*============================================================       
//INCL7 EXEC PGM=SORT                                                 
//SYSOUT DD SYSOUT=*                                                  
//SORTIN DD DSN=FRANCK.FINANCE.CLIENT.TRIEASC,DISP=SHR                
//SORTOUT DD DSN=FRANCK.FINANCE.CLIENT.MARSEILL,                      
//           DISP=(NEW,CATLG,DELETE),                                 
//           SPACE=(TRK,1),VOL=SER=FDDBAS,                            
//           DCB=(LRECL=80,BLKSIZE=800,RECFM=FB,DSORG=PS)             
//SYSIN DD *                                                          
   SORT FIELDS=COPY                                                   
   INCLUDE COND=(4,2,ZD,EQ,02)          
//*============================================================       
//* -> CREATION DU FICHIER DE LA LISTE DES CLIENTS REPARTIE PAR REGION
//* -> REGION DE LYON A POUR CODE 03                                  
//*============================================================       
//INCL8 EXEC PGM=SORT                                                 
//SYSOUT DD SYSOUT=*                                                  
//SORTIN DD DSN=FRANCK.FINANCE.CLIENT.TRIEASC,DISP=SHR                
//SORTOUT DD DSN=FRANCK.FINANCE.CLIENT.LYON,                          
//           DISP=(NEW,CATLG,DELETE),                                 
//           SPACE=(TRK,1),VOL=SER=FDDBAS,                            
//           DCB=(LRECL=80,BLKSIZE=800,RECFM=FB,DSORG=PS)             
//SYSIN DD *                                                          
   SORT FIELDS=COPY                                                   
   INCLUDE COND=(4,2,ZD,EQ,03)      
//*============================================================       
//* -> CREATION DU FICHIER DE LA LISTE DES CLIENTS REPARTIE PAR REGION
//* -> REGION DE LILLE A POUR CODE 04                                 
//*============================================================       
//INCL9 EXEC PGM=SORT                                                 
//SYSOUT DD SYSOUT=*                                                  
//SORTIN DD DSN=FRANCK.FINANCE.CLIENT.TRIEASC,DISP=SHR                
//SORTOUT DD DSN=FRANCK.FINANCE.CLIENT.LILLE,                         
//           DISP=(NEW,CATLG,DELETE),                                 
//           SPACE=(TRK,1),VOL=SER=FDDBAS,                            
//           DCB=(LRECL=80,BLKSIZE=800,RECFM=FB,DSORG=PS)             
//SYSIN DD *                                                          
   SORT FIELDS=COPY                                                   
   INCLUDE COND=(4,2,ZD,EQ,04)     
//*============================================================  
//* -> CREATION DU FICHIER DE LA LISTE DES CLIENTS ISSUE DE LA   
//* -> FUSION ENTRE LES CLIENT FONCTIONNAIRE ET COMPTABLE        
//* -> LA FUSION DE 2 FICHIER N'EST POSSIBLE QU'AVEC DES FICHIER 
//* -> DEJA TRIER                                                
//*============================================================  
//MERG EXEC PGM=SORT                                             
//SORTIN01 DD DSN=FRANCK.FINANCE.CLIENT.FONCTION,DISP=SHR        
//SORTIN02 DD DSN=FRANCK.FINANCE.CLIENT.COMPTABL,DISP=SHR        
//SORTOUT DD  DSN=FRANCK.FINANCE.CLIENT.FUSION,                  
//            DISP=(NEW,CATLG,DELETE),                           
//            SPACE=(TRK,1),VOL=SER=FDDBAS,                      
//            DCB=(LRECL=80,BLKSIZE=800,RECFM=FB,DSORG=PS)       
//SYSOUT DD SYSOUT=*                                             
//SYSIN DD *                                                     
    MERGE FIELDS=(1,3,ZD,A)           
//*===========================================================   
//* -> CREATION D'UN NOUVEAU FICHIER CLIENT REDUIS               
//*===========================================================   
//BUILDFIC EXEC PGM=SORT                                         
//SORTIN DD DSN=FRANCK.FINANCE.CLIENT.TRIEASC,DISP=SHR           
//SORTOUT DD DSN=FRANCK.FINANCE.CLIENT.REDUIT,                   
//           DISP=(NEW,CATLG,DELETE),                            
//           SPACE=(TRK,1),VOL=SER=FDDBAS,                       
//           DCB=(LRECL=80,BLKSIZE=800,RECFM=FB,DSORG=PS)        
//SYSOUT DD SYSOUT=*                                             
//SYSIN DD *                                                     
   SORT FIELDS=COPY                                              
   OUTREC FIELDS=(1:1,3,4:4,2,6:6,2,8:8,10,18:18,10,28:37,2,     
                  30:39,1,31:50,10,41:60,2)                      
/*                                                               
//                                                               
                                                                                                                                                                                                                                                                                                                                                                                        