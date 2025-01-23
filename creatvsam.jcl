//CREAVSAM JOB ,,MSGLEVEL=(1,1),MSGCLASS=C,CLASS=A,PRTY=4,
//         NOTIFY=&SYSUID                                 
//STEP1    EXEC PGM=IDCAMS                                
//SYSPRINT DD SYSOUT=*                                    
//SYSIN  DD *                                             
 /*==============================================*/       
 /* -> SUPPRESSION DES FICHIERS                  */       
 /*==============================================*/       
     DELETE FRANCK.FINANCE.CLIENT.KSDS PURGE ERASE        
     DELETE FRANCK.FINANCE.CLIENT.ESDS PURGE ERASE        
     DELETE FRANCK.FINANCE.REGION.KSDS PURGE ERASE        
     DELETE FRANCK.FINANCE.NATCOM.KSDS PURGE ERASE        
     DELETE FRANCK.FINANCE.PROFESSI.KSDS PURGE ERASE        
/*==============================================*/       
/* -> CREATION DU ESDS DES CLIENTS              */       
/*==============================================*/       
    DEFINE CLUSTER (NAME(FRANCK.FINANCE.CLIENT.ESDS) -   
           TRACK(1,1)                       -            
           VOL(FDDBAS)                      -            
           CISZ (4096)                      -            
           RECORDSIZE(80,80)              -              
           SHAREOPTIONS(1,3)                -            
           NONINDEXED                       -            
           REUSE)                           -            
     DATA (NAME(FRANCK.FINANCE.CLIENT.ESDS.DATA))        
     IF LASTCC=0 THEN -                                  
      REPRO INDATASET (FRANCK.FINANCE.CLIENT) -          
            OUTDATASET (FRANCK.FINANCE.CLIENT.ESDS)      
      LISTCAT ALL LEVEL (FRANCK.FINANCE.CLIENT.ESDS)    
/*==============================================*/            
/* -> CREATION DU KSDS DES CLIENTS              */            
/*==============================================*/            
    DEFINE CLUSTER (NAME(FRANCK.FINANCE.CLIENT.KSDS) -        
           TRACK(1,1)                       -                 
           VOL(FDDBAS)                      -                 
           CISZ (4096)                      -                 
           RECORDSIZE(80,80)                -                 
           SHAREOPTIONS(1,3)                -                 
           INDEXED                          -                 
           KEYS(3,0)                        -                 
           NOREUSE)                       -                   
     DATA (NAME(FRANCK.FINANCE.CLIENT.KSDS.DATA)) -           
     INDEX (NAME(FRANCK.FINANCE.CLIENT.KSDS.INDEX))           
     IF LASTCC=0 THEN -                                       
      REPRO INDATASET (FRANCK.FINANCE.CLIENT.TRIEASC) -       
            OUTDATASET (FRANCK.FINANCE.CLIENT.KSDS)           
      LISTCAT ALL LEVEL (FRANCK.FINANCE.CLIENT.KSDS)                      
/*==============================================*/       
/* -> CREATION DU KSDS DES REGIONS              */       
/*==============================================*/       
    DEFINE CLUSTER (NAME(FRANCK.FINANCE.REGION.KSDS) -   
           TRACK(1,1)                       -            
           VOL(FDDBAS)                      -            
           CISZ (4096)                      -            
           RECORDSIZE(80,80)              -              
           SHAREOPTIONS(1,3)                -            
           INDEXED                          -            
           KEYS(2,0)                       -             
           REUSE)                           -            
     DATA (NAME(FRANCK.FINANCE.REGION.KSDS.DATA)) -      
     INDEX (NAME(FRANCK.FINANCE.REGION.KSDS.INDEX))      
     IF LASTCC=0 THEN -                                  
      REPRO INDATASET (FRANCK.FINANCE.REGION) -          
            OUTDATASET (FRANCK.FINANCE.REGION.KSDS)      
      LISTCAT ALL LEVEL (FRANCK.FINANCE.REGION.KSDS)    
/*==============================================*/       
/* -> CREATION DU KSDS DES NATURES COMPTE       */       
/*==============================================*/       
    DEFINE CLUSTER (NAME(FRANCK.FINANCE.NATCOM.KSDS) -   
           TRACK(1,1)                       -            
           VOL(FDDBAS)                      -            
           CISZ (4096)                      -            
           RECORDSIZE(80,80)              -              
           SHAREOPTIONS(1,3)                -            
           INDEXED                          -            
           KEYS(2,0)                       -             
           REUSE)                           -            
     DATA (NAME(FRANCK.FINANCE.NATCOM.KSDS.DATA)) -      
     INDEX (NAME(FRANCK.FINANCE.NATCOM.KSDS.INDEX))      
     IF LASTCC=0 THEN -                                  
      REPRO INDATASET (FRANCK.FINANCE.NATCOMPT) -        
            OUTDATASET (FRANCK.FINANCE.NATCOM.KSDS)      
      LISTCAT ALL LEVEL (FRANCK.FINANCE.NATCOM.KSDS)       
