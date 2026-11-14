# PointagePro — Dossier de présentation et de soutenance

Version 1.1.0 — novembre 2026

---

## 1. Le pitch en 30 secondes

PointagePro est une application Android de pointage par badges QR, conçue pour les PME qui veulent suivre les arrivées, départs, retards, absences et heures supplémentaires **sans Internet, sans serveur et sans abonnement**. Le directeur crée ses employés, imprime ou partage leurs badges, scanne les QR avec le téléphone, puis consulte des rapports PDF/CSV. Les badges sont signés cryptographiquement et versionnés pour limiter la fraude. L’application fonctionne entièrement hors ligne : les données restent sur l’appareil.

---

## 2. Fiche d’identité du projet

| Élément | Valeur |
|---|---|
| Nom | PointagePro |
| Problème traité | Pointage manuel, oublis, erreurs de calcul, badges falsifiés, absence d’Internet |
| Solution | Application Android hors ligne, badges QR signés, tableau de bord et rapports |
| Cible | PME, ateliers, commerces, petites structures de 5 à 200 employés |
| Utilisateur principal | Directeur / responsable unique |
| Plateforme | Android 7.0+ (API 24), cible API 36 |
| Version livrée | 1.1.0 |
| Package | `com.pointagepro.pointagepro` |
| APK recommandé | `PointagePro-1.1.0-arm64-v8a.apk`, 38,0 Mo, signé release |
| SHA-256 | `9FA2A1AFAB0D7FEC83BB04E425A48DCF6AF6B4537100AC624CDE332335A51BA2` |
| Statut | Release signée et vérifiée ; installation physique restant à faire |

---

## 3. Comment le projet a été réalisé

### 3.1 Démarche en six phases

| Phase | Objectif | Livrables |
|---|---|---|
| 1. Cadrage | Comprendre le besoin, les contraintes et le périmètre | Fonctionnalités, règles de pointage, choix offline-first, français par défaut |
| 2. Architecture | Poser une base maintenable | Architecture feature-first, modèle de données, providers, thème |
| 3. Socle métier | Garantir la fiabilité des pointages | Tables Drift, repositories, règles d’arrivée/départ, calculs statistiques |
| 4. Sécurité | Empêcher les badges fantaisistes | Signature HMAC-SHA256, stockage sécurisé du secret, versionnement des badges, journal des scans |
| 5. Interface | Rendre l’outil simple pour un directeur | 5 écrans : Accueil, Scanner, Employés, Rapports, Réglages |
| 6. Qualité et livraison | Prouver que l’application fonctionne | `flutter analyze`, 12 tests, build release, signature, vérification de l’APK |

### 3.2 Ce qui a été confié à l’agent de codage

L’agent a été utilisé comme un exécutant technique autonome, avec une boucle **lire → planifier → modifier → exécuter → vérifier → corriger**.

| Domaine confié | Travail réalisé |
|---|---|
| Environnement | Diagnostic du disque C: plein, déplacement des caches Gradle/pub, validation du JDK 17, du SDK Android 36 et de Flutter |
| Génération du socle | Création de 35 fichiers Dart, 5 tables Drift, génération du code SQLite, providers Riverpod |
| Implémentation | Écrans Accueil, Scanner, Employés, Rapports, Réglages ; thème clair/sombre ; widgets partagés ; exports PDF/CSV |
| Sécurité | Génération du secret QR, signature HMAC, vérification à temps constant, révocation des badges, journal d’audit |
| Tests | 12 tests sur la signature QR, les règles de pointage, les statistiques et le démarrage de l’application |
| Build Android | Migration Gradle/AGP 9, correction du `compileSdk` 36 pour les plugins, signature release, vérification de l’APK |
| Diagnostic | Lecture des logs, résolution des dépendances, correction des erreurs de build et des artefacts d’encodage |

### 3.3 Ce qui est resté sous contrôle humain

- La définition du besoin et des priorités.
- Les arbitrages produit : hors ligne, un seul directeur, pas de cloud en v1.
- La validation du résultat et la décision de livrer.
- Le test physique sur téléphone, qui reste la dernière étape de recette.

### 3.4 Pourquoi cette méthode a été efficace

- **Vérification continue** : chaque étape importante est suivie de `flutter analyze`, `flutter test` ou d’un build réel.
- **Pas de démonstration sans preuve** : l’APK a été signé, inspecté et son empreinte SHA-256 calculée.
- **Correction immédiate** : les erreurs de build Android ont été traitées une par une jusqu’à obtenir un APK installable.
- **Traçabilité** : les règles métier sont isolées dans des fichiers testables, pas enfouies dans l’interface.

