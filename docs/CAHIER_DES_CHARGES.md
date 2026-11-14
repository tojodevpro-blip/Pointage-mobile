# Cahier des charges — PointagePro

**Application Android de pointage par badges QR, hors ligne**

| Élément | Valeur |
|---|---|
| Document | Cahier des charges fonctionnel et technique |
| Version du document | 1.0 |
| Version applicative concernée | 1.1.0 |
| Date | 5 novembre 2026 |
| Statut | Référence pour le pilote mono-téléphone |
| Package Android | `com.pointagepro.pointagepro` |
| Diffusion | Client, équipe projet, soutenance |

> **Note de version.** Le fichier `PointagePro_Soutenance.pdf` présente la version 1.0.0. Le présent cahier des charges décrit la version 1.1.0 réellement livrée, qui ajoute notamment le verrouillage, la sauvegarde, les photos, les graphiques, l’export Excel et les APK allégés par architecture.

---

## 1. Contexte

Les petites structures gèrent souvent le pointage avec un registre papier ou un tableur. Cette méthode entraîne des oublis, des erreurs de calcul, des litiges sur les horaires et une faible traçabilité. Les solutions cloud imposent souvent un abonnement, une connexion Internet et la transmission de données personnelles.

PointagePro répond à ce besoin avec une application Android locale : un téléphone, des badges QR et aucun serveur obligatoire.

---

## 2. Objectifs

### 2.1 Objectif général

Fournir au directeur d’une PME un outil simple, fiable et autonome pour enregistrer les arrivées et départs, calculer les retards et les heures, puis produire des rapports exploitables.

### 2.2 Objectifs spécifiques

- Réduire le temps de pointage à un geste : scanner un badge.
- Supprimer les ressaisies et les calculs manuels.
- Fonctionner sans Internet et sans compte utilisateur.
- Limiter la fraude par des badges signés, versionnés et journalisés.
- Conserver les données sur l’appareil et permettre leur sauvegarde.
- Fournir des exports PDF, CSV et XLSX directement utilisables.

### 2.3 Indicateurs de réussite

| Indicateur | Cible |
|---|---|
| Pointage d’un employé | Un scan valide suffit |
| Connexion réseau nécessaire au pointage | Aucune |
| Perte de données en cas d’erreur de scan | Aucune : chaque tentative est journalisée |
| Rapport de période | PDF, CSV et XLSX disponibles |
| Qualité logicielle | `flutter analyze` sans erreur, 12 tests passants |
| Livraison | APK release signé et vérifié |

---

## 3. Périmètre

### 3.1 Inclus

- Application Android native Flutter, en français et en anglais.
- Gestion des employés, de leurs horaires et de leurs badges QR.
- Scan caméra, saisie manuelle de secours et retour utilisateur.
- Calcul des arrivées, départs, retards, départs anticipés, pauses et heures supplémentaires.
- Tableau de bord du jour et rapports par période.
- Corrections manuelles avec note et journal d’audit.
- Exports PDF, CSV et XLSX.
- Verrouillage par code PIN et biométrie.
- Sauvegarde et restauration des données par fichier JSON.
- Jours fériés, thème, langue et personnalisation de l’interface.

### 3.2 Hors périmètre de la version 1.1.0

- Comptes multiples, rôles et gestion de plusieurs administrateurs.
- Synchronisation cloud automatique et usage simultané sur plusieurs téléphones.
- Application web ou tableau de bord distant.
- Workflow de demande et de validation des congés.
- Calcul de paie et bulletins de salaire.
- Publication Play Store et App Bundle.
- Chiffrement de la base SQLite.
- Sauvegarde automatique planifiée.
- Versions iOS, web ou bureau.
- Pointeuse physique, NFC ou reconnaissance faciale.

---

## 4. Acteurs et rôles

| Acteur | Rôle | Accès |
|---|---|---|
| Directeur / responsable | Utilisateur principal : configure, gère les employés, scanne, corrige et exporte | Toutes les fonctions |
| Employé | Porte son badge QR | Aucun compte dans l’application |
| Comptable / gestionnaire | Reçoit et exploite les exports | PDF, CSV ou XLSX fournis par le directeur |
| Mainteneur | Installe, sauvegarde, met à jour et dépanne | APK, documentation, keystore |

