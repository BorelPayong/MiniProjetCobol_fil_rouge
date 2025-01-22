# MiniProjetCobol_fil_rouge
Mini-Projet COBOL fil rouge - Suivi Clientèle Financière

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
Fichiers concernés : creatfich.jcl, creatvsam.jcl

### Partie 2 : Manipulation des données VSAM
- Séparation des clients par profession, région ou type de compte.
- Création et tri des fichiers avec **SORT**
Fichiers concernés : creatps.jcl

### Partie 3 : Développement COBOL
- Ajout, mise à jour et édition des données clients.
- Calcul des totaux et des moyennes des comptes débiteurs/créditeurs.
- Gestion des mouvements clients.
Fichiers concernés : quest10.cbl, quest13.cbl, quest14.cbl, quest15.cbl, quest16.cbl, quest17.cbl, quest19.cbl, quest20.cbl, quest21.cbl, pgmsecnd.cbl
pour la compilation des programmes : compilpgm.jcl, compilsouspgm.jcl
pour exécuter les programmes : execpgm.jcl, execpgmquest19.jcl
