# Fiche technique — PointagePro

**Application Android de pointage par badges QR, hors ligne et sécurisée**

| Élément | Valeur |
|---|---|
| Projet | PointagePro |
| Version | 1.1.0 |
| Date | Novembre 2026 |
| Auteur | [Votre nom] |
| Rôle | Chef de projet / concepteur fonctionnel |
| Dépôt GitHub | `https://github.com/tojodevpro-blip/Pointage-mobile` |
| Plateforme | Android 7.0+ |
| Statut | Release logicielle validée, recette physique à finaliser |

<div class="lead">
PointagePro permet à un directeur de PME d’enregistrer les arrivées et départs de ses employés avec un simple scan de badge QR. L’application fonctionne sans Internet, sans serveur et sans abonnement.
</div>

<div class="page-break"></div>

## 1. Présentation du projet

Le pointage manuel au registre ou sur tableur entraîne des oublis, des calculs approximatifs et des litiges sur les horaires. Les solutions cloud ajoutent souvent une connexion obligatoire, un abonnement et une externalisation des données.

PointagePro répond à ce besoin avec une application Android locale et autonome :

- un téléphone suffit pour scanner les badges ;
- les données restent sur l’appareil ;
- les règles de retard, pause et heures supplémentaires sont automatiques ;
- les rapports PDF, CSV et XLSX sont prêts à être partagés.

<div class="stats">
  <div class="stat"><strong>5</strong><span>écrans métier</span></div>
  <div class="stat"><strong>5</strong><span>tables SQLite</span></div>
  <div class="stat"><strong>12</strong><span>tests automatisés</span></div>
  <div class="stat"><strong>100 %</strong><span>hors ligne</span></div>
</div>

### Objectifs

- Réduire le pointage à un geste simple et rapide.
- Supprimer les ressaisies et les erreurs de calcul.
- Garantir la traçabilité des scans et des corrections.
- Protéger les badges contre la copie et la réutilisation.
- Fournir des documents directement exploitables par l’entreprise.

### Cible

PME, ateliers, commerces et petites structures de 5 à 200 employés, avec un directeur unique équipé d’un téléphone Android.

## 2. Technologies utilisées

| Domaine | Technologie | Usage |
|---|---|---|
| Langage | Dart 3.13.7 | Logique applicative |
| Framework | Flutter 3.47.9 | Interface Android |
| État | Riverpod 2.6.1 | Injection et réactivité |
| Navigation | go_router 14.8.1 | Cinq onglets persistants |
| Base locale | Drift + SQLite | Données typées et requêtes réactives |
| Scan | mobile_scanner 6.0.11 | Lecture des QR par caméra |
| Badges | qr_flutter 4.1.0 | Génération et aperçu des QR |
| Graphiques | fl_chart 0.70.2 | Présence et heures |
| Documents | pdf + printing | Badges A6 et rapports A4 |
| Tableur | csv + excel | Exports CSV et XLSX |
| Sécurité | crypto, flutter_secure_storage, local_auth | HMAC, secret, PIN et biométrie |
| Partage | share_plus, file_picker | PDF, PNG et sauvegardes |
| Android | Gradle 9.3.1, AGP 9.1.0, JDK 17 | Compilation et signature |
| Cible | Android 7.0+ / API 36 | Compatibilité mobile |

## 3. Architecture

L’application suit une architecture **feature-first**, avec une séparation claire entre l’interface, les règles métier et les données.

<div class="arch">
  <div class="arch-box arch-ui"><strong>Présentation</strong><span>5 écrans<br>Riverpod · go_router</span></div>
  <div class="arch-arrow">→</div>
  <div class="arch-box arch-domain"><strong>Domaine</strong><span>Règles pures<br>decideScan · evaluateDay<br>StatsCalculator · QrSigner</span></div>
  <div class="arch-arrow">→</div>
  <div class="arch-box arch-data"><strong>Données</strong><span>Drift / SQLite<br>Stockage sécurisé<br>Journal d’audit</span></div>
</div>

### Organisation du code

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

### Données

| Table | Rôle |
|---|---|
| `employees` | Identité, service, photo, horaire et version de badge |
| `attendance_records` | Arrivée, départ, statut, note et correction |
| `scan_events` | Journal de chaque tentative de scan |
| `audit_logs` | Traçabilité des modifications |
| `holidays` | Jours fériés |

### Flux d’un scan

1. La caméra lit le QR `PTG1:uuid:version:hmac`.
2. La signature HMAC-SHA256 est recalculée et vérifiée.
3. L’employé est identifié par son UUID.
4. Les règles métier décident : arrivée, départ, doublon ou refus.
5. Le pointage est enregistré et chaque tentative est journalisée.
6. L’interface confirme le résultat par un son, une vibration et un message.

## 4. Fonctionnalités

| Module | Fonctionnalités |
|---|---|
| Accueil | Présents, retards, personnes sur site, absents, activité des 7 jours et derniers scans |
| Scanner | Caméra, torche, anti-doublon, saisie manuelle, son, vibration et reprise après pause |
| Employés | Création, modification, recherche, tri, filtre par département, photo et archivage |
| Badges | QR signé, aperçu, PDF A6, impression, PNG et régénération de version |
| Pointage | Arrivée, départ, retard, départ anticipé, pause, heures supplémentaires et départ manquant |
| Rapports | Jour, semaine, mois, trimestre, année ou période libre ; PDF, CSV et XLSX |
| Corrections | Saisie manuelle des heures, statut, note et journal d’audit |
| Sécurité | Code PIN, biométrie, verrouillage automatique et secret stocké de façon sécurisée |
| Données | Sauvegarde et restauration JSON, réinitialisation et base locale |
| Apparence | Thème clair/sombre, couleur principale, taille de texte, français et anglais |

