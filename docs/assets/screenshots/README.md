# Captures d’écran — PointagePro 1.1.0

Déposer ici les captures réelles de l’application, au format PNG, en portrait.

| Fichier attendu | Écran |
|---|---|
| `01-tableau-de-bord.png` | Accueil / tableau de bord |
| `02-scan-camera.png` | Scanner un badge QR |
| `03-rapports.png` | Rapports et exports |
| `04-employes-badges.png` | Employés et badges |
| `05-configuration.png` | Réglages de l’entreprise |
| `06-verrouillage.png` | Sécurité / verrouillage |

## Intégration dans la fiche technique

1. Déposer les six fichiers ci-dessus dans ce dossier.
2. Remplacer les blocs `Capture à insérer` dans `docs/FICHE_TECHNIQUE.md` par les images.
3. Régénérer `docs/FICHE_TECHNIQUE.pdf`.
4. Vérifier le rendu, puis pousser les fichiers et le PDF.

## Lien de la vidéo

Le lien de démonstration se place dans `docs/FICHE_TECHNIQUE.md`, section **8. Liens utiles**, ligne **Vidéo de démonstration**. Utiliser une URL YouTube, Drive ou équivalent ; ne pas versionner un fichier vidéo volumineux.

## Commandes Git après mise à jour

```powershell
git add docs/assets/screenshots docs/FICHE_TECHNIQUE.md docs/FICHE_TECHNIQUE.pdf
git commit -m "docs: add application screenshots"
git push
```

Pour la vidéo seule :

```powershell
git add docs/FICHE_TECHNIQUE.md docs/FICHE_TECHNIQUE.pdf
git commit -m "docs: add demo video link"
git push
```