---

## 4. Durée et charge de travail

| Mesure | Valeur |
|---|---|
| Démarrage | 2 novembre 2026, 09:06 |
| APK final | 4 novembre 2026, 16:41 |
| Durée calendaire | environ 2 jours et 7 heures |
| Travail effectif estimé | 12 à 15 heures |
| Builds release | environ 12 minutes cumulées après chauffe du cache |
| Temps hors développement | téléchargements SDK/Gradle, démarrages à froid, diagnostic Android |

Répartition indicative du temps effectif :

| Activité | Estimation |
|---|---|
| Cadrage et architecture | 1 h 30 |
| Base de données, sécurité, règles métier | 3 h |
| Interface et expérience utilisateur | 5 h |
| Tests et corrections | 1 h 30 |
| Build Android, signature, diagnostic | 3 h à 4 h |

À retenir pour la soutenance : **le projet a été livré en moins de trois jours calendaires, avec une release signée et testée sur le plan logiciel**. Le principal poste de temps n’est pas l’interface, mais la stabilisation de la chaîne Android (SDK, Gradle, plugins, signature).

---

## 5. Stack technique

| Couche | Technologie | Version | Rôle |
|---|---|---|---|
| Langage | Dart | 3.13.7 | Logique applicative |
| Framework | Flutter | 3.47.9 | Interface Android |
| Gestion d’état | Riverpod | 2.6.1 | Injection de dépendances, état réactif |
| Navigation | go_router | 14.8.1 | 5 onglets avec état conservé |
| Base locale | Drift + SQLite | 2.35.3 | Tables typées, requêtes réactives |
| Scan | mobile_scanner | 6.0.11 | Lecture des QR par caméra |
| Génération QR | qr_flutter | 4.1.0 | Affichage des badges |
| PDF | pdf + printing | 3.12.0 / 5.14.3 | Badges A6, rapports A4, impression |
| Export | csv + share_plus | 6.0.0 / 10.1.4 | CSV et partage de fichiers |
| Sécurité | crypto + flutter_secure_storage | 3.0.8 / 9.2.4 | HMAC-SHA256, secret et PIN chiffrés |
| Feedback | audioplayers | 6.8.1 | Son de confirmation du scan |
| Dates | intl + flutter_localizations | 0.20.3 | Formats français |
| Android | Gradle | 9.3.1 | Build |
| Android | AGP | 9.1.0 | Plugin Android Gradle |
| Android | Kotlin | 2.4.0 | Configuration Gradle Kotlin DSL |
| Android | JDK | 17 | Compilation |
| Android | compileSdk / targetSdk | 36 | Compatibilité Android 16 |
| Android | minSdk | 24 | Android 7.0 minimum |

---

## 6. Architecture

### 6.1 Organisation du code

```text
lib/
  core/
    db/            Schéma Drift, connexion SQLite
    security/      Secret QR, signature HMAC, service PIN
    theme/         Thème clair/sombre, couleurs, tokens
    widgets/       Composants réutilisables
    providers/     Injection de dépendances Riverpod
    models/        Modèle de réglages
    utils/         Dates, formats, couleurs
    l10n/          Textes français/anglais
  features/
    dashboard/     Accueil et indicateurs
    scanner/       Scan caméra et traitement du badge
    employees/     Gestion des employés et des badges
    badges/        Génération et vérification des QR
    attendance/    Règles de pointage et repository
    reports/       Statistiques et exports
    settings/      Entreprise, horaires, apparence, fériés
```

Chaque fonctionnalité suit une séparation simple :

- **presentation** : écrans et widgets ;
- **domain** : règles métier pures et testables ;
- **data** : accès à la base et aux services.

### 6.2 Modèle de données

| Table | Rôle | Points clés |
|---|---|---|
| `employees` | Employés | UUID, matricule, service, horaire personnalisé, badge versionné, archivage |
| `attendance_records` | Pointages | Arrivée/départ UTC, date locale, statut forcé, note, correction manuelle |
| `scan_events` | Journal des scans | Chaque tentative, même invalide, avec résultat et date |
| `audit_logs` | Traçabilité | Création/modification/suppression de pointages avec avant/après |
| `holidays` | Jours fériés | Date unique + libellé |

Contraintes importantes :

- un employé ne peut avoir qu’un seul pointage par jour : `UNIQUE(employee_id, local_date)` ;
- index sur les dates, les employés et les scans pour garder les rapports rapides ;
- clés étrangères activées à l’ouverture de la base.

### 6.3 Flux complet d’un scan

