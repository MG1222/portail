# Portal-Website

## Table des matières

- [Introduction](#introduction)
- [Structure du Projet](#structure-du-Projet)
- [Configuration initiale](#Configuration-initiale)
- [Tables de la base de données](#tables-de-la-base-de-données)
    - [admin](#admin)
    - [documents](#documents)
    - [projects](#projects)
    - [roles](#roles)
    - [users](#users)
- [Fonctionnalités principales](#fonctionnalités-principales)

## Introduction
Ce projet est une application web en PHP conçue pour gérer les profils des utilisateurs et des administrateurs.
Elle comprend des fonctionnalités telles que l'authentification, la gestion des rôles, la réinitialisation des mots de passe, et la gestion des projets.
Les utilisateurs et les administrateurs peuvent voir tous leurs projets associés dans le système.

1. **Main Admin** :
    - Peut créer, gérer et supprimer tous les utilisateurs et les administrateurs.
    - Peut gérer tous les projets.
    - L'identifiant par défaut pour se connecter en tant que Main Admin est `mainAdmin@email.com` avec le mot de passe `admin`.

2. **Admin** (par exemple admin-rum) :
    - Peut gérer uniquement les utilisateurs ayant des projets spécifiques (par exemple, admin-rum peut gérer uniquement les utilisateurs avec des projets rum).

3. **Utilisateur** :
    - Peut consulter ses propres projets.


## Structure du Projet
1. Contrôleurs : Gestion de la logique métier. 
2. Modèles : Interaction avec la base de
   données.
3. Vues : Génération du HTML côté client. 
4. Configuration : Paramètres pour la base de
   données et le routage.
5. Bibliothèques et Core : Classes de base pour
   les contrôleurs et les modèles.



### Configuration initiale

- Pour que l'application fonctionne correctement, assurez-vous que la base de données est correctement configurée (config/defaults.php). 
- Lors de la première exécution, le Main Admin est automatiquement créé si la base de données existe.
- #### L'identifiant par défaut pour se connecter en tant que Main Admin est `mainAdmin@email.com` avec le mot de passe `admin`.
- #### Composer
    Cette application utilise Composer pour la gestion des dépendances PHP. Assurez-vous d'avoir Composer installé sur votre machine. Si ce n'est pas le cas, suivez les instructions sur [le site officiel de Composer](https://getcomposer.org/).

    Pour installer les dépendances :
    ```bash
    composer install
    ```

    Pour mettre à jour les dépendances :
    ```bash
    composer update
    ```
- #### Pour envoyer des e-mails via l'application, assurez-vous de configurer le `MailController` avec les bonnes informations du serveur SMTP :

    ```php
    $mail->Host = 'votre_host_smtp';
    $mail->Port = votre_port; 
    ```

  Quelques exemples de configurations pour des services de messagerie populaires :

    1. **Gmail** :
        ```php
        $mail->Host = 'smtp.gmail.com';
        $mail->Port = 587; // Utilisez 465 pour SSL
        $mail->SMTPSecure = 'tls'; // Utilisez 'ssl' pour SSL
        ```

    2. **SendGrid** :
        ```php
        $mail->Host = 'smtp.sendgrid.net';
        $mail->Port = 587; // Utilisez 465 pour SSL
        ```

    3. **Mailgun** :
        ```php
        $mail->Host = 'smtp.mailgun.org';
        $mail->Port = 587;
        ```

    4. **Amazon SES** (exemple pour la région US West (Oregon)) :
        ```php
        $mail->Host = 'email-smtp.us-west-2.amazonaws.com';
        $mail->Port = 587;
        ```

  Si vous utilisez un autre service, consultez la documentation ou le support de ce service pour obtenir les bons paramètres.


## Tables de la base de données

### `admin`
- **id**: Clé primaire.
- **email**: Email de l'administrateur.
- **password**: Mot de passe (haché) de l'administrateur.
- **firstName**: Prénom de l'administrateur.
- **lastName**: Nom de famille de l'administrateur.
- **role_id**: Clé étrangère liée à la table `roles`.
- **reset_token**: Token pour la réinitialisation du mot de passe.
- **reset_token_expiry**: Date d'expiration du token de réinitialisation.

### `documents`
- **id**: Clé primaire.
- **name**: Nom du document.
- **project_id**: Clé étrangère liée à la table `projects`.
- **period**: Période associée au document.
- **user_id**: Clé étrangère liée à la table `users`.
- **admin_id**: Clé étrangère liée à la table `admin`.
- **document**: Chemin ou URL du document.

### `projects`
- **id**: Clé primaire.
- **name**: Nom du projet.
- **period**: Période du projet.
- **comment**: Commentaire ou description du projet.
- **type_id**: Type de projet (non spécifié dans la documentation actuelle).
- **link_snapshot**: Lien vers un instantané ou une capture d'écran du projet.
- **link_dashboard**: Lien vers le tableau de bord du projet.
- **user_id**: Clé étrangère liée à la table `users`.
- **admin_id**: Clé étrangère liée à la table `admin`.

### `roles`
- **id**: Clé primaire.
- **name**: Nom du rôle.
- **type_project**: Type de projet associé au rôle.

### `users`
- **id**: Clé primaire.
- **email**: Email de l'utilisateur.
- **password**: Mot de passe (haché) de l'utilisateur.
- **firstName**: Prénom de l'utilisateur.
- **lastName**: Nom de famille de l'utilisateur.
- **role_id**: Clé étrangère liée à la table `roles`.
- **reset_token**: Token pour la réinitialisation du mot de passe.
- **reset_token_expiry**: Date d'expiration du token de réinitialisation.

## Fonctionnalités principales

Gestion des utilisateurs :
Le "Main Admin" peut créer et supprimer tous les utilisateurs ou administrateurs.
Les administrateurs spécifiques (par exemple, admin-rum) peuvent gérer uniquement les utilisateurs associés à leurs projets spécifiques.

1. **Gestion des projets**:
    - Création, modification, et suppression de projets.
    - Association de documents à des projets.

2. **Gestion des documents**:
    - Ajout, modification, et suppression de documents.
    - Association de documents à des utilisateurs ou des administrateurs.

3. **Gestion des utilisateurs et des administrateurs**:
    - Inscription, connexion, et déconnexion.
    - Réinitialisation du mot de passe.
    - Attribution de rôles aux utilisateurs.

4. **Gestion des rôles**:
    - Définition des permissions associées à chaque rôle.
    - Attribution de rôles aux utilisateurs et aux administrateurs.
