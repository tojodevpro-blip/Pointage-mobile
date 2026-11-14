# PointagePro

Application Android de pointage par badges QR, **hors ligne**, destinée aux PME qui veulent suivre les arrivées, départs, retards, absences et heures supplémentaires sans serveur ni abonnement.

**Version :** 1.1.0  
**Plateforme :** Android 7.0+  
**Package :** `com.pointagepro.pointagepro`  
**Dépôt :** [tojodevpro-blip/Pointage-mobile](https://github.com/tojodevpro-blip/Pointage-mobile)

## Pourquoi PointagePro

Le pointage papier ou sur tableur génère des oublis, des erreurs de calcul et des litiges. PointagePro remplace ce processus par un geste simple : scanner le badge QR de l’employé. Les données restent sur le téléphone, les règles sont automatiques et les rapports sont prêts à être partagés.

- Un téléphone, des badges, aucun serveur obligatoire.
- Badges signés, versionnés et journalisés.
- Rapports PDF, CSV et XLSX.
- Sauvegarde et restauration locales.
- Interface française et anglaise.

## Fonctionnalités

- **Accueil** : présents, retards, personnes sur site, absents, activité des 7 derniers jours.
- **Scanner** : caméra, torche, anti-doublon, saisie manuelle, son, vibration et reprise après pause.
- **Employés** : création, modification, recherche, filtre par département, photo et archivage.
- **Badges** : QR signé, aperçu, PDF A6, impression, PNG et régénération de version.
- **Pointage** : arrivée, départ, retard, départ anticipé, pause, heures supplémentaires et départ manquant.
- **Rapports** : jour, semaine, mois, trimestre, année ou période libre ; PDF, CSV et XLSX.
- **Corrections** : saisie manuelle des heures, statut, note et journal d’audit.
- **Sécurité** : code PIN, biométrie et verrouillage automatique.
- **Données** : sauvegarde/restauration JSON et réinitialisation complète.

## Stack technique

| Domaine | Technologie |
|---|---|
| Langage | Dart 3.13.7 |
| Framework | Flutter 3.47.9 |
| État | Riverpod |
| Navigation | go_router |
| Base locale | Drift + SQLite |
| Scan | mobile_scanner |
| Badges | qr_flutter |
| Graphiques | fl_chart |
| PDF | pdf + printing |
| Tableur | csv + excel |
| Sécurité | crypto, flutter_secure_storage, local_auth |
| Android | Gradle 9.3.1, AGP 9.1.0, JDK 17 |
| Cible | Android 7.0+ / API 36 |

## Architecture

Le projet suit une architecture **feature-first** :

```text
lib/
  core/          base, sécurité, thème, providers, l10n
  features/
    dashboard/   accueil et indicateurs
    scanner/     scan caméra et décisions
    employees/   employés et badges
    attendance/  pointage et règles métier
    reports/     statistiques et exports
    settings/    configuration, audit, sauvegarde
```

Les règles métier sont isolées dans le domaine et testables sans caméra ni base de données.

## Démarrage

Prérequis : Flutter 3.47.9, Dart 3.13.7, JDK 17 et Android SDK 36.

```powershell
flutter pub get
flutter gen-l10n
flutter analyze
flutter test
flutter run
```

## Build release

1. Copier `android/key.properties.example` vers `android/key.properties`.
2. Renseigner les mots de passe et le chemin du keystore.
3. Placer le keystore local dans `android/app/`.
4. Lancer le build :

```powershell
flutter build apk --release --split-per-abi
```

Les APK générés ne doivent pas être versionnés. Publier les fichiers dans **GitHub Releases**.

```text
dist/                 # artefacts locaux ignorés par Git
android/key.properties
android/app/*.jks
```

## Téléchargement

Les APK signés sont disponibles dans les [GitHub Releases](https://github.com/tojodevpro-blip/Pointage-mobile/releases/latest).

- `arm64-v8a` : plupart des téléphones Android récents.
- `armeabi-v7a` : appareils 32 bits plus anciens.
- `x86_64` : émulateurs et appareils Intel.

## Documentation

- [Fiche technique](docs/FICHE_TECHNIQUE.pdf)
- [Cahier des charges](docs/CAHIER_DES_CHARGES.pdf)
- [Dossier de projet](docs/DOSSIER_PROJET.md)
- [Guide de livraison](docs/LIVRAISON.md)
- [Présentation de soutenance](docs/PointagePro_Soutenance.pdf)

## Sécurité

- Badge QR signé en HMAC-SHA256.
- Secret stocké dans le stockage sécurisé Android.
- Versionnement et révocation des badges.
- Code PIN dérivé avec sel et itérations.
- Journal des scans et des modifications.
- Aucune synchronisation automatique.

## État du projet

La version 1.1.0 est une release logicielle validée : `flutter analyze` sans erreur, 12 tests passants, APK signé et documentation à jour. La recette caméra, biométrie et installation sur téléphone réel reste à finaliser.

## Auteur

Projet conçu et piloté par **[Votre nom]**, dans le cadre d’une soutenance et d’un pilote en entreprise.

---

© 2026 PointagePro. Projet privé.
