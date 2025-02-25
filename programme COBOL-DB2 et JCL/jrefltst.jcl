//IBMUSERW  JOB (ACCOUNT),GIE,MSGCLASS=X,CLASS=A,NOTIFY=&SYSUID
//*
//JOBLIB  DD  DISP=SHR,DSN=DSNA10.SDSNLOAD
//        DD  DISP=SHR,DSN=CEE.SCEERUN
//        DD  DISP=SHR,DSN=IGY420.SIGYCOMP
//*
//COMPDB2  EXEC DSNHICOB,
//         COND=(4,LT),
//         PARM.PC=('HOST(IBMCOB)',APOST,APOSTSQL,SOURCE,
//         NOXREF,'SQL(DB2)','DEC(31)'),
//         PARM.COB=(LIB,NOSEQUENCE,QUOTE,RENT,'PGMNAME(LONGUPPER)'),
//         PARM.LKED='LIST,XREF,MAP,RENT'
//*
//PC.SRCLIB  DD DSN=DSNA10.DBAG.SRCLIB.DATA(REFLTST),DISP=SHR
//PC.DBRMLIB   DD DSN=DSNA10.DBAG.DBRMLIB.DATA(REFLTST),DISP=SHR
//*
//PC.SYSLIB  DD DISP=SHR,DSN=CEE.SCEELKED
//           DD DISP=SHR,DSN=DSNA10.SDSNLOAD
//           DD DISP=SHR,DSN=DFH510.CICS.SDFHLOAD
//           DD DISP=SHR,DSN=GDDM.SADMMOD
//           DD DISP=SHR,DSN=DSNA10.DBAG.RUNLIB.LOAD
//COB.SYSLIB DD DISP=SHR,DSN=FTEST.DB2.SOURCE
//*
//PC.SYSIN   DD DSN=FTEST.DB2.SOURCE(REFLTST),DISP=SHR
//*
//LKED.SYSLMOD DD DSN=DSNA10.DBAG.RUNLIB.LOAD(REFLTST),DISP=SHR
//*******************************************************************
//** PHASE 3 BIND PLAN SI TOUT SE PASSE BIEN
//*******************************************************************
// IF RC LE 4 THEN
//RUN      EXEC PGM=IKJEFT01
//SYSOUT   DD SYSOUT=*
//STEPLIB  DD DISP=SHR,DSN=DSNA10.DBAG.SDSNEXIT
//         DD DISP=SHR,DSN=DSNA10.SDSNLOAD
//         DD DISP=SHR,DSN=DSNA10.DBAG.RUNLIB.LOAD
//         DD DISP=SHR,DSN=DSNA10.DBAG.DBRMLIB.DATA
//SYSUDUMP DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
//SYSTSPRT DD SYSOUT=*
//SYSTSIN  DD *
 DSN SYSTEM(DBAG)
 RUN PROGRAM(REFLTST) PLAN(PLAN8)
 END
// ENDIF
/*
