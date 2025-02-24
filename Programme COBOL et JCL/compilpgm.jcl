//CREACOMP  JOB ,,MSGLEVEL=(1,1),REGION=4M,                       
//            MSGCLASS=A,CLASS=A,NOTIFY=&SYSUID                   
//*===================================================            
//* -> STEP POUR COMPILER LE PROGRAMME                            
//*===================================================            
//COMPIL EXEC IGYWCL                                              
//COBOL.SYSIN DD DSN=FRANCK.FINANCE.SOURCE(QUEST15),DISP=SHR      
//*COBOL.SYSLIB DD DSN=FRANCK.FINANCE.LINK,DISP=SHR               
//*LKED.SYSLIB DD DSN=FRANCK.FINANCE.LOAD,DISP=SHR                
//LKED.SYSLMOD DD DSN=FRANCK.FINANCE.LOAD(QUEST15),DISP=SHR       
//*===================================================            
/*                                                                
//                                                                