L’application est conçue pour **un directeur unique sur un seul téléphone**.

---

## 5. Hypothèses et contraintes

- Android 7.0 minimum, API cible 36.
- Téléphone avec caméra fonctionnelle pour le scan.
- Un seul appareil actif à la fois.
- Cible de 5 à 200 employés par entreprise.
- Les badges peuvent être imprimés ou affichés à l’écran.
- Aucun serveur, aucune API distante et aucun compte en ligne.
- Les exports et sauvegardes ne quittent l’appareil que sur action explicite de l’utilisateur.
- Le téléphone et le keystore de signature doivent être sauvegardés par le responsable.

---

## 6. Exigences fonctionnelles

Priorités : **M** = obligatoire, **S** = souhaitable.

| ID | Module | Exigence | Priorité |
|---|---|---|---|
| F-01 | Configuration | L’utilisateur peut renseigner le nom, l’adresse, le téléphone, l’e-mail et le logo de l’entreprise. | M |
| F-02 | Configuration | Les horaires globaux, jours travaillés, tolérance de retard, tolérance de départ anticipé, pause, seuil d’heures supplémentaires, anti-doublon et bascule de journée sont paramétrables. | M |
| F-03 | Employés | Créer, modifier, rechercher, trier, archiver et supprimer un employé. | M |
| F-04 | Employés | Renseigner identité, matricule, poste, département, téléphone, date d’embauche et photo. | M |
| F-05 | Employés | Filtrer la liste par département et afficher les employés actifs ou archivés. | S |
| F-06 | Horaires | Définir un horaire personnalisé par employé, sinon appliquer l’horaire global. | M |
| F-07 | Badges | Générer automatiquement un badge QR signé pour chaque employé. | M |
| F-08 | Badges | Afficher un aperçu fidèle, partager ou imprimer le badge en PDF A6 et télécharger le PNG. | M |
| F-09 | Badges | Régénérer un badge pour incrémenter sa version et invalider immédiatement l’ancien QR. | M |
| F-10 | Scan | Scanner un QR avec la caméra, activer la torche et gérer la permission caméra. | M |
| F-11 | Scan | Empêcher les doubles scans dans une fenêtre paramétrable et ignorer les scans trop rapprochés. | M |
| F-12 | Scan | Proposer une saisie manuelle de secours si la caméra ou le badge est indisponible. | M |
| F-13 | Scan | Afficher le résultat, jouer un son, vibrer et revenir automatiquement au scanner. | M |
| F-14 | Pointage | Enregistrer automatiquement l’arrivée au premier scan valide et le départ au scan suivant. | M |
| F-15 | Pointage | Calculer retard, départ anticipé, temps travaillé, pause, heures supplémentaires et départ manquant. | M |
| F-16 | Pointage | Refuser et journaliser un badge forgé, inconnu, archivé, périmé ou invalide. | M |
| F-17 | Correction | Corriger manuellement les heures et choisir un statut : justifié, absence, congé ou férié, avec note. | M |
| F-18 | Accueil | Afficher présents, retards, personnes sur site, absents, activité des 7 derniers jours et derniers scans. | M |
| F-19 | Rapports | Consulter les rapports du jour, de la semaine, du mois, du trimestre, de l’année ou d’une période libre. | M |
| F-20 | Rapports | Afficher taux de présence, ponctualité, heures travaillées, heures supplémentaires et ventilation par employé. | M |
| F-21 | Rapports | Exporter la synthèse en PDF, CSV et XLSX. | M |
| F-22 | Jours fériés | Ajouter et supprimer des jours fériés, pris en compte dans les rapports. | M |
| F-23 | Sécurité | Activer un code PIN de 4 à 6 chiffres, la biométrie si disponible et un verrouillage automatique. | M |
| F-24 | Données | Exporter toutes les données dans un fichier JSON et restaurer ce fichier. | M |
| F-25 | Audit | Consulter le journal des modifications de pointage. | M |
| F-26 | Données | Réinitialiser l’application après confirmation explicite. | M |
| F-27 | Apparence | Choisir thème clair, sombre ou système, couleur principale et taille de texte. | S |
| F-28 | Langue | Utiliser l’interface en français ou en anglais et conserver le choix. | M |
| F-29 | Navigation | Accéder aux cinq écrans principaux : Accueil, Scanner, Employés, Rapports, Réglages. | M |
| F-30 | Fonctionnement | Toutes les fonctions de pointage et de rapport doivent fonctionner sans réseau. | M |

