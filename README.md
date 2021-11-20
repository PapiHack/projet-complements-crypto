# Projet Compléments Cryptographique : Cryptographie et Sécurité des Systèmes Bancaires

Ce dépôt contient le code source du projet du module de compléments cryptographique.

## Description

Le projet est constitué des composants suivants:

- [SamaBank App : Application mobile](https://github.com/PapiHack/projet-complements-crypto/tree/master/sama_bank)
- [Bank API : Backend en Spring Boot](https://github.com/PapiHack/projet-complements-crypto/tree/master/bank-api)
- [SMS Sender Service : Service d'envoi de SMS](https://github.com/PapiHack/projet-complements-crypto/tree/master/sms-api)

Le but de ce projet est d'appliquer les systèmes cryptographiques afin garantir la confidentialité et l’authenticité d’une transaction bancaire, mais aussi se familiariser avec des systèmes d’authentification multi-couches.
Afin de mener à bien cet objectif, nous avons conçu un client mobile où l'utilisateur pourra accéder à un ensemble d'opérations bancaires après s'être préalablement authentifier. Elle se fera en plusieurs étapes comprenant une vérification via `OTP` chiffré avec `AES` en combinaison avec un code `PIN`.
Un service nommé `CryptographyService` situé au niveau du `BankAPI` implémente un ensemble de méthodes facilitant les opérations cryptographiques (chiffrement, déchiffrement, génération de clé et création d'un `Cypher`, etc.).

## Stack Technlogique

- `Dart & Flutter`
- `Java & Spring Boot`
- `Python & FastAPI`
- `PostgreSQL`

## Architecture

De manière simple, l'application mobile communique avec les services web exposés par le `Bank API`. Ce dernier est branché sur une base de données
`PostgreSQL` et interagit avec le service d'envoi de SMS au besoin afin de notifier les utilisateurs sur d'éventuels événements.

![screenshot](./screenshots/archi-crypto-new.jpg)

## Screenshots de l'application mobile

![screenshot](./screenshots/app.png)
![screenshot](./screenshots/app-1.png)
![screenshot](./screenshots/app-2.png)

## Documentation API

![screenshot](./screenshots/api-docs-1.png)

## Auteur

- [M.B.C.M](https://github.com/PapiHack)
  [![My Twitter Link](https://img.shields.io/twitter/follow/the_it_dev?style=social)](https://twitter.com/the_it_dev)

  UCAD\ESP\DGI\M2MSSI - 2021