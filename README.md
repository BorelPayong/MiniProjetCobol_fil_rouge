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

# Mini Projet COBOL-DB2 
Mini Projet COBOL-DB2 - Gestion des Employés **(Dossier programme COBOL-DB2 et JCL)** 

Ce dépôt contient le code source et les fichiers JCL nécessaires à la réalisation d’un projet COBOL-DB2 visant à mettre en place un système d’accès aux données employés via des accesseurs physique et logique. 

Les accesseurs physique, logique et le programme de test ont été initialement fourni par le formateur sous forme de programmes de base, et nous avons enrichi la couche logique ainsi que le programme de test pour répondre au différent test. 

Les tests unitaires ont été exécutés avec succès jusqu’au test-08. 

-----

L’objectif principal est de développer un accès structuré aux données des employés stockées dans une base DB2 via deux accesseurs :
- REFPEMP (Accesseur Physique) : Interface directe avec la table REFPEMP. programme de base fourni par le formateur qui n'a pas été modifié
- REFLEMP (Accesseur Logique) : Vérification des données avant d’appeler REFLEMP. Enrichi par nos soins pour répondre au differentes questions.

Le projet inclut :
- La gestion des employés (création, lecture, modification).
- La mise en place d’un programme de test pour automatiser les appels aux accesseurs.
- L’exécution et la validation des tests unitaires

### Partie 1 : Accesseurs DB2
REFPEMP (Accesseur Physique) :
- Interface directe avec la table TREFEMP.
- Accès aux employés via des fonctions spécifiques.
- Renvoi des informations sous forme d’occurrences.

REFLEMP (Accesseur Logique) :
- Vérification de la disponibilité de la fonction demandée.
- Validation des données (numéricité, format des dates, valeurs obligatoires).
- Transmission des requêtes à REFPEMP après contrôle.

### Partie 2 : Implémentation des fonctions d’accès
Chaque accesseur implémente les fonctions suivantes :
- L0001 : Lecture d’un employé par identifiant.
- I0001 : Création d’un employé.
- M0001 : Modification des informations d’un employé.

### Partie 3 : Développement du programme de test
Un programme de test REFBTEST a été conçu pour appeler REFLEMP et valider les traitements.Les tests unitaires ont été exécutés avec succès jusqu’au TEST-08.

liste des tests exécutés : 
- Test-01	Fournir un code fonction incorrect	Message d'erreur "Arguments fixe incorrects"
- Test-02	Demander une lecture unique (L0001) sans arguments variables	Message d'erreur "Arguments variables incorrects"
- Test-03	Demander une création d'employé (I0001) sans arguments variables	Message d'erreur "Arguments variables incorrects"
- Test-04	Demander une création d'employé (I0001) avec au moins un argument obligatoire vide	Message d'erreur "Arguments variables incorrects"
- Test-05	Demander une mise à jour employé (M0001) avec au moins un argument obligatoire vide	Message d'erreur "Arguments variables incorrects"
- Test-06	Obtenir un employé à partir d'un ID (L0001)	infos employé affichés
- Test-07	Créer un nouveau employé (I0001)	Employé crée
- Test-08	Mise à jour d'un nouveau employé (M0001)	Employé mis à jour
