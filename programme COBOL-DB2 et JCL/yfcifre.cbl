      ******************************************************************
      * NOM DU COPY  : YFCIFRE                                 V(1.00) *
      * PROJET       :                                                 *
      * OBJET DECRIT : D finition de la partie fixe Retour             *
      *                                                                *
      * LONGUEUR     : 350 OCTETS                                      *
      ******************************************************************

       01  YFCIFRE.

      *================================================================*
      * PARTIE FIXE RETOUR                        -----DEB=151/LON=336
      *================================================================*
          05  FCIFRE-RET.

      *----------------------------------------------------------------*
      * RESULTAT DE L'EXECUTION                   -----DEB=151/LON=080
      *----------------------------------------------------------------*
             10  FCIFRE-RtaExe.

      *-- Message d'erreur m tier pour l'utilisateur --DEB=151/LON=080
                15  FCIFRE-MsgErrMet.

      *   -- Nom du programme ayant d tect  l'erreur m tier
                   20  FCIFRE-MsgErrMet-Pgm            PIC X(008).
      *   -- Code retour primaire
                   20  FCIFRE-MsgErrMet-CodRetPmr      PIC X(004).
      *   -- Code retour secondaire (applicatif)
                   20  FCIFRE-MsgErrMet-CodRetScd      PIC X(004).
                         88 FCIFRE-MsgErrMet-NonTvr      VALUE '0100'.
                   20  FILLER                          PIC X(001).
      *   -- Libell  du message utilisateur
                   20  FCIFRE-MsgErrMet-Msg            PIC X(063).

                15  FILLER REDEFINES FCIFRE-MsgErrMet.
                   20 FILLER                          PIC X(008).
      *-- Code retour primaire                    -----DEB=159/LON=004
      *-  Commun   tous les accesseurs
      *      '0000': Traitement correct
      *      '0001': Requete non autorisee
      *      '0002': Donn es indisponibles
      *      '0003': Param tres erron s dans la partie fixe aller
      *      '0004': Arguments de recherche erron s
      *      '0005': Donn es pour mise   jour erron es
      *      '0006': Donn es non trouv es
      *      '0007': Cl  duppliqu e ( l ment   cr er d j  existant)
      *      '0008': Erreur traitement
      *      '9999': Erreur fatale

                    20  FCIFRE-CodRetPmr               PIC X(004).
                        88  FCIFRE-CodRet-TrtCrf       VALUE '0000'.
                        88  FCIFRE-CodRet-TrtNonVld    VALUE '0001'
                                                       THRU  '9999'.
                        88  FCIFRE-CodRet-NonAut       VALUE '0001'.
                        88  FCIFRE-CodRet-DonIdp       VALUE '0002'.
                        88  FCIFRE-CodRet-ParFixErr    VALUE '0003'.
                        88  FCIFRE-CodRet-ArgRchErr    VALUE '0004'.
                        88  FCIFRE-CodRet-DonErr       VALUE '0005'.
                        88  FCIFRE-CodRet-DonNonTve    VALUE '0006'.
                        88  FCIFRE-CodRet-CleDup       VALUE '0007'.
                        88  FCIFRE-CodRet-ErrTrt       VALUE '0008'.
                        88  FCIFRE-CodRet-ErrFtl       VALUE '9999'.
      *-- Code retour secondaire (applicatif)     -----DEB=163/LON=00
                    20  FCIFRE-CodRetScd               PIC 9(004).

      *-- Indicateur de fin de liste
                    20  FCIFRE-IndFinLis               PIC 9(001).
                        88 FCIFRE-NonFinLis            VALUE 0.
                        88 FCIFRE-FinLis               VALUE 1.

      *-- Nombre de lignes retourn es
                    20  FCIFRE-NbrLigRet               PIC 9(5).

      *-- Nombre de lignes totales
      *             20  FCIFRE-NbrLigTot               PIC 9(5).
      *
      *-- Nombre de pages retourn es
      *             20  FCIFRE-NbrPagRet               PIC 9(5).
      *
                    20  FILLER                         PIC X(058).
      *----------------------------------------------------------------
      *   CIRCONSTANCES DE L'EXECUTION            -----DEB=231/LON=107
      *----------------------------------------------------------------
      *      10  FCIFRE-CadExe.
      *
      *-- Mesure des acces physiques              -----DEB=231/LON=004
      *         15  FCIFRE-CadExe-MesAcePhy            PIC 9(004).
      *
      *-- Message d'erreur technique 'informaticien' --DEB=235/LON=080
      *   Renseign  en cas de pb grave
      *         15  FCIFRE-CadExe-MsgErrTec.

      *  -- Nom du programme en erreur
      *            20  FCIFRE-CadExe-MsgErrTec-Pgm     PIC X(008).

      *  -- Identifiant de l'ordre DB2 ou DL1 en erreur
      *            20  FCIFRE-CadExe-MsgErrTec-Ord     PIC X(008).

      *  -- Code retour primaire technique DB2 ou DL1
      *            20  FCIFRE-CadExe-MsgErrTec-Ret     PIC X(004).

      *  -- Libell  du message technique
      *            20  FCIFRE-CadExe-MsgErrTec-Msg     PIC X(060).
      *- RESERVE --------------------------------------DEB=315/LON=046

             10  FILLER                                PIC X(036).