---

## 7. Règles métier

| Règle | Description |
|---|---|
| Journée logique | La date de pointage bascule à une heure paramétrable, par défaut 4 h du matin, pour gérer les scans après minuit. |
| Un pointage par jour | Un employé ne peut avoir qu’un seul enregistrement de pointage par journée logique. |
| Arrivée | Le premier scan valide de la journée enregistre l’arrivée. |
| Départ | Le scan suivant, hors fenêtre anti-doublon, enregistre le départ. |
| Doublon | Un scan survenant dans la fenêtre anti-doublon, par défaut 2 minutes, est refusé et journalisé. |
| Retard | Un employé est en retard lorsque son arrivée dépasse l’heure de début augmentée de la tolérance. |
| Départ anticipé | Un départ est anticipé lorsqu’il précède l’heure de fin diminuée de la tolérance. |
| Pause | La pause paramétrée est déduite du temps travaillé lorsque celui-ci dépasse sa durée. |
| Heures supplémentaires | Le temps dépassant le seuil journalier configuré est comptabilisé en heures supplémentaires. |
| Départ manquant | Une arrivée sans départ est signalée comme départ manquant. |
| Horaire personnalisé | L’horaire de l’employé prévaut sur l’horaire global lorsqu’il est activé. |
| Correction manuelle | Une correction est possible avec un motif ; elle est tracée dans le journal d’audit. |
| Statuts | Présent, retard, départ anticipé, absent, justifié, congé, férié, repos et pas encore arrivé. |
| Badge valide | Le préfixe, l’UUID, la version et la signature HMAC doivent correspondre aux données de l’appareil. |
| Révocation | La régénération d’un badge invalide l’ancien QR sans supprimer l’historique. |
| Archivage | Un employé archivé ne peut plus pointer, mais son historique reste consultable. |

---

## 8. Exigences non fonctionnelles

| ID | Domaine | Exigence |
|---|---|---|
| NF-01 | Disponibilité | Le pointage, les rapports et les exports doivent fonctionner sans Internet. |
| NF-02 | Performance | L’ouverture de l’application et l’affichage des écrans principaux doivent rester fluides sur un téléphone Android 7 ou supérieur. |
| NF-03 | Fiabilité | Chaque tentative de scan doit produire un résultat traçable, même en cas de refus. |
| NF-04 | Compatibilité | Prise en charge d’Android 7.0 à Android 16, avec APK arm64, armv7 et x86_64. |
| NF-05 | Sécurité | Secret HMAC stocké dans le stockage sécurisé Android, jamais dans la base. |
| NF-06 | Sécurité | Signature HMAC-SHA256 et comparaison à temps constant. |
| NF-07 | Sécurité | Code PIN dérivé avec sel et itérations, jamais stocké en clair. |
| NF-08 | Confidentialité | Aucune transmission automatique de données ; les exports sont déclenchés par l’utilisateur. |
| NF-09 | Ergonomie | Interface lisible, navigation à cinq onglets, actions principales accessibles en un geste. |
| NF-10 | Accessibilité | Taille de texte réglable, contraste soigné, libellés explicites et retour visuel. |
| NF-11 | Internationalisation | Interface et exports disponibles en français et en anglais. |
| NF-12 | Maintenabilité | Architecture feature-first, règles métier isolées et testables. |
| NF-13 | Qualité | `flutter analyze` sans erreur et tests automatisés passants avant livraison. |
| NF-14 | Déploiement | APK release signé, versionné et vérifiable par empreinte SHA-256. |
| NF-15 | Volume | L’application doit rester utilisable pour quelques centaines d’employés et plusieurs années de pointages. |

---

## 9. Sécurité et confidentialité

### 9.1 Protection des badges

