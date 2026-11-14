# PointagePro — Livraison 1.1.0

## Fichiers APK
APK par architecture, pour un téléchargement plus léger :

| Architecture | Fichier | Taille | SHA-256 |
|---|---|---:|---|
| ARM 64 bits (recommandé) | `PointagePro-1.1.0-arm64-v8a.apk` | 38,0 Mo | `9FA2A1AFAB0D7FEC83BB04E425A48DCF6AF6B4537100AC624CDE332335A51BA2` |
| ARM 32 bits | `PointagePro-1.1.0-armeabi-v7a.apk` | 34,5 Mo | `317A2FA64AADB084C4C0DAFA0532146574064F8E95BF218C8B9B0C3759239804` |
| x86_64 (émulateur) | `PointagePro-1.1.0-x86_64.apk` | 40,6 Mo | `110813A3C8BB4C1FF67969FCC083EDCB8B2C0A328363685A057742449F9869DA` |

- Version : 1.1.0
- Package : `com.pointagepro.pointagepro`
- Android minimum : 7.0 (API 24), cible API 36
- Signature release : valide (keystore `android/app/pointagepro-release.jks`, alias `pointagepro`)
- Certificat : `CN=PointagePro`, RSA 2048 bits

## Installation
1. Copier l’APK **arm64-v8a** sur le téléphone (ou l’envoyer par WhatsApp/USB).
2. Ouvrir le fichier et autoriser l’installation depuis cette source si demandé.
3. Lancer PointagePro et autoriser la caméra au premier scan.
4. Si le téléphone refuse l’APK arm64, utiliser la version **armeabi-v7a**.

## Nouveautés 1.1.0
- **Verrouillage de l’application** : code PIN, biométrie et délai de verrouillage automatique.
- **Photo employé** : caméra ou galerie, affichée dans la liste, les scans et le badge.
- **Logo entreprise** : caméra ou galerie, repris dans les badges et l’écran de verrouillage.
- **Badge PNG** : téléchargement de l’aperçu exact du badge, en plus du PDF et de l’impression.
- **Graphiques** : activité des 7 derniers jours, heures par jour et répartition des statuts.
- **Export Excel** : rapport global en XLSX, en plus de PDF et CSV.
- **Sauvegarde / restauration** : export JSON de toutes les données, puis partage vers Drive, Gmail ou USB.
- **Journal d’audit** : consultation des modifications de pointage.
- **Filtre par département** dans la liste des employés.
- **Scanner fiabilisé** : redémarrage caméra, gestion de la reprise d’application, ouverture des réglages Android et saisie manuelle.
- **Anglais intégral** de l’interface, en plus du français.
- **APK allégé** : environ 38 Mo par architecture au lieu de 92 Mo pour l’ancien APK universel.

## Première utilisation
1. **Réglages** : nom de l’entreprise, logo, horaires, tolérances, puis **Enregistrer**.
2. **Sécurité** : activer un code PIN et, si disponible, la biométrie.
3. **Employés** : **Nouvel employé** → photo facultative → le badge QR est généré automatiquement → **Partager**, **Imprimer** ou **Télécharger PNG**.
4. **Scanner** : présenter le badge devant la caméra. Le son et la vibration confirment le pointage.
5. **Rapports** : choisir la période, consulter les graphiques, corriger un pointage, exporter en PDF, CSV ou XLSX.
6. **Données** : sauvegarder régulièrement vers un fichier, puis copier ce fichier sur Drive, Gmail ou une clé USB.

## Vérifications effectuées
- `flutter analyze` : aucune erreur, aucun avertissement.
- `flutter test` : 12 tests réussis (QR, pointage, statistiques, démarrage).
- `flutter build apk --release --split-per-abi` : 3 APK générés.
- Signature vérifiée avec `apksigner` : schéma v2 valide.
- Métadonnées vérifiées avec `aapt2` : version 1.1.0, package et permissions corrects.

## Limites connues
- Aucun téléphone Android n’était connecté pendant la validation : caméra, biométrie et installation réelle restent à tester sur appareil.
- La sauvegarde est un fichier JSON exportable, pas une synchronisation cloud automatique.
- L’application reste mono-appareil ; aucune synchronisation multi-téléphones n’est fournie.