/*==============================================*/           
/* -> CREATION DU KSDS DES ACTIVITE PRO         */           
/*==============================================*/           
    DEFINE CLUSTER (NAME(FRANCK.FINANCE.PROFESSI.KSDS) -     
           TRACK(1,1)                       -                
           VOL(FDDBAS)                      -                
           CISZ (4096)                      -                
           RECORDSIZE(80,80)              -                  
           SHAREOPTIONS(1,3)                -                
           INDEXED                          -                
           KEYS(2,0)                       -                 
           REUSE)                           -                
     DATA (NAME(FRANCK.FINANCE.PROFESSI.KSDS.DATA)) -        
     INDEX (NAME(FRANCK.FINANCE.PROFESSI.KSDS.INDEX))        
     IF LASTCC=0 THEN -                                      
      REPRO INDATASET (FRANCK.FINANCE.PROFESSI) -            
            OUTDATASET (FRANCK.FINANCE.PROFESSI.KSDS)        
      LISTCAT ALL LEVEL (FRANCK.FINANCE.PROFESSI.KSDS)      
/*==============================================*/   
/* -> CREATION DU AIX AVEC POUR CLE ALTERNATIVE */   
/* -> LE CODE REGION                            */   
/*==============================================*/   
   DEFINE AIX(NAME(FRANCK.AIX.REGION)      -         
            RELATE(FRANCK.FINANCE.CLIENT.KSDS) -     
            TRACK(1,1)                       -       
            VOL(FDDBAS)                      -       
            CISZ(4096)                       -       
            RECORDSIZE(80,80)            -           
            KEYS(2,3)-                               
            FREESPACE(10,10)                 -       
            REUSE                            -       
            UPGRADE                          -       
            NONUNIQUEKEY)                    -       
       DATA(NAME(FRANCK.AIX.KSDS.DATA)) -            
       INDEX(NAME(FRANCK.AIX.KSDS.INDEX))       
    DEFINE PATH -                                       
       (NAME(FRANCK.FINANCE.CLIENT.PATH) -              
       PATHENTRY (FRANCK.AIX.REGION))                   
    BLDINDEX      -                                     
       INDATASET (FRANCK.FINANCE.CLIENT.KSDS) -         
       OUTDATASET (FRANCK.AIX.REGION)-                  
       NOSORTCALL                                       
 IF LASTCC=0 THEN -                                     
    LISTCAT ALL ENTRIES(FRANCK.FINANCE.CLIENT.PATH)     
    PRINT INDATASET (FRANCK.AIX.REGION) CHAR       
 /*==============================================*/      
 /* -> CREATION DU AIX AVEC POUR CLE ALTERNATIVE */      
 /* -> LE CODE DE L'ACTIVITE PRO                 */      
 /*==============================================*/      
    DEFINE AIX(NAME(FRANCK.AIX.ACTPROF)     -            
             RELATE(FRANCK.FINANCE.CLIENT.KSDS) -        
             TRACK(1,1)                       -          
             VOL(FDDBAS)                      -          
             CISZ(4096)                       -          
             RECORDSIZE(80,80)            -              
             KEY(2,36)                      -            
             FREESPACE(10,10)                 -          
             REUSE                            -          
             UPGRADE                          -          
             NONUNIQUEKEY)                    -          
        DATA(NAME(FRANCK.AIX.ACTPROF.DATA)) -            
        INDEX(NAME(FRANCK.AIX.ACTPROF.INDEX))                                   
   DEFINE PATH -                                      
      (NAME(FRANCK.FINANCE.CLIENT.PATHACT) -          
      PATHENTRY (FRANCK.AIX.ACTPROF))                 
   BLDINDEX      -                                    
      INDATASET (FRANCK.FINANCE.CLIENT.KSDS) -        
      OUTDATASET (FRANCK.AIX.ACTPROF)-                
      NOSORTCALL                                      
IF LASTCC=0 THEN -                                    
   LISTCAT ALL ENTRIES(FRANCK.FINANCE.CLIENT.PATHACT) 
   PRINT INDATASET (FRANCK.AIX.ACTPROF) CHAR          
/*
//