- Le QR contient un préfixe, un UUID opaque, la version du badge et une signature HMAC.
- Le QR ne contient aucune donnée personnelle en clair.
- Le secret HMAC est aléatoire, stocké dans le stockage sécurisé Android et jamais sauvegardé dans la base.
- La signature est recalculée puis comparée à temps constant.
- Chaque régénération de badge incrémente sa version et révoque l’ancien QR.
- Les tentatives refusées sont enregistrées : forgé, inconnu, archivé, périmé ou échec.

### 9.2 Protection de l’application

- Code PIN de 4 à 6 chiffres avec sel et dérivation par itérations.
- Déverrouillage biométrique si l’appareil le permet.
- Verrouillage automatique après un délai paramétrable.
- Journal d’audit des corrections de pointage.

### 9.3 Protection des données

- Données stockées localement dans SQLite.
- Sauvegarde JSON manuelle, partageable vers Drive, Gmail ou USB.
- La sauvegarde n’est pas chiffrée par défaut : le fichier doit être protégé.
- La sauvegarde JSON contient les données et les paramètres, mais pas les fichiers image ni le secret HMAC.
- Après restauration sur un autre appareil, les photos et le logo doivent être réimportés et les badges régénérés.

---

## 10. Données et architecture

### 10.1 Modèle de données

| Table | Contenu | Contrainte clé |
|---|---|---|
| `employees` | Identité, coordonnées, photo, service, horaire, version de badge, archivage | UUID unique et version de badge |
| `attendance_records` | Arrivée, départ, date locale, fuseau, statut forcé, note, correction | Un enregistrement par employé et par date locale |
| `scan_events` | Chaque scan, payload, résultat, message, horodatage | Aucun scan silencieux |
| `audit_logs` | Entité, action, ancienne valeur, nouvelle valeur, date | Traçabilité des modifications |
| `holidays` | Date et libellé | Date unique |

### 10.2 Architecture logicielle

```text
lib/
  core/
    db/            SQLite et schéma Drift
    security/      HMAC, secret, PIN, verrouillage
    theme/         Thème et jetons de design
    widgets/       Composants partagés et graphiques
    providers/     Injection de dépendances Riverpod
    l10n/          Textes français et anglais
    models/        Réglages applicatifs
    utils/         Dates, formats et couleurs
  features/
    dashboard/     Accueil et indicateurs
    scanner/       Scan caméra et traitement
    employees/     Employés et badges
    badges/        Génération et vérification QR
    attendance/    Règles métier et repository
    reports/       Statistiques et exports
    settings/      Configuration, audit et sauvegarde
```

### 10.3 Choix techniques

| Domaine | Technologie |
|---|---|
| Framework | Flutter 3.47.9 / Dart 3.13.7 |
| État | Riverpod |
| Navigation | go_router |
| Base locale | Drift + SQLite |
| Scan | mobile_scanner |
| QR | qr_flutter |
| Graphiques | fl_chart |
| PDF | pdf + printing |
| Tableur | csv + excel |
| Sécurité | crypto + flutter_secure_storage + local_auth |
| Partage | share_plus + file_picker |
| Android | Gradle 9.3.1, AGP 9.1.0, JDK 17 |

---

## 11. Parcours utilisateur principal

1. **Configurer l’entreprise** : nom, logo, horaires, tolérances, sécurité.
2. **Créer un employé** : identité, service, photo et horaire si nécessaire.
3. **Générer le badge** : aperçu, PDF, impression, PNG ou partage.
4. **Scanner** : arrivée enregistrée, retour visuel et sonore.
5. **Scanner à nouveau** : départ enregistré ou doublon signalé.
6. **Consulter l’accueil** : indicateurs du jour et derniers scans.
7. **Corriger si besoin** : heures, statut et note, avec journal d’audit.
8. **Exporter** : PDF pour archiver, CSV ou XLSX pour analyser.
9. **Sauvegarder** : fichier JSON à conserver hors du téléphone.

---

## 12. Livrables

