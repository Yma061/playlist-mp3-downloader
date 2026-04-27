# Playlist Manager

Application Windows avec interface graphique pour télécharger et gérer des playlists musicales, avec un serveur Wi-Fi intégré pour synchroniser avec le mobile.

## Téléchargement

Dernière version : **v2.0.0**  
**[⬇ Télécharger PlaylistManager.exe](https://github.com/Yma061/playlist-mp3-downloader/releases/download/v2.0.0/PlaylistManager.exe)**

> Windows uniquement — aucune installation requise, double-cliquez pour lancer.

### ⚠️ Avertissement Windows au premier lancement

Windows peut afficher un message de sécurité car le fichier n'est pas signé par un éditeur certifié. C'est normal pour une application indépendante.

**Pour lancer l'application :**

1. Clique sur **"Informations complémentaires"**
2. Clique sur **"Exécuter quand même"**

Au premier lancement, une invite UAC apparaît pour autoriser le port 8888 dans le pare-feu — clique **Oui** une seule fois, c'est permanent.

---

## Fonctionnalités

### 🎵 Streaming → YouTube
Importe une playlist depuis ta plateforme préférée dans ta bibliothèque YouTube.

| Plateforme | API requise | Compte développeur |
|---|---|---|
| Deezer | Non | Non |
| Spotify | Non | Non |
| SoundCloud | Non | Non |
| Apple Music | Non | Non |

- Connexion Google intégrée — une fenêtre s'ouvre dans le navigateur au premier lancement
- Reprise automatique si la limite quotidienne de l'API est atteinte
- Limite : ~66 titres/jour (quota Google de 10 000 unités/jour)

### ▶ YouTube → MP3
Télécharge une playlist YouTube complète et convertit chaque vidéo en MP3 (192 kbps).
- Fichiers sauvegardés dans `~/PlaylistManager/`, immédiatement disponibles sur mobile

### 📊 Excel → MP3
Télécharge des musiques dans l'ordre défini dans un fichier Excel.
- Détection automatique des feuilles, choix de la colonne et de la première ligne de données
- Fichier `non_trouves.txt` généré si des titres n'ont pas été trouvés

### 📱 Synchronisation mobile (serveur Wi-Fi intégré)
Un serveur web démarre automatiquement sur `http://localhost:8888` au lancement de l'app.
- Clique sur le grand bouton **"📱 Télécharger sur mobile"** pour ouvrir l'interface web
- Affiche ta bibliothèque et l'adresse IP à entrer sur le téléphone
- Supprime des playlists directement depuis l'interface web
- L'app Android détecte automatiquement le serveur sur le même Wi-Fi

---

## Interface

- Thème clair / sombre
- Langue FR / EN
- Barre de progression avec estimation du temps restant
- Historique des derniers téléchargements
- Ouverture du dossier de sortie en un clic
- Notification sonore à la fin de chaque traitement

---

## Utilisation

### YouTube → MP3
1. Clique sur **YouTube → MP3**
2. Colle l'URL de la playlist YouTube
3. Clique sur **Lancer** — les MP3 sont sauvegardés dans `~/PlaylistManager/`
4. Clique sur **📱 Télécharger sur mobile** pour synchroniser avec ton téléphone

---

## Installation depuis les sources

```bash
pip install -r requirements.txt
python interface.py
```

### Build .exe

```bash
pyinstaller PlaylistManager.spec
```

---

## Technologies

Python · Tkinter · yt-dlp · FastAPI · uvicorn · spotdl · Deezer API · Spotify · SoundCloud · Apple Music · YouTube Data API v3 · openpyxl · keyring · PyInstaller