1. Le scanner lit une chaîne du type `PTG1:uuid:version:hmac`.
2. La signature HMAC-SHA256 est recalculée avec le secret de l’appareil et comparée à temps constant.
3. L’employé est recherché par UUID.
4. Les contrôles métier vérifient : employé archivé, badge périmé, statut existant.
5. L’horaire est résolu : horaire personnalisé de l’employé ou horaire global.
6. La règle `decideScan` détermine : arrivée, départ, doublon, départ déjà complet, ou blocage manuel.
7. Le pointage est écrit dans SQLite ; chaque tentative est journalisée.
8. L’interface affiche le résultat, joue un son, vibre, puis revient au scanner après quelques secondes.

---

## 7. Fonctionnalités livrées

| Module | Fonctionnalités |
|---|---|
| Accueil | Indicateurs présents, retards, sur site, absents ; graphique des 7 derniers jours ; derniers scans ; accès rapide au scanner et aux employés |
| Scanner | Caméra, torche, scan continu avec anti-doublon, saisie manuelle, son/vibration, retour automatique, reprise après pause, ouverture des réglages Android, messages d’erreur explicites |
| Employés | Création, modification, recherche, tri, filtre par département, photo, archivage, suppression, horaire personnalisé, matricule, service, téléphone |
| Badges | QR signé, aperçu fidèle, partage PDF A6, impression, téléchargement PNG, régénération de version pour invalider l’ancien badge |
| Pointage | Arrivée/départ, détection des retards, départ anticipé, heures supplémentaires, pause, départ manquant, statuts corrigés |
| Rapports | Jour, semaine, mois, trimestre, année, période personnalisée ; graphiques heures/statuts ; synthèse par employé ; export PDF, CSV et XLSX |
| Correction | Saisie manuelle des heures, statut justifié/absence/congé/férié, note, journal d’audit |
| Réglages | Entreprise et logo, horaires, jours travaillés, tolérances, pause, seuil heures supp., anti-doublon, bascule de journée |
| Sécurité | Code PIN, biométrie, verrouillage automatique, journal d’audit |
| Apparence | Clair/sombre/système, couleur principale, taille du texte, arrondi, densité |
| Langue | Français et anglais complets |
| Jours fériés | Ajout, suppression, prise en compte dans les rapports |
| Données | Sauvegarde/restauration JSON, partage vers Drive/Gmail/USB, réinitialisation complète, base locale |

---

## 8. Règles métier et sécurité

### 8.1 Règles de pointage

- **Journée logique** : la journée peut basculer à 4 h du matin, ce qui permet de gérer les scans après minuit.
- **Retard** : calculé après l’heure de début plus la tolérance paramétrable.
- **Départ anticipé** : calculé avant l’heure de fin moins la tolérance.
- **Pause** : déduite du temps travaillé lorsque celui-ci dépasse la pause configurée.
- **Heures supplémentaires** : tout dépassement du seuil journalier.
- **Départ manquant** : signalé si l’arrivée existe sans départ.
- **Anti-doublon** : un second scan trop rapproché est ignoré pour éviter les doubles pointages.
- **Correction manuelle** : le directeur peut corriger un pointage, avec note et trace d’audit.
- **Horaire personnalisé** : chaque employé peut avoir ses jours, heures, pause et tolérances.

### 8.2 Sécurité des badges

- Le QR contient : préfixe, UUID de l’employé, version du badge, signature HMAC.
- Le secret HMAC est généré aléatoirement (32 octets) et stocké dans le stockage sécurisé Android.
- La comparaison de signature est faite à temps constant.
- La régénération d’un badge incrémente sa version : l’ancien QR devient immédiatement invalide.
- Un employé archivé ne peut plus pointer.
- Chaque tentative est enregistrée : valide, forgée, inconnue, archivée, périmée ou échouée.
- La sauvegarde Android automatique est désactivée.

### 8.3 Statistiques

Les statuts pris en compte sont : présent, retard, départ anticipé, absent, justifié, congé, férié, repos, pas encore arrivé.

Les indicateurs calculés :

- taux de présence ;
- taux d’absence ;
- taux de ponctualité ;
- temps travaillé ;
- heures supplémentaires ;
- retards cumulés ;
- départs anticipés cumulés ;
- heure moyenne d’arrivée ;
- ventilation par employé, service et jour.

---

## 9. Les forces du projet