| Livrable | Contenu |
|---|---|
| Application | APK release signé, version 1.1.0 |
| APK recommandé | `PointagePro-1.1.0-arm64-v8a.apk` |
| APK secondaires | `PointagePro-1.1.0-armeabi-v7a.apk`, `PointagePro-1.1.0-x86_64.apk` |
| Code source | Projet Flutter complet |
| Tests | 12 tests automatisés |
| Documentation | `README.md`, `DOSSIER_PROJET.md`, `LIVRAISON.md`, présent cahier des charges |
| Preuves de livraison | Empreintes SHA-256, signature APK, métadonnées de version |
| Signature | Keystore `android/app/pointagepro-release.jks`, alias `pointagepro` |

### 12.1 Empreintes des APK

| APK | Taille | SHA-256 |
|---|---:|---|
| arm64-v8a | 38 004 393 octets | `9FA2A1AFAB0D7FEC83BB04E425A48DCF6AF6B4537100AC624CDE332335A51BA2` |
| armeabi-v7a | 34 480 413 octets | `317A2FA64AADB084C4C0DAFA0532146574064F8E95BF218C8B9B0C3759239804` |
| x86_64 | 40 560 289 octets | `110813A3C8BB4C1FF67969FCC083EDCB8B2C0A328363685A057742449F9869DA` |

---

## 13. Critères d’acceptation

| ID | Scénario | Résultat attendu | Statut |
|---|---|---|---|
| AC-01 | Enregistrer la configuration de l’entreprise | Les valeurs persistent après redémarrage | Validé logiciel |
| AC-02 | Créer un employé avec photo | L’employé apparaît dans la liste avec son badge | Validé logiciel |
| AC-03 | Scanner un badge valide | Une arrivée est enregistrée et confirmée | À valider sur appareil |
| AC-04 | Scanner à nouveau après le délai anti-doublon | Un départ est enregistré | À valider sur appareil |
| AC-05 | Scanner deux fois dans la fenêtre anti-doublon | Le doublon est refusé et journalisé | Validé logiciel |
| AC-06 | Scanner un badge régénéré | L’ancien badge est refusé et l’événement est tracé | Validé logiciel |
| AC-07 | Scanner un badge d’un employé archivé | Le scan est refusé et journalisé | Validé logiciel |
| AC-08 | Arriver après l’heure de début et la tolérance | Le pointage est marqué en retard avec le nombre de minutes | Validé logiciel |
| AC-09 | Corriger un pointage avec une note | Le rapport et le journal d’audit reflètent la correction | Validé logiciel |
| AC-10 | Exporter une période en PDF, CSV et XLSX | Les trois fichiers sont générés avec les mêmes totaux | Validé logiciel |
| AC-11 | Sauvegarder puis restaurer les données | Les données et paramètres sont restaurés | Validé logiciel |
| AC-12 | Activer le PIN et verrouiller l’application | L’accès exige le PIN ou la biométrie | À valider sur appareil |
| AC-13 | Utiliser l’application en mode avion | Le scan et les rapports fonctionnent | À valider sur appareil |
| AC-14 | Changer la langue et le thème | Le choix persiste après redémarrage | Validé logiciel |
| AC-15 | Réinitialiser l’application | Les données sont supprimées après confirmation | Validé logiciel |

**Recette finale** : l’acceptation complète nécessite un test physique sur au moins un téléphone Android réel, incluant caméra, biométrie, installation et redémarrage.

---

## 14. Phasage et charge

| Phase | Travail | Charge indicative |
|---|---|---|
| Cadrage | Besoin, règles, périmètre, choix hors ligne | 1 h 30 |
| Architecture | Socle Flutter, base, providers, thème | 1 h 30 |
| Métier | Pointage, statistiques, sécurité, tests | 3 h |
| Interface | Cinq écrans, badges, rapports, exports | 5 h |
| Qualité | Analyse, tests, corrections | 1 h 30 |
| Android et livraison | SDK, Gradle, signature, vérification APK | 3 h à 4 h |
| **Total** | **Travail effectif estimé** | **12 h à 15 h** |

Durée calendaire constatée : environ deux jours et demi.

---

## 15. Risques et parades

