//CREAPRIN JOB ,,MSGLEVEL=(1,1),MSGCLASS=C,CLASS=A,PRTY=4,  
//         NOTIFY=&SYSUID                                   
//STPPRINT  EXEC PGM=IDCAMS                                 
//SYSPRINT  DD SYSOUT=*                                     
//PRINTPS   DD DSN=FRANCK.AIX.REGION,DISP=SHR,              
//            UNIT=3390                                     
//SYSIN     DD *                                            
    IF LASTCC=0 THEN -                                      
       PRINT INFILE(PRINTPS) -                              
                      CHAR                                  
/*                                                          
//                                                          
