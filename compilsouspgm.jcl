//CRECOMP  JOB ,,MSGLEVEL=(1,1),REGION=4M,                          
//            MSGCLASS=A,CLASS=A,NOTIFY=&SYSUID                     
//*===================================================              
//* -> STEP POUR COMPILER LE SOUS PROGRAMME                         
//*===================================================              
//COMPIL EXEC PGM=IGYCRCTL,PARM='OBJECT'                            
//STEPLIB  DD DSN=IGY420.SIGYCOMP,DISP=SHR                          
//SYSUT1   DD UNIT=SYSDA,SPACE=(CYL,(1,1))                          
//SYSUT2   DD UNIT=SYSDA,SPACE=(CYL,(1,1))                          
//SYSUT3   DD UNIT=SYSDA,SPACE=(CYL,(1,1))                          
//SYSUT4   DD UNIT=SYSDA,SPACE=(CYL,(1,1))                          
//SYSUT5   DD UNIT=SYSDA,SPACE=(CYL,(1,1))                          
//SYSUT6   DD UNIT=SYSDA,SPACE=(CYL,(1,1))                          
//SYSUT7   DD UNIT=SYSDA,SPACE=(CYL,(1,1))                          
//SYSPRINT DD SYSOUT=A                                              
//COBOL.SYSIN  DD DSN=FRANCK.FINANCE.SOURCE(PGMSECND),DISP=SHR      
//COBOL.SYSLIN DD DSN=FRANCK.FINANCE.LINK(PGMSECND),DISP=SHR    
//*========================================================       
//* -> ETAPE DE LINKAGE DES PROGRAMMES                            
//*========================================================       
//LKED     EXEC PGM=IEWBLINK,COND=(8,LT,COMPIL),REGION=0M         
//SYSLIB   DD DSN=CEE.SCEELKED,DISP=SHR                           
//         DD DSN=CEE.SCEELKEX,DISP=SHR                           
//         DD DSN=FRANCK.FINANCE.LINK,DISP=SHR                    
//SYSPRINT DD SYSOUT=*                                            
//LKED.SYSLIN  DD DSN=FRANCK.FINANCE.LINK(PGMSECND),DISP=SHR      
//SYSLMOD      DD DSN=FRANCK.FINANCE.LOAD(PGMSECND),DISP=SHR      
//SYSUT1       DD UNIT=SYSALLDA,SPACE=(CYL,(1,1))                 
/*                                                                
//                                                                    