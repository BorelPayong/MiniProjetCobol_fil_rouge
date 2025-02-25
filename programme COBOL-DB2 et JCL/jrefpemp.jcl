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
//PC.SRCLIB  DD DSN=DSNA10.DBAG.SRCLIB.DATA(REFPEMP),DISP=SHR
//PC.DBRMLIB   DD DSN=DSNA10.DBAG.DBRMLIB.DATA(REFPEMP),DISP=SHR
//*
//PC.SYSLIB  DD DISP=SHR,DSN=CEE.SCEELKED
//           DD DISP=SHR,DSN=DSNA10.SDSNLOAD
//           DD DISP=SHR,DSN=DFH510.CICS.SDFHLOAD
//           DD DISP=SHR,DSN=GDDM.SADMMOD
//COB.SYSLIB DD DISP=SHR,DSN=FTEST.DB2.SOURCE
//*
//PC.SYSIN   DD DSN=FTEST.DB2.SOURCE(REFPEMP),DISP=SHR
//*
//LKED.SYSLMOD DD DSN=DSNA10.DBAG.RUNLIB.LOAD(REFPEMP),DISP=SHR
//*****************************************************************
//** PHASE 2 BIND PACKAGE EN SE BASANT SUR LE DBRM CREE EN PHASE 1
//*****************************************************************
// IF RC LE 4 THEN
//BINDPACK EXEC PGM=IKJEFT01,DYNAMNBR=20
//DBRMLIB  DD  DSN=DSNA10.DBAG.DBRMLIB.DATA,DISP=SHR
//SYSTSPRT DD  SYSOUT=*
//SYSPRINT DD  SYSOUT=*
//SYSUDUMP DD  SYSOUT=*
//SYSTSIN  DD  *
  DSN SYSTEM(DBAG)
    BIND PACKAGE(IBMUSERC) MEMBER(REFPEMP) -
         VALIDAT(BIND) -
         ACTION(REPLACE) ISOLATION(CS) QUALIFIER(IBMUSER) -
         ENCODING(EBCDIC) RELEASE(COMMIT)
// ENDIF
//********************************************************************
//** PHASE 3 BIND PLAN SI TOUT SE PASSE BIEN
//********************************************************************
// IF RC LE 4 THEN
//DSNTIAS EXEC PGM=IKJEFT01,DYNAMNBR=20,COND=(4,LT)
//SYSTSPRT DD  SYSOUT=*
//SYSPRINT DD  SYSOUT=*
//SYSUDUMP DD  SYSOUT=*
//SYSTSIN  DD  *
 DSN SYSTEM(DBAG)
 BIND PLAN(PLAN8)  PKLIST(IBMUSERC.REFPEMP) -
      CURRENTDATA(NO) ACT(REP) RETAIN -
      OWNER(IBMUSER) -
      VALIDATE(BIND) -
      ISO(CS) -
      ENCODING(EBCDIC) -
      ACQUIRE(USE) -
      RELEASE(DEALLOC)
      END
// ENDIF
//
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
 RUN PROGRAM(REFPEMP) PLAN(PLAN8)
 END
// ENDIF
/*
