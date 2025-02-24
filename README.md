# MiniProjetCobol_fil_rouge
Mini-Projet COBOL fil rouge - Suivi Clientèle Financière
**(Dossier programme COBOL et JCL)**

Ce dépôt contient le code source et les fichiers JCL nécessaires à la réalisation d'un projet COBOL pour la gestion des clients et de leurs mouvements financiers. 
Ce projet a été développé sous l'environnement **IBM Z/OS** et utilise les technologies **COBOL**, **JCL**, **VSAM** et divers utilitaires Z/OS comme **SORT** et **IDCAMS**.

-----

L'objectif de ce projet est de mettre en place un système de gestion des clients, de leurs comptes et de leurs mouvements financiers. Ce projet inclut :
- Le développement de programmes COBOL pour l'analyse, l'édition et la mise à jour des données.
- L'utilisation d'outils Z/OS pour trier, fusionner et organiser les données.
- Créer, manipuler et analyser des fichiers de données clients.
- Gérer des mouvements financiers.
- Utiliser des structures VSAM avancées comme **KSDS** et **AIX**.

### Partie 1 : Chargement des données
- Création des fichiers nécessaires avec **IEBGENER** et **IDCAMS**.
Fichiers concernés : **creatfich.jcl, creatvsam.jcl**

### Partie 2 : Manipulation des données VSAM
- Séparation des clients par profession, région ou type de compte.
- Création et tri des fichiers avec **SORT**
Fichiers concernés : **creatps.jcl**

### Partie 3 : Développement COBOL
- Ajout, mise à jour et édition des données clients.
- Calcul des totaux et des moyennes des comptes débiteurs/créditeurs.
- Gestion des mouvements clients.
Fichiers concernés : **quest10.cbl, quest13.cbl, quest14.cbl, quest15.cbl, quest16.cbl, quest17.cbl, quest19.cbl, quest20.cbl, quest21.cbl, pgmsecnd.cbl**
pour la compilation des programmes : **compilpgm.jcl, compilsouspgm.jcl**
pour exécuter les programmes : **execpgm.jcl, execpgmquest19.jcl**

# MiniProjetCobol_fil_rouge
Mini-Projet COBOL fil rouge - gestion transactionnelle des clients d’une institution financière
**(Dossier programme COBOL-CICS, MAP et JCL)**

Ce dépôt contient le code source et les fichiers JCL nécessaires à la réalisation d’un projet **COBOL-CICS-VSAM** sous **IBM Z/OS**.
L’application permet la gestion des clients via **une interface CICS**, avec des transactions permettant la création, mise à jour, affichage et suppression des clients stockés dans un fichier VSAM KSDS.

-----

L’objectif est d’implémenter un système transactionnel permettant la gestion des clients d’une institution financière.
Les fonctionnalités incluent :
- L’intégration d’un fichier VSAM sous CICS pour stocker les informations clients.
- Le développement de MAPs et de transactions CICS pour interagir avec les données.
- L’utilisation de commandes CICS telles que STARTBR, READNEXT et ENDBR pour la navigation dans les enregistrements.
- L’implémentation de statistiques régionales sur les comptes débiteurs et créditeurs.

### Partie 1 : Création et gestion du Data Set CLIENT sous CICS
- Définition du Data Set CLIENT en tant que VSAM KSDS avec accès en lecture, écriture et suppression.
- Intégration sous CICS avec déclaration en tant que ressource utilisable par les transactions.

### Partie 2 : Développement de MAPs interactives sous CICS
- Création d’une MAP client : cette map sera utilisé pour toute les operation du CRUD sur le fichier.
- Ajout de zones de saisie protégées et de messages d’erreur dynamiques.
fichiers concernés : **mapprojet.asm**

### Partie 3 : Transactions CICS pour la gestion des clients
- Affichage d’un client par numéro de compte, avec validation des entrées.
fichiers concernés : **prgread.cbl**
- Ajout d’un client avec contrôle des doublons et message de confirmation.
fichiers concernés : **prgwrite.cbl**
- Mise à jour des informations client, avec contrôle de l’existence avant modification.
fichiers concernés : **prgrewrite.cbl**
- Suppression d’un client, en vérifiant que le numéro de compte existe.
fichiers concernés : **prgdelete.cbl, prgreaddelete.cbl**

### Partie 4 : Navigation et suppression avancée avec STARTBR et READNEXT
- Suppression des clients avec code générique 111... via un parcours séquentiel avec STARTBR et DELETE.
fichiers concernés : **prgdeletegeneric.cbl**
- Lecture successive des clients 222... avec READNEXT et fermeture propre avec ENDBR.
fichiers concernés : **prglectsuiv.cbl**

### Partie 5 : Calcul des statistiques des clients par région
- Création d’une MAP region.
fichiers concernés : **mapregion.asm**
Développement d’une programme permettant de calculer :
- Le nombre total de clients par région.
- La somme des montants des clients débiteurs et leur nombre.
- La somme des montants des clients créditeurs et leur nombre.
- Affichage dynamique des résultats via une MAP dédiée.
fichiers concernés : **prgregion.cbl**
