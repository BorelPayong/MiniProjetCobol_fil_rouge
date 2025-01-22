//CREAGDG  JOB ,,MSGLEVEL=(1,1),MSGCLASS=C,CLASS=A,PRTY=4,     
//         NOTIFY=&SYSUID                                      
//STEP1    EXEC PGM=IDCAMS                                     
//SYSPRINT DD SYSOUT=*                                         
//SYSIN  DD *                                                  
 /*==============================================*/            
 /* -> SUPPRESSION DES FICHIERS                  */            
 /*==============================================*/            
     DELETE FRANCK.GDG.CLIENT GDG FORCE                        
 /*==============================================*/            
 /* -> CREATION DU GDG DES CLIENTS              */             
 /*==============================================*/            
     DEFINE GDG (NAME(FRANCK.GDG.CLIENT) -                     
            LIMIT(10)                        -                 
            NOEMPTY                          -                 
            SCRATCH)                                           
      IF LASTCC=0 THEN -                                       
         LISTCAT ALL ENTRIES(FRANCK.GDG.CLIENT)                
/*  
//                                                      