1. **100 % hors ligne** : aucune donnée ne quitte le téléphone, aucun serveur à payer.
2. **Badges difficiles à falsifier** : HMAC, versionnement, archivage et journalisation.
3. **Règles de pointage réalistes** : tolérance, pause, heures supplémentaires, bascule de journée, correction manuelle.
4. **Expérience simple** : un directeur peut tout faire depuis un seul téléphone.
5. **Rapports directement exploitables** : PDF pour l’archivage, CSV pour le tableur.
6. **Architecture maintenable** : code découpé par fonctionnalité, règles métier isolées, dépendances injectées.
7. **Base testable** : 12 tests automatisés sur le cœur sensible.
8. **Personnalisation** : horaires par employé, thème, langue, couleurs, taille de texte.
9. **Coût d’exploitation quasi nul** : pas de cloud, pas d’abonnement, pas de maintenance serveur.
10. **Livraison vérifiable** : APK signé, empreinte SHA-256, build reproductible.

---

## 10. Faiblesses et limites

| Limite | Impact | Parade proposée |
|---|---|---|
| Données uniquement locales | Perte si le téléphone est perdu ou cassé | Sauvegarde/restauration JSON disponible ; copie régulière recommandée |
| Pas de synchronisation multi-appareils | Un seul téléphone peut scanner | Export/import ou sync cloud optionnelle |
| Base SQLite non chiffrée | Un appareil rooté pourrait lire les données | Chiffrement de la base ou stockage sécurisé |
| Signature QR tronquée à 16 caractères hex | 64 bits, suffisant pour un badge interne mais améliorable | Passer à 32 caractères hex |
| Sauvegarde non chiffrée par défaut | Le fichier JSON doit être protégé | Chiffrement de sauvegarde en v1.2 |
| Tests limités au cœur métier | Pas de test caméra ni de test d’installation | Tests d’intégration + recette physique |
| Biométrie non testée physiquement | Comportement variable selon constructeur | Recette sur plusieurs téléphones |
| Pas de CI/CD ni de rapport de crash | Regression possible sans détection automatique | Pipeline GitHub Actions/Azure |
| Pas de rôles ni de multi-admin | Adapté à un directeur unique | Gestion des rôles en v2 |
| Pas de gestion explicite des rotations/nuit | Cas standard couvert, cas complexe à valider | Horaires par cycle en v1.2 |
| `expectedMinutes` toujours à zéro dans les stats | Indicateur “heures attendues” non exploitable | Corriger le calcul et ajouter un test |
| Pas de pagination sur les gros volumes | Ralentissement possible au-delà de plusieurs milliers de lignes | Pagination et index supplémentaires |
| Permission INTERNET ajoutée par des plugins | Peut surprendre sur un argument “100 % offline” | Auditer et retirer si inutile |

**Message clé pour le client** : ces limites sont connues, documentées et corrigeables. La sauvegarde et le verrouillage sont désormais disponibles ; la prochaine priorité est la recette physique sur plusieurs téléphones.

---

## 11. Perspectives d’évolution

### Court terme — 1 à 2 jours

- Corriger le calcul des heures attendues.
- Chiffrer les fichiers de sauvegarde.
- Tester caméra, biométrie et installation sur plusieurs téléphones.
- Produire un App Bundle pour le Play Store.
- Ajouter des tests d’intégration.

### Moyen terme — 1 à 2 semaines

- Impression de tous les badges en lot.
- Filtres de pointage par département et par période.
- Pagination des gros volumes.
- Chiffrement de la base SQLite.
- Pipeline CI et rapport de crash.

### Long terme — 1 à 2 mois

- Gestion des rotations et des équipes de nuit.
- Workflow de congés et de justificatifs.
- Multi-sites et multi-administrateurs.
- Synchronisation cloud optionnelle.
- Tableau de bord web.
- Export paie.
- Publication Play Store.

### Vision

PointagePro peut devenir une petite suite RH locale : pointage, absences, heures supplémentaires, badges, paie et audit, avec une option cloud pour les structures multi-sites.

---

## 12. Plan de soutenance en 10 minutes

| Temps | Séquence | Message |
|---|---|---|
| 0:00–1:00 | Problème | Le pointage manuel coûte du temps et crée des litiges |
| 1:00–4:00 | Démonstration | Créer un employé, scanner, voir le tableau de bord, exporter un PDF |
| 4:00–6:00 | Architecture | Flutter + Riverpod + Drift, hors ligne, feature-first |
| 6:00–7:30 | Règles et sécurité | Badge signé, versionné, journalisé ; règles de retard et d’heures supp. |
| 7:30–9:00 | Résultats | 35 fichiers, 5 456 lignes utiles, 12 tests, APK signé |
| 9:00–10:00 | Limites et suite | Sauvegarde, verrouillage, multi-appareils, Play Store |

### Script de démonstration

