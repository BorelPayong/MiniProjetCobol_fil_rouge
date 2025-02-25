       IDENTIFICATION DIVISION.
       PROGRAM-ID. REFPEMP.
      ******************************************************************
      *                                                        V(1.00) *
      *                                                                *
      * TYPE DE COMPOSANT DE L'ARCHITECTURE:  ACCESSEUR PHYSIQUE       *
      * CATEGORIE:                            METIER                   *
      * IDENTIFIANT D'APPEL:                  REFPEMP                  *
      * DESIGNATION:                          ........................ *
      * LIBELLE COURT:                        ACCESSEUR EMPLOYES       *
      * RESPONSABLE:                          FCIT                     *
      * VERSION :                             1.0                      *
      *                                                                *
      * ============================================================== *
      *  Date de creation   : 21/05/24                                 *
      *                                                                *
      *  Description du trt : Accesseur physique à la table DB2        *
      *                       EMPLOYES                                 *
      *                                                                *
      * ============================================================== *
      *                                                                *
      *                   M O D I F I C A T I O N S                    *
      *                  ---------------------------                   *
      *                                                                *
      *  +---------------------------------------------------------+   *
      *  I  DATE    I        DESIGNATION             I   AUTEUR    I   *
      *  +---------------------------------------------------------+   *
      *  I 10/21/24 I        CREATION FICHIER        I   FLAVIEN   I   *
      *  +---------------------------------------------------------+   *
      *  I 11/21/24 I        REPO APPEL BDD          I   FLAVIEN   I   *
      *  +---------------------------------------------------------+   *
      *  I 11/21/24 I        REPO APPEL BDD          I   HAKIM     I   *
      *  +---------------------------------------------------------+   *
      *                                                                *
      * ============================================================== *
      *  COPY UTILISES :                                               *
      *                                                                *
      * ============================================================== *
      *  Fonctions disponibles                                         *
      *                                                                *
      *    L0001     : Selection ....................................  *
      *    M0001     : Modification .................................  *
      *    I0001     : Insertion ....................................  *
      *                                                                *
      *=================================================================
      *REMARKS. COPY=(YFCIFRE YFCIFAL YEMPENT YEMPSOR).
       ENVIRONMENT DIVISION.
      *=================================================================
      *-=-=-=-=-=-=-=-=-=-=-=-=
       CONFIGURATION SECTION.
      *-=-=-=-=-=-=-=-=-=-=-=-=
       SOURCE-COMPUTER. IBM-370.
       SPECIAL-NAMES. DECIMAL-POINT IS COMMA.
      *=================================================================
       DATA DIVISION.
      *=================================================================
      *-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-
       WORKING-STORAGE SECTION.
      *-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-
      *-----------------------------------------------------------------
      *    Liste des modules appeles par le programme
      *-----------------------------------------------------------------
       01  C-TabPgm.
           05  C-NomPgm PIC X(08) VALUE 'REFPEMP'.
      *-----------------------------------------------------------------
      *    Declarations pour gestion des erreurs :
      *-----------------------------------------------------------------
      *-- Liste des erreurs geres par le programme
       01  W-Err                         PIC X(08).
           88 W-Trt-OK                   VALUE '00000000'.
      *-- Type d'action invalide
           88 W-Err-TypAcnIvd            VALUE '00038001'.
      *-- Numero de fonction invalide
           88 W-Err-FctIvd               VALUE '00038002'.
      *-- Date ou heure invalide
           88 W-Err-DatHeuIvd            VALUE '00058003'.
      *-- Données non trouvees
           88 W-Err-DonNonTve            VALUE '00068004'.
      *-- Clé dupliquee
           88 W-Err-CleDup               VALUE '00078005'.
      *-- Cle parente inconnue (integrite referentielle)
           88 W-Err-ClePntIcu            VALUE '00058006'.
      *-- Pas de modif de cle parente si cle dependante (Integrite ref)
           88 W-Err-MofIpbClePnt         VALUE '00058007'.
      *-- Rubrique incompatible avec la structure de la colonne
           88 W-Err-RubIcmStr            VALUE '00058008'.
      *-- Erreur technique acces DB2
           88 W-Err-DB2                  VALUE '99999999'.
       01  FILLER REDEFINES W-Err.
           05 W-CodErr.
              10 W-CodErrPrm             PIC 9(04).
              10 W-CodErrScd             PIC 9(04).
      *-----------------------------------------------------------------
      * Erreurs SQL
      *-----------------------------------------------------------------
       01 SQLErrors                        PIC S9(09) COMP.
           88 DB2RET-NON-TROUVE            VALUE +100.
           88 DB2RET-ERR-DATE-TIME         VALUE -180.
           88 DB2RET-EXISTE-DEJA           VALUE -803.
           88 DB2RET-ERR-INTEGRITE         VALUE -530.
           88 DB2RET-ERR-CLE-PRIMAIRE      VALUE -531.
           88 DB2RET-ERR-STRUCTURE         VALUE -532.
      *-- Variable pour le message d'erreur revoyee a l appelant
       01 CodRet.
           05 CodRetMsg-Pgm               PIC X(200).
           05 CodRetPmr-Pgm               PIC 9(4).
           05 CodRetScd-Pgm               PIC 9(4).
           05 CodRetNomPgm-Pgm            PIC X(8).
      *-----------------------------------------------------------------
      *   Declaration des indicateurs
      *-----------------------------------------------------------------
      *   Declaration des variables de travail
      *-----------------------------------------------------------------
      *-- Odre SQL execute
       01  W-OrdSQL                      PIC X(08).
           88 W-OrdSQL-SELECT            VALUE 'SELECT'.
           88 W-OrdSQL-OPEN              VALUE 'OPEN'.
           88 W-OrdSQL-FETCH             VALUE 'FETCH'.
           88 W-OrdSQL-CLOSE             VALUE 'CLOSE'.
           88 W-OrdSQL-INSERT            VALUE 'INSERT'.
           88 W-OrdSQL-UPDATE            VALUE 'UPDATE'.
           88 W-OrdSQL-DELETE            VALUE 'DELETE'.
       01 WS-EMPLOYES.
           05 WS-EMPID        PIC S9(9)    COMP.
           05 WS-EMPNAME      PIC X(15).
           05 WS-EMPNAM2      PIC X(15).
           05 WS-DEPARTMENT   PIC S9(9)    COMP.
           05 WS-SALARY       PIC S9(7)V99 COMP-3.
           05 WS-DESIGNATION  PIC X(4).
      *-- Label du paragraphe traite
       01  W-Lbl                         PIC X(30).
      *-- Variable de conversion du code retour DB2
       01  W-SQLCod                      PIC ZZ9+  BLANK WHEN ZERO.
      *-- Variables DB2
           EXEC SQL
               INCLUDE SQLCA
           END-EXEC.
      *-----------------------------------------------------------------
      *    Declaration de la table TREFEMP (DECLARE TABLE)
      *-----------------------------------------------------------------
           EXEC SQL DECLARE TREFEMP TABLE
              (EMPID         INT           NOT NULL,
              EMPNAME        VARCHAR(15)   NOT NULL,
              EMPNAM2        VARCHAR(15)   NOT NULL,
              DEPARTMENT     INT           NOT NULL,
              SALARY         DECIMAL(9,2)  NOT NULL,
              DESIGNATION    CHAR(4)       NOT NULL)
           END-EXEC.
      *-- Constantes
       01 C-I0001             PIC X(5)  VALUE 'I0001'.
       01 C-M0001             PIC X(5)  VALUE 'M0001'.
       01 C-L0001             PIC X(5)  VALUE 'L0001'.
       01 C-L1001             PIC X(5)  VALUE 'L1001'.
       01 C-L1002             PIC X(5)  VALUE 'L1002'.
       01 C-TRT-FCT-M0001     PIC X(13) VALUE 'TRT-FCT-M0001'.
       01 C-TRT-FCT-I0001     PIC X(13) VALUE 'TRT-FCT-I0001'.
       01 C-TRT-FCT-L0001     PIC X(13) VALUE 'TRT-FCT-L0001'.
       01 C-TRT-FCT-L1001-INI PIC X(17) VALUE 'TRT-FCT-L1001-INI'.
       01 C-TRT-SQL-L1001-SUI PIC X(17) VALUE 'TRT-SQL-L1001-SUI'.
       01 C-TRT-FCT-L1001-FIN PIC X(17) VALUE 'TRT-FCT-L1001-FIN'.
       01 C-EMPLOYES          PIC X(8)  VALUE 'EMPLOYES'.
       01 W-NbrLigTot         PIC S9(4) COMP.
       01 W-NbrLigNull        PIC S9(4) COMP.
      *-=-=-=-=-=-=-=-=-=
       LINKAGE SECTION.
      *-=-=-=-=-=-=-=-=-=
      *-- Partie aller/retour fixe de la requete
          COPY YFCIFAL.
          COPY YFCIFRE.
          COPY YEMPENT.
          COPY YEMPSOR.
      *-- Description des arguments pour acces la table
      *-- Description de la table TREFEMP
      *=================================================================
       PROCEDURE DIVISION USING YFCIFAL
                                YFCIFRE
                                YEMPENT
                                YEMPSOR.
      *=================================================================
      *    Traitement general
      *=================================================================
      *    1) Initialisation
      *    2) Traitement de la fonction
      *    3) Fin de programme
      *=================================================================
           PERFORM Initialisations
           IF W-Trt-OK
                PERFORM Trt-Fonctions
           END-IF
           PERFORM Sortie
           GOBACK.
      *-----------------------------------------------------------------
       INITIALISATIONS.
      *-----------------------------------------------------------------
           DISPLAY ' Accesseur Physique < ' C-NomPgm ' > '
      *-- Initialisation du code retour DB2
           MOVE ZEROS   TO SQLCODE
      *-- Initialisation des codes retour
           SET W-Trt-OK TO TRUE
           DISPLAY ' < ' FCIFAL-SCEDMD-FCT ' > '
      *-- Initialisation du type d'ordre SQL traite
           EVALUATE TRUE
               WHEN FCIFAL-TYPACN-UNQ
                    SET W-ORDSQL-SELECT  TO TRUE
               WHEN FCIFAL-TYPACN-INI
                    SET W-ORDSQL-OPEN    TO TRUE
               WHEN FCIFAL-TYPACN-LECSUI
                    SET W-ORDSQL-FETCH   TO TRUE
               WHEN FCIFAL-TYPACN-LECPCD
                    SET W-ORDSQL-FETCH   TO TRUE
               WHEN FCIFAL-TYPACN-FINLEC
                    SET W-ORDSQL-CLOSE   TO TRUE
               WHEN FCIFAL-TYPACN-ISR
                    SET W-ORDSQL-INSERT  TO TRUE
               WHEN FCIFAL-TYPACN-MOD
                    SET W-ORDSQL-UPDATE  TO TRUE
               WHEN FCIFAL-TYPACN-SPS
                    SET W-ORDSQL-DELETE  TO TRUE
               WHEN OTHER
           DISPLAY ' <Step 01> '
                    SET W-ERR-TYPACNIVD  TO TRUE
           END-EVALUATE
           DISPLAY ' <Step 02> '
           MOVE EMPENT-EMPLOYES-ENT TO WS-EMPLOYES
           DISPLAY ' ws-employes < ' ws-employes ' > '
           DISPLAY ' WS-EMPID   < ' WS-EMPID ' > '
           DISPLAY ' <Step 03> '
           .
      *----------------------------------------------------------------*
       TRT-FONCTIONS.
      *----------------------------------------------------------------*
      *-- Debranchement vers la fonction demandee
           EVALUATE FCIFAL-SCEDMD-FCT
             WHEN 'L0001'
                  PERFORM TRT-FCT-L0001
             WHEN 'L1001'
                  PERFORM TRT-FCT-L1001
             WHEN 'I0001'
                  PERFORM TRT-FCT-I0001
             WHEN 'M0001'
                  PERFORM TRT-FCT-M0001
             WHEN OTHER
                  SET W-ERR-FCTIVD TO TRUE
           END-EVALUATE.

      *=================================================================
       SORTIE.
      *=================================================================
      *-- Interpretation du code retour SQL pour alimentation des codes
      *-- Retour du message technique
           DISPLAY ' <Step 04> '
           IF SQLCODE NOT = ZERO
               Perform Trt-Erreur-SQL
           END-IF
           DISPLAY ' <Step 05> '
           IF NOT W-Trt-OK
           DISPLAY ' <Step 06> '
           DISPLAY ' W-ERR     < ' W-ERR     ' > '

           DISPLAY ' FCIFRE-err avant < ' FCIFRE-MsgErrMet(9:8) ' > '
               MOVE W-CodErrPrm TO FCIFRE-CodRetPmr
               MOVE W-CodErrScd TO FCIFRE-CodRetScd
           DISPLAY ' FCIFRE-err avant < ' FCIFRE-MsgErrMet(9:8) ' > '

           DISPLAY ' FCIFRE-PGM avant < ' FCIFRE-MSGERRMET-PGM ' > '
               MOVE C-NOMPGM    TO FCIFRE-MSGERRMET-PGM
           DISPLAY ' FCIFRE-PGM apr s < ' FCIFRE-MSGERRMET-PGM ' > '

           DISPLAY ' <Step 07> '
           ELSE
               MOVE WS-EMPLOYES TO EMPSOR-EMPLOYES-SORTIE
           DISPLAY ' <Step 08> '
           END-IF
           DISPLAY ' Fin   < ' C-NomPgm ' > '
           .
      *=================================================================
       TRT-FCT-L0001.
      *=================================================================
           MOVE 'TRT-SQL-L0001' TO W-Lbl
           EXEC SQL
             SELECT
               EMPID,
               EMPNAME,
               EMPNAM2,
               DEPARTMENT,
               SALARY,
               DESIGNATION
             INTO
               :WS-EMPID,
               :WS-EMPNAME,
               :WS-EMPNAM2,
               :WS-DEPARTMENT,
               :WS-SALARY,
               :WS-DESIGNATION
             FROM TREFEMP
             WHERE EMPID = :WS-EMPID
           END-EXEC
           MOVE 1 TO FCIFRE-NBRLIGRET.
      *    IF SQLCODE = DB2RET-NON-TROUVE
      *       MOVE ZERO TO SQLCODE
      *    ELSE
      *       MOVE 1 TO W-NbrLigRet
      *    END-IF.
      *=================================================================
       TRT-FCT-L1001.
      *=================================================================
           EXEC SQL
             DECLARE CR-L1001 CURSOR FOR
             SELECT
               EMPID,
               EMPNAME,
               EMPNAM2,
               DEPARTMENT,
               SALARY,
               DESIGNATION
             FROM TREFEMP
             ORDER BY EMPID ASC
             FOR FETCH ONLY
           END-EXEC
           EVALUATE TRUE
              WHEN FCIFAL-TYPACN-INI
                   PERFORM TRT-FCT-L1001-INI
              WHEN FCIFAL-TYPACN-LECSUI
                   PERFORM TRT-FCT-L1001-SUI
              WHEN FCIFAL-TYPACN-FINLEC
                   PERFORM TRT-FCT-L1001-FIN
              WHEN OTHER
                   SET W-ERR-TYPACNIVD   TO TRUE
           END-EVALUATE.

      *=================================================================
       TRT-FCT-L1001-INI.
      *=================================================================
           MOVE C-TRT-FCT-L1001-INI TO W-Lbl
           EXEC SQL OPEN CR-L1001 END-EXEC
           IF SQLCODE = ZERO
               PERFORM Trt-Fct-L1001-Sui
           END-IF.
      *=================================================================
       TRT-FCT-L1001-SUI.
      *=================================================================
           MOVE C-TRT-SQL-L1001-SUI TO W-Lbl
           EXEC SQL
             FETCH CR-L1001
            INTO
               :WS-EMPID,
               :WS-EMPNAME,
               :WS-EMPNAM2,
               :WS-DEPARTMENT,
               :WS-SALARY,
               :WS-DESIGNATION
           END-EXEC
      *    IF SQLCODE = DB2RET-NON-TROUVE
      *       MOVE ZERO TO SQLCODE
      *    ELSE
      *       MOVE 1 TO W-NbrLigRet
      *    END-IF
           ADD 1 TO FCIFRE-NBRLIGRET.
      *=================================================================
       TRT-FCT-L1001-FIN.
      *=================================================================
           MOVE C-TRT-FCT-L1001-FIN TO W-Lbl
           EXEC SQL CLOSE CR-L1001 END-EXEC.
      *=================================================================
       TRT-FCT-I0001.
      *=================================================================
           MOVE C-TRT-FCT-I0001 TO W-Lbl
           EXEC SQL
             INSERT INTO TREFEMP
               (EMPID,
               EMPNAME,
               EMPNAM2,
               DEPARTMENT,
               SALARY,
               DESIGNATION)
             VALUES
               (:WS-EMPID,
               :WS-EMPNAME,
               :WS-EMPNAM2,
               :WS-DEPARTMENT,
               :WS-SALARY,
               :WS-DESIGNATION)
           END-EXEC.
      *=================================================================
       TRT-FCT-M0001.
      *=================================================================
           MOVE 'TRT-SQL-M0001' TO W-Lbl
           EXEC SQL
             UPDATE TREFEMP
               SET EMPID = :WS-EMPID,
                   EMPNAME = :WS-EMPNAME,
                   EMPNAM2 = :WS-EMPNAM2,
                   DEPARTMENT = :WS-DEPARTMENT,
                   SALARY = :WS-SALARY,
                   DESIGNATION = :WS-DESIGNATION
             WHERE EMPID = :WS-EMPID
           END-EXEC
           MOVE 1 TO FCIFRE-NBRLIGRET.
      *=================================================================
       TRT-ERREUR-SQL.
      *=================================================================
           MOVE SQLCODE TO SQLErrors
           EVALUATE TRUE
              WHEN DB2RET-NON-TROUVE
                    SET W-Err-DonNonTve    TO TRUE
              WHEN DB2RET-ERR-DATE-TIME
                    SET W-Err-DatHeuIvd    TO TRUE
              WHEN DB2RET-EXISTE-DEJA
                    SET W-Err-CleDup       TO TRUE
              WHEN DB2RET-ERR-INTEGRITE
                   SET W-Err-ClePntIcu     TO TRUE
              WHEN DB2RET-ERR-CLE-PRIMAIRE
                    SET W-Err-MofIpbClePnt TO TRUE
              WHEN DB2RET-ERR-STRUCTURE
                    SET W-Err-RubIcmStr    TO TRUE
              WHEN OTHER
                    SET W-Err-DB2          TO TRUE
           END-EVALUATE.
