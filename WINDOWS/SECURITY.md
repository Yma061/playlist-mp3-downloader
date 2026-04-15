# Security Policy

## Versions supportées

| Version | Support sécurité |
|---------|-----------------|
| 1.2.x   | ✅ Supportée     |
| 1.1.x   | ⚠️ Correctifs critiques uniquement |
| < 1.1   | ❌ Non supportée |

## Signaler une vulnérabilité

Si vous découvrez une faille de sécurité dans cette application, **ne créez pas d'issue publique**.

Envoyez un rapport privé via :
- **GitHub** : [Security Advisories](https://github.com/Yma061/playlist-mp3-downloader/security/advisories/new)

### Informations à inclure

- Description de la vulnérabilité
- Étapes pour reproduire le problème
- Impact potentiel
- Version de l'application concernée

## Ce qui est hors périmètre

- Extraction du `client_secret.json` depuis le `.exe` — limitation connue et documentée de PyInstaller pour les applications desktop OAuth. Le secret d'une application de bureau n'est pas considéré comme confidentiel selon la spécification OAuth 2.0.
- Problèmes liés à des dépendances tierces (yt-dlp, spotdl, etc.) — signalez-les directement à leurs mainteneurs.

## Délai de réponse

Les rapports de sécurité seront traités sous **7 jours**.