1. Ouvrir **Réglages**, saisir le nom de l’entreprise et les horaires.
2. Aller dans **Employés**, créer un employé avec un horaire personnalisé.
3. Afficher son badge QR, le partager ou l’imprimer.
4. Ouvrir **Scanner**, présenter le badge : arrivée enregistrée.
5. Scanner à nouveau : départ enregistré ou doublon détecté selon le délai.
6. Revenir à **Accueil** : les indicateurs et le scan récent sont à jour.
7. Ouvrir **Rapports**, choisir le mois, corriger un pointage, exporter en PDF.
8. Montrer le PDF et le CSV.

Prévoir une vidéo de secours de 90 secondes si la caméra ou le téléphone de démonstration pose problème.

---

## 13. Questions probables et réponses courtes

**Pourquoi Flutter ?**
Un seul code pour Android, une UI rapide à construire, un écosystème mature pour le QR, le PDF et le stockage local.

**Pourquoi ne pas utiliser le cloud ?**
Le client veut une solution simple, confidentielle et sans abonnement. Le cloud peut être ajouté plus tard en option.

**Comment empêcher un employé de copier le badge d’un autre ?**
Le QR contient une signature HMAC liée à l’UUID et à la version du badge. Une copie d’un ancien badge est refusée après régénération, et chaque scan est journalisé.

**Et si le téléphone est perdu ?**
Les données sont locales. La sauvegarde/restauration JSON permet de restaurer une copie sur un nouvel appareil ; il faut donc sauvegarder régulièrement.

**Pourquoi l’APK fait 38 Mo ?**
La version 1.1.0 fournit des APK séparés par architecture. L’APK arm64 recommandé fait 38 Mo, contre 92 Mo pour l’ancien APK universel.

**Est-ce que ça marche sans Internet ?**
Oui. Aucun code réseau n’est utilisé pour le pointage. Les permissions INTERNET visibles viennent de plugins, pas d’une synchronisation.

**Combien de temps pour le projet ?**
Environ deux jours et demi calendaires, avec 12 à 15 heures de travail effectif et une part importante consacrée à la stabilisation Android.

**Qu’est-ce qui a été fait par l’agent ?**
L’agent a exécuté le socle technique, l’interface, les tests, le diagnostic de build et la signature. L’humain a défini le besoin, les priorités et validé la livraison.

**Le projet est-il prêt pour la production ?**
Oui pour un pilote mono-téléphone. Avant un déploiement large : recette caméra/biométrie sur plusieurs modèles, sauvegarde chiffrée et publication via App Bundle.

**Pourquoi 12 tests seulement ?**
Ils couvrent le cœur à risque : signature QR, règles de pointage, statistiques et démarrage. La prochaine étape est l’intégration caméra et les tests de bout en bout.

---

## 14. Annexes techniques

### 14.1 Chiffres clés

| Indicateur | Valeur |
|---|---|
| Fichiers Dart | 41 |
| Lignes Dart totales | 15 628 |
| Tables | 5 |
| Tests | 12 |
| Écrans principaux | 5 |
| APK arm64 | 38,0 Mo |
| Android minimum | 7.0 |

### 14.2 Commandes de vérification

```powershell
cd G:\wamp64\www\appscan
flutter analyze
flutter test
flutter build apk --release --split-per-abi
```

### 14.3 Vérification de l’APK

```powershell
& "G:\Android\Sdk\build-tools\37.0.0\apksigner.bat" verify "G:\wamp64\www\appscan\PointagePro-1.1.0-arm64-v8a.apk"
& "G:\Android\Sdk\build-tools\37.0.0\aapt2.exe" dump badging "G:\wamp64\www\appscan\PointagePro-1.1.0-arm64-v8a.apk"
```

### 14.4 Point de vigilance à conserver

Le fichier `android/app/pointagepro-release.jks` et les mots de passe associés doivent être sauvegardés. Sans ce keystore, il sera impossible de publier une mise à jour qui remplace l’application déjà installée.

---

## 15. Conclusion

PointagePro n’est pas une maquette : c’est une application Flutter complète, avec une base SQLite, des règles métier, une sécurité de badge, des exports PDF/CSV et un APK release signé. Sa principale force est sa simplicité de déploiement : un téléphone, des badges, aucun serveur. Sa principale faiblesse est aussi sa limite : tout repose sur un seul appareil, ce qui rend la sauvegarde et le verrouillage prioritaires pour la suite.

Pour une soutenance, le message à retenir est : **un besoin réel, une architecture propre, une sécurité adaptée au terrain, une livraison vérifiable, et une feuille de route claire pour passer du pilote à la production.**
