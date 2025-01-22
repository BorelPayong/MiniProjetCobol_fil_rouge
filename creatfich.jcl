//CREAFICH JOB ,,MSGLEVEL=(1,1),MSGCLASS=C,CLASS=A,PRTY=4,       
//         NOTIFY=&SYSUID                                        
//*====================================================          
//* -> DELETE DES FICHIERS : IEFBR14                             
//*====================================================          
//STEPDEL EXEC PGM=IEFBR14                                       
//DEL1 DD DSN=FRANCK.FINANCE.CLIENT,                             
//           DISP=(OLD,DELETE,DELETE),                           
//           UNIT=3390                                           
//DEL2 DD DSN=FRANCK.FINANCE.REGION,                             
//           DISP=(OLD,DELETE,DELETE),                           
//           UNIT=3390                                           
//DEL3 DD DSN=FRANCK.FINANCE.NATCOMPT,                           
//           DISP=(OLD,DELETE,DELETE),                           
//           UNIT=3390 
//DEL4 DD DSN=FRANCK.FINANCE.PROFESSI,                                  
//           DISP=(OLD,DELETE,DELETE),                                  
//           UNIT=3390 
//*====================================================================
//* -> CREATION DU FICHIER DES CLIENTS                                 
//*====================================================================                                      
//STEPCOP1 EXEC PGM=IEBGENER                                            
//SYSPRINT DD SYSOUT=*                                                  
//SYSUT1 DD *  
//STEPCOP1 EXEC PGM=IEBGENER                                            
//SYSPRINT DD SYSOUT=*                                                  
//SYSUT1 DD *                                                           
1100335CLAUDE LECOQ        20000704F25CADR00007590000056129CR           
4660325CHARLOTTE RAYNAUD   19770501M30CADR00000140000327028CR           
7070430ARTHUR LEMOINE      19900412M05DADR00001130000023152CR           
5630120GUY-LUC VALLéE      19900926F20CADR00007960000330512DB           
3840130AGATHE BLANC        19900201M05VADR00002620000125409CR           
4620130NATHALIE RAMOS      19840709F30MADR00007550000333548CR           
4290330JULIEN MILLET-AUBRY 19760319F05DADR00004920000163261DB           
4990435PAULETTE DE GIRARD  19531002F10DADR00005900000491008CR           
1990335MARC VERDIER        19620226M20MADR00009940000265073CR           
6380120SYLVIE LE GIMENEZ   19500720M20MADR00006930000083909DB           
3560130DENIS BOURGEOIS-JACQ19851008F20VADR00001780000131116DB           
9120330ODETTE LéVêQUE      20010711M10MADR00000150000280068DB           
1690120HORTENSE LE GOFF    19900904M25MADR00007440000309109DB           
1680330SUSAN MENDèS-MOULIN 20030416M15MADR00005560000420990CR           
3120440GUY-FRANCK DEVAUX   19831120M20VADR00002960000199832CR           
7700220AUDREY-ANTOINETTE KL19720823M05CADR00007070000365125DB           
1340225GILLES VIDAL        19770608M15CADR00004960000462498CR 
7370320PHILIPPE ALLARD-COST20000101M15DADR00001950000073482DB          
5940140GUY MULLER-CHAUVET  19560527M30CADR00009220000365276DB          
0940320BERTRAND BOUCHER    20020624M30DADR00003190000266772CR          
/*                                                                     
//SYSUT2 DD DSN=FRANCK.FINANCE.CLIENT,                                 
//          DISP=(NEW,CATLG,DELETE),                                   
//          UNIT=SYSDA,DCB=(RECFM=FB,LRECL=80,BLKSIZE=0),              
//          SPACE=(TRK,1),VOL=SER=FDDBAS                               
//SYSIN DD DUMMY                                                       
//*====================================================================
//* -> creation du fichier des regions                                 
//*====================================================================
//STEPCOP2 EXEC PGM=IEBGENER                                           
//SYSPRINT DD SYSOUT=*                                                 
//SYSUT1 DD *                                                          
01PARIS                                                                
02MARSEILLE                                                            
03LYON                                                                 
04LILLE                                                                
/*                                                                     
//SYSUT2 DD DSN=FRANCK.FINANCE.REGION,                                 
//          DISP=(NEW,CATLG,DELETE),                                   
//          UNIT=SYSDA,DCB=(RECFM=FB,LRECL=80,BLKSIZE=0),              
//          SPACE=(TRK,1),VOL=SER=FDDBAS                               
//SYSIN DD DUMMY    
//*====================================================================
//* -> creation du fichier nature du compte                            
//*====================================================================
//STEPCOP3 EXEC PGM=IEBGENER                                           
//SYSPRINT DD SYSOUT=*                                                 
//SYSUT1 DD *                                                          
20COMPTE EPARGNE                                                       
25COMPTE CHEQUE                                                        
30COMPTE COMMERCIAL                                                    
35COMPTE COMPAGNIE AGRICOLE                                            
40COMPTE CDI                                                           
/*                                                                     
//SYSUT2 DD DSN=FRANCK.FINANCE.NATCOMPT,                               
//          DISP=(NEW,CATLG,DELETE),                                   
//          UNIT=SYSDA,DCB=(RECFM=FB,LRECL=80,BLKSIZE=0),              
//          SPACE=(TRK,1),VOL=SER=FDDBAS                               
//SYSIN DD DUMMY   
//*====================================================================
//* -> creation du fichier activite pro                                
//*====================================================================
//STEPCOP4 EXEC PGM=IEBGENER                                           
//SYSPRINT DD SYSOUT=*                                                 
//SYSUT1 DD *                                                          
05MEDECIN                                                              
10INGENIEUR                                                            
15COMPTABLE                                                            
20COMMERCANT                                                           
25FONCTIONNAIRE                                                        
30PRIVEE                                                               
/*                                                                     
//SYSUT2 DD DSN=FRANCK.FINANCE.PROFESSI,                               
//          DISP=(NEW,CATLG,DELETE),                                   
//          UNIT=SYSDA,DCB=(RECFM=FB,LRECL=80,BLKSIZE=0),              
//          SPACE=(TRK,1),VOL=SER=FDDBAS                               
//SYSIN DD DUMMY 
//*====================================================================
//* -> CREATION DU FICHIER DES MOUVEMENT DE COMPTE                     
//*====================================================================
//STEPCOP5 EXEC PGM=IEBGENER                                           
//SYSPRINT DD SYSOUT=*                                                 
//SYSUT1 DD *                                                          
110PAIEMENTSERVICE174096DBVIR2025/01/01                                
110ACHATMARCHANDIS357769CRCHQ2025/01/01                                
466VIREMENTCLIENT 350455DBVIR2025/01/02                                
466ACHATSTOCK     381831CRVIR2025/01/02                                
707REMBOURSEMENT  761591CRVIR2025/01/03                                
707VIREMENTCLIENT 669305DBVER2025/01/03                                
563ENCAISSEMENTVER761609DBCHQ2025/01/04                                
563ACHATFOURNITURE715716DBCHQ2025/01/04                                
384VERSEMENTGUICHE694077DBCHQ2025/01/05                                
384VERSEMENTGUICHE294019DBVIR2025/01/05                                
462ENCAISSEMENTVER748263DBVIR2025/01/06                                
462VENTEPRODUIT   746622CRVIR2025/01/06                                
429ACHATMARCHANDIS021910CRVIR2025/01/07                                
429PRISECOMMANDE  941875DBCHQ2025/01/07  
499RECETTEVENTE   419480CRVIR2025/01/08      
499DEPOTCHEQUE    834857CRVER2025/01/08      
199PAIEMENTSERVICE616461DBVIR2025/01/09      
199VIREMENTSALAIRE005572CRVIR2025/01/09      
638DEPOTCHEQUE    894690DBVER2025/01/10      
638VIREMENTSALAIRE449284DBVIR2025/01/10      
356VERSEMENTGUICHE312486CRVIR2025/01/11      
356VERSEMENTGUICHE319741CRVER2025/01/11      
912PRISECOMMANDE  900955DBVER2025/01/12      
912VIREMENTSALAIRE503163CRCHQ2025/01/12      
169RECETTEVENTE   720358CRCHQ2025/01/13      
169PAIEMENTSERVICE879273DBVER2025/01/13      
168ENCAISSEMENT   293227DBVIR2025/01/14      
168VIREMENTSALAIRE066958DBVIR2025/01/14      
312PAIEMENTSERVICE576174DBVER2025/01/15      
312PAIEMENTSERVICE626312DBVER2025/01/15      
770ACHATFOURNITURE987590DBCHQ2025/01/16      
770ENCAISSEMENT   088498CRCHQ2025/01/16      
134REMBOURSEMENT  261506CRVIR2025/01/17      
134VIREMENTSALAIRE445738CRVIR2025/01/17 
737SALAIREEMPLOYE 110060CRCHQ2025/01/18                    
737DEPOTCHEQUE    288005CRVIR2025/01/18                    
594PRISECOMMANDE  209221CRCHQ2025/01/19                    
594SALAIREEMPLOYE 010233DBCHQ2025/01/19                    
094VIREMENTCLIENT 825153DBCHQ2025/01/20                    
094REMBOURSEMENT  770494DBVER2025/01/20                    
/*                                                         
//SYSUT2 DD DSN=FRANCK.FINANCE.MOUV,                       
//          DISP=(NEW,CATLG,DELETE),                       
//          UNIT=SYSDA,DCB=(RECFM=FB,LRECL=80,BLKSIZE=0),  
//          SPACE=(TRK,1),VOL=SER=FDDBAS                   
//SYSIN DD DUMMY                 
/*                                                                     
//                                    