| Risque | Impact | Parade |
|---|---|---|
| Perte ou vol du téléphone | Perte des données locales | Code PIN, verrouillage automatique, sauvegarde JSON régulière |
| Caméra indisponible | Impossible de scanner | Saisie manuelle de secours et ouverture des réglages Android |
| Badge copié ou ancien badge réutilisé | Fraude au pointage | Signature HMAC, versionnement, archivage et journalisation |
| Panne ou incompatibilité Android | Application inutilisable | APK par architecture, tests sur plusieurs modèles |
| Perte du keystore | Impossibilité de mettre à jour l’application | Sauvegarde sécurisée du keystore et des mots de passe |
| Sauvegarde non chiffrée | Lecture du fichier par un tiers | Stockage protégé, chiffrement prévu en version ultérieure |
| Restauration sur un autre appareil | Photos absentes et badges invalides | Réimporter les images et régénérer les badges |
| Absence de recette physique | Défauts caméra ou biométrie non détectés | Test sur téléphone réel avant déploiement |
| Volume de données élevé | Ralentissement des rapports | Index, archivage et pagination prévue |

---

## 16. Limites connues de la version 1.1.0

- Un seul téléphone et un seul directeur.
- Pas de synchronisation automatique entre appareils.
- Pas de chiffrement de la base SQLite.
- Sauvegarde JSON non chiffrée.
- Fichiers photo et logo non inclus dans la sauvegarde.
- Secret HMAC non exporté : les badges doivent être régénérés après restauration sur un autre téléphone.
- Pas de workflow de congés ou de justificatifs.
- Pas de gestion avancée des équipes de nuit et des rotations.
- Pas de publication Play Store ni d’App Bundle.
- Validation caméra, biométrie et installation encore à effectuer sur appareil physique.

---

## 17. Évolutions prévues

### Court terme

- Recette physique sur plusieurs téléphones.
- Chiffrement des sauvegardes.
- Inclusion des images dans la sauvegarde.
- Correction du calcul des heures attendues.
- Tests d’intégration et pipeline CI.
- App Bundle pour le Play Store.

### Moyen terme

- Impression des badges en lot.
- Filtres de rapports par département.
- Pagination des gros volumes.
- Chiffrement de la base.
- Rapport de crash et supervision.

### Long terme

- Rotations et équipes de nuit.
- Congés et justificatifs.
- Multi-sites, rôles et multi-administrateurs.
- Synchronisation cloud optionnelle.
- Tableau de bord web.
- Export paie.

---

## 18. Maintenance et exploitation

- Conserver le keystore et ses mots de passe : sans eux, aucune mise à jour ne peut remplacer l’application installée.
- Sauvegarder les données avant toute réinstallation ou réinitialisation.
- Vérifier la version et l’empreinte SHA-256 avant diffusion.
- Tester chaque nouvelle version sur un téléphone réel.
- Ne pas modifier la base sans migration ni sauvegarde préalable.
- Documenter toute évolution dans `LIVRAISON.md` et `DOSSIER_PROJET.md`.

---

## 19. Annexes

### 19.1 Installation

1. Copier `PointagePro-1.1.0-arm64-v8a.apk` sur le téléphone.
2. Autoriser l’installation depuis cette source si Android le demande.
3. Lancer l’application et autoriser la caméra.
4. Si l’APK arm64 est refusé, utiliser `PointagePro-1.1.0-armeabi-v7a.apk`.

### 19.2 Commandes de vérification

```powershell
flutter analyze
flutter test
flutter build apk --release --split-per-abi
```

### 19.3 Glossaire

| Terme | Définition |
|---|---|
| APK | Paquet d’installation Android |
| ABI | Architecture processeur cible de l’APK |
| HMAC | Signature cryptographique garantissant l’authenticité du badge |
| Hors ligne | Fonctionnement sans connexion Internet |
| Journée logique | Période de travail pouvant commencer la veille et basculer après minuit |
| SQLite | Base de données locale intégrée à l’application |
| XLSX | Format de classeur Excel |

---

## 20. Validation

| Rôle | Nom | Date | Visa |
|---|---|---|---|
| Responsable projet |  |  |  |
| Client / directeur |  |  |  |
| Validation technique |  |  |  |

**Conclusion.** PointagePro 1.1.0 est une application complète et cohérente pour un pilote mono-téléphone. La livraison logicielle est vérifiée ; la dernière étape avant un déploiement réel est la recette physique sur un téléphone Android.
