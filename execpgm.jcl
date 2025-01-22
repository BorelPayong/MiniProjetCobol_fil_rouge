//CREAEXEC JOB ,,MSGLEVEL=(1,1),REGION=4M,                    
//            MSGCLASS=A,CLASS=A,NOTIFY=&SYSUID               
//*===================================================        
//* -> STEP POUR EXECUTER LE PROGRAMME                        
//*===================================================        
//STEPEXE EXEC PGM=QUEST15                                    
//STEPLIB DD DSN=FRANCK.FINANCE.LOAD,DISP=SHR                 
//DDCLIENT DD DSN=FRANCK.FINANCE.CLIENT.KSDS,DISP=SHR         
//*DDREGION DD DSN=FRANCK.FINANCE.REGION.KSDS,DISP=SHR        
//*DDACTIPR DD DSN=FRANCK.FINANCE.PROFESSI.KSDS,DISP=SHR      
//*DDNATCOM DD DSN=FRANCK.FINANCE.NATCOM.KSDS,DISP=SHR        
//*DDCLIEN1 DD DSN=FRANCK.FINANCE.CLIENT.PATH,DISP=SHR        
//DDPRINT DD SYSOUT=A                                         
//*SYSPRINT DD SYSOUT=*                                       
//*SYSOUT DD SYSOUT=*                                         
//*===================================================        
/*                                                            
//                                                            