## 5. Sécurité et fiabilité

- Badge QR signé avec HMAC-SHA256 et comparaison à temps constant.
- Secret aléatoire conservé dans le stockage sécurisé Android.
- Versionnement du badge : un ancien QR est immédiatement révoqué.
- Refus et journalisation des badges forgés, inconnus, archivés ou périmés.
- Code PIN dérivé avec sel et itérations, jamais stocké en clair.
- Un seul pointage par employé et par journée logique.
- Règles de retard, pause, heures supplémentaires et départ manquant testées.
- Aucune synchronisation automatique : les exports sont déclenchés par l’utilisateur.

## 6. Mon rôle et mes réalisations

| Élément | Détail |
|---|---|
| Rôle | Chef de projet et concepteur fonctionnel |
| Cadrage | Définition du besoin, de la cible, des contraintes et du périmètre hors ligne |
| Spécifications | Rédaction du cahier des charges, des parcours et des règles métier |
| Pilotage | Priorisation des fonctionnalités, arbitrages produit et suivi de la réalisation |
| Validation | Recette des cinq écrans, des exports, de la sécurité et de la sauvegarde |
| Livraison | Vérification des tests, de la signature APK et de la documentation |
| Documentation | Cahier des charges, dossier de soutenance, fiche technique et guide de livraison |

### Réalisations concrètes

- Structuration du projet autour de cinq écrans et d’un parcours simple pour le directeur.
- Définition des règles de journée logique, retard, pause, heures supplémentaires et anti-doublon.
- Conception du modèle de données et du journal d’audit.
- Validation du scan, de la signature des badges et des exports PDF/CSV/XLSX.
- Mise en place d’une démarche de vérification : analyse statique, tests, build release et empreintes SHA-256.
- Préparation des APK par architecture et de la documentation de livraison.

> **Méthode de travail.** Le développement technique a été mené avec l’assistance d’un agent IA, sous ma direction : j’ai défini le besoin, arbitré les priorités, validé les résultats et décidé de la livraison.

## 7. Captures d’écran

<div class="shots">
  <div class="shot"><div class="shot-screen"><span>Capture à insérer<br><strong>Accueil</strong></span></div><div class="shot-label">01 — Tableau de bord</div></div>
  <div class="shot"><div class="shot-screen"><span>Capture à insérer<br><strong>Scanner</strong></span></div><div class="shot-label">02 — Scan caméra</div></div>
  <div class="shot"><div class="shot-screen"><span>Capture à insérer<br><strong>Rapports</strong></span></div><div class="shot-label">03 — Rapports et exports</div></div>
</div>

<div class="shots">
  <div class="shot"><div class="shot-screen"><span>Capture à insérer<br><strong>Employés</strong></span></div><div class="shot-label">04 — Employés et badges</div></div>
  <div class="shot"><div class="shot-screen"><span>Capture à insérer<br><strong>Réglages</strong></span></div><div class="shot-label">05 — Configuration</div></div>
  <div class="shot"><div class="shot-screen"><span>Capture à insérer<br><strong>Sécurité</strong></span></div><div class="shot-label">06 — Verrouillage</div></div>
</div>

*Remplacer ces blocs par des captures réelles de la version 1.1.0 avant la diffusion.*

## 8. Liens utiles

| Ressource | Lien |
|---|---|
| Dépôt GitHub | `https://github.com/tojodevpro-blip/Pointage-mobile` |
| Releases / APK | `https://github.com/tojodevpro-blip/Pointage-mobile/releases` |
| Vidéo de démonstration | `[Lien à ajouter]` |
| Cahier des charges | `docs/CAHIER_DES_CHARGES.pdf` |
| Guide de livraison | `docs/LIVRAISON.md` |
| Contact | `[Votre e-mail]` |

*Les liens GitHub, la vidéo et le contact sont à compléter avant publication.*

## 9. Livraison et état du projet

| Élément | Valeur |
|---|---|
| Version livrée | 1.1.0 |
| APK recommandé | `PointagePro-1.1.0-arm64-v8a.apk` |
| Package | `com.pointagepro.pointagepro` |
| Android minimum | 7.0 (API 24) |
| Signature | Release, certificat `CN=PointagePro` |
| Vérifications | `flutter analyze` sans erreur, 12 tests passants, APK signé |
| Reste à faire | Recette caméra, biométrie et installation sur téléphone réel |

## 10. Checklist avant publication GitHub

- [ ] Remplacer `[Votre nom]`, `[Votre e-mail]` et `[Lien à ajouter]`.
- [ ] Ajouter les captures réelles de la version 1.1.0.
- [ ] Vérifier que `README.md` présente correctement le projet.
- [ ] Ne jamais versionner `android/key.properties` ni le keystore `.jks`.
- [ ] Publier les APK dans **Releases**, pas dans le code source.
- [ ] Lancer `flutter analyze` et `flutter test`.
- [ ] Vérifier les empreintes SHA-256 des APK.
- [ ] Relire la documentation et les liens avant le dépôt.

## 11. Commandes utiles

```powershell
flutter pub get
flutter analyze
flutter test
flutter build apk --release --split-per-abi
```

### Conclusion

PointagePro est une application complète, cohérente et documentée, prête pour un pilote mono-téléphone. La priorité avant un déploiement plus large est la validation sur appareil physique et le renforcement de la sauvegarde.
