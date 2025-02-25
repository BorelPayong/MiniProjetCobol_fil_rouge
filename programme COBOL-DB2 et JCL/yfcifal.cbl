      *****************************************************************
      * NOM DU COPY  : YFCIFAL                                 V(1.00)
      * PROJET       :
      * OBJET DECRIT : DEFINITION DE LA PARTIE FIXE ALLER
      *
      * LONGUEUR     : 350 OCTETS
      *****************************************************************

       01  YFCIFAL.

      *================================================================
      * PARTIE FIXE ALLER                         -----DEB=001/LON=150
      *================================================================
          05  FCIFAL-ALL.

      *----------------------------------------------------------------
      *   IDENTIFICATION DU SERVICE DEMANDE       -----DEB=063/LON=017-
      *----------------------------------------------------------------
             10  FCIFAL-SCEDMD.

      *-- OBJET DE GESTION
                15  FCIFAL-SCEDMD-OBJGES               PIC X(006).

      *-- FONCTION DEMAND E                       -----DEB=069/LON=005
                15  FCIFAL-SCEDMD-FCT.

      *-- TYPE DE FONCTION DEMAND E               -----DEB=069/LON=001
      *      'I': INSERTION
      *      'L': LECTURE
      *      'M': MODIFICATION
      *      'S': SUPPRESSION
      *      'C': CONTROLE

                   20  FCIFAL-SCEDMD-TYPFCT            PIC X(001).
                      88  FCIFAL-TYPFCT-RCN     VALUE
                             'I' 'L' 'M' 'S' 'C'.
                      88  FCIFAL-TYPFCT-ISR            VALUE 'I'.
                      88  FCIFAL-TYPFCT-LEC            VALUE 'L'.
                      88  FCIFAL-TYPFCT-MOD            VALUE 'M'.
                      88  FCIFAL-TYPFCT-SPS            VALUE 'S'.
                      88  FCIFAL-TYPFCT-CTL            VALUE 'C'.

      *-- NUM RO DE FONCTION DEMAND E             -----DEB=070/LON=004
                   20  FCIFAL-SCEDMD-NUMFCT            PIC X(004).

      *-- CLAUSE COPY ALL E                       -----DEB=074/LON=006
      *         15  FCIFAL-NODALL                      PIC X(006).
      *-- CLAUSE COPY RETOUR                      -----DEB=080/LON=006
      *         15  FCIFAL-NODRET                      PIC X(006).
      *
      *----------------------------------------------------------------*
      *   CARACTERISTIQUE DU SERVICE DEMANDE      -----DEB=086/LON=046-*
      *----------------------------------------------------------------*
             10  FCIFAL-CARSCEDMD.

      *-- TYPE D'ACTION DEMAND E                  -----DEB=086/LON=003
      *     'CTL' - CONTR LES
      *     'INS' - INSERTION
      *     'LEU' - LECTURE UNIQUE
      *     'LEI' - LECTURE INITIALE
      *     'LEP' - LECTURE PR CEDENTE
      *     'LES' - LECTURE SUIVANTE
      *     'LBI' - LECTURE BLOC INITIAL    (REND N OCCURRENCES)
      *     'LBS' - LECTURE BLOC SUIVANT    (REND N OCCURRENCES)
      *     'LBP' - LECTURE BLOC PR C DENT  (REND N OCCURRENCES)
      *     'LBU' - LECTURE BLOC UNIQUE     (REND N OCCURRENCES)
      *     'LEF' - FIN DE LECTURE
      *     'LEM' - LECTURE AVEC INTENTION DE MISE   JOUR
      *     'MOD' - MODIFICATION
      *     'SUP' - SUPPRESSION
                15  FCIFAL-CARSCEDMD-TYPACN            PIC X(003).
                   88  FCIFAL-TYPACN-RCN       VALUE
                         'CTL' 'INS' 'LEU' 'LEI' 'LEP' 'LES' 'LEF'
                         'MOD' 'LBI' 'LBP' 'LBS' 'LEM' 'LVC'
                         'CVL' 'LBU'.
                   88  FCIFAL-TYPACN-CTL               VALUE 'CTL'.
                   88  FCIFAL-TYPACN-ISR               VALUE 'INS'.
                   88  FCIFAL-TYPACN-UNQ               VALUE 'LEU'.
                   88  FCIFAL-TYPACN-INI               VALUE 'LEI'.
                   88  FCIFAL-TYPACN-LECPCD            VALUE 'LEP'.
                   88  FCIFAL-TYPACN-LECSUI            VALUE 'LES'.
                   88  FCIFAL-TYPACN-LECBLCINI         VALUE 'LBI'.
                   88  FCIFAL-TYPACN-LECBLCSUI         VALUE 'LBS'.
                   88  FCIFAL-TYPACN-LECBLCPCD         VALUE 'LBP'.
                   88  FCIFAL-TYPACN-FINLEC            VALUE 'LEF'.
                   88  FCIFAL-TYPACN-LECMAJ            VALUE 'LEM'.
                   88  FCIFAL-TYPACN-MOD               VALUE 'MOD'.
                   88  FCIFAL-TYPACN-SPS               VALUE 'SUP'.
                   88  FCIFAL-TYPACN-CNVLTNCBL         VALUE 'LVC'.
                   88  FCIFAL-TYPACN-CNVCBLLTN         VALUE 'CVL'.
                   88  FCIFAL-TYPACN-LECBLCUNQ         VALUE 'LBU'.

                15  FCIFAL-CARSCEDMD-FMTDAT.
      *        TYPE DES DATES
                    20 FCIFAL-CARSCEDMD-DATTYP         PIC X(001).
      *        SENS DES DATES
                    20 FCIFAL-CARSCEDMD-DATSEN         PIC X(001).
      *        S PARATEUR
                    20 FCIFAL-CARSCEDMD-DATSEP         PIC X(001).


      *-- DATE DE L'APPEL                         -----DEB=098/LON=008
                15  FCIFAL-CARSCEDMD-DAT.
                    20 FCIFAL-CARSCEDMD-DAT-SSAA       PIC 9(4).
                    20 FCIFAL-CARSCEDMD-DAT-MM         PIC 99.
                    20 FCIFAL-CARSCEDMD-DAT-JJ         PIC 99.

      *-- HEURE DE L'APPEL                        -----DEB=106/LON=008
                15 FCIFAL-CARSCEDMD-HEU.
                    20 FCIFAL-CARSCEDMD-HEU-HH         PIC 99.
                    20 FCIFAL-CARSCEDMD-HEU-MM         PIC 99.
                    20 FCIFAL-CARSCEDMD-HEU-SS         PIC 99.
                    20 FCIFAL-CARSCEDMD-HEU-CC         PIC 99.

      *-- CODE PAYS                               -----DEB=114/LON=002
                15  FCIFAL-CARSCEDMD-CODPAY            PIC X(2).
      *-- CODE LANGUE                             -----DEB=116/LON=002
                15  FCIFAL-CARSCEDMD-CODLNG            PIC X(2).

      *-- RESERVE -------------------------------------DEB=118/LON=033
             10  FILLER                                PIC X(111).
