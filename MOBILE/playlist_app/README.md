# Playlist Manager — App Flutter (Android)

Application mobile Flutter pour écouter hors-ligne les playlists synchronisées depuis le serveur desktop.

## Téléchargement

**[⬇ Télécharger l'APK v2.0.0](https://github.com/Yma061/playlist-mp3-downloader/releases/download/v2.0.0/app-release.apk)**

---

## Fonctionnalités

- Sync Wi-Fi avec le serveur desktop (détection mDNS automatique ou IP manuelle)
- Interface style Spotify : playlist → liste des titres → lecteur plein écran
- Lecteur avec slider de progression, prev/pause/next
- Mini-player cliquable en bas de l'écran
- Lecture **100% hors-ligne** une fois synchronisé
- Thème clair / sombre

---

## Lancer depuis les sources

```bash
cd MOBILE/playlist_app
flutter pub get
flutter run
```

## Build APK

```bash
flutter build apk --release
```

L'APK se trouve dans `build/app/outputs/flutter-apk/app-release.apk`

---

## Technologies

Flutter · Dart · audioplayers · multicast_dns · path_provider · shared_preferences
