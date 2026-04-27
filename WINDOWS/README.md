# Playlist Manager

> 🇫🇷 [Version française disponible ici](README_FR.md)

A Windows GUI application to download and manage music playlists, with a built-in Wi-Fi server for mobile sync.

## Download

Latest version: **v2.0.0**  
**[⬇ Download PlaylistManager.exe](https://github.com/Yma061/playlist-mp3-downloader/releases/download/v2.0.0/PlaylistManager.exe)**

> Windows only — no installation required, just double-click to launch.

### ⚠️ Windows warning on first launch

Windows may display a security warning because the file is not signed by a certified publisher. This is normal for an independent application.

**To launch the application:**

1. Click **"More info"**
2. Click **"Run anyway"**

On first launch, a UAC prompt will appear to allow port 8888 through the firewall — click **Yes** once and it will never appear again.

---

## Features

### 🎵 Streaming → YouTube
Import a playlist from your favourite platform directly into your YouTube library.

| Platform | API required | Developer account |
|---|---|---|
| Deezer | No | No |
| Spotify | No | No |
| SoundCloud | No | No |
| Apple Music | No | No |

- Built-in Google sign-in — a browser window opens on first launch
- Automatic resume if the daily API quota is reached
- Limit: ~66 tracks/day (Google quota of 10,000 units/day)

### ▶ YouTube → MP3
Download a full YouTube playlist and convert each video to MP3 (192 kbps).
- Files saved to `~/PlaylistManager/` and immediately available on mobile

### 📊 Excel → MP3
Download tracks in the order defined in an Excel file.
- Automatic sheet detection, configurable column and start row
- `not_found.txt` file generated if some tracks were not found

### 📱 Mobile sync (built-in Wi-Fi server)
A web server starts automatically on `http://localhost:8888` when the app launches.
- Click the large **"📱 Télécharger sur mobile"** button to open the web interface
- Shows your library and the IP address to enter on your phone
- Delete playlists directly from the web interface
- The Android app auto-detects the server on the same Wi-Fi

---

## Interface

- Light / dark theme
- FR / EN language toggle
- Progress bar with estimated time remaining
- History of recent downloads
- Open output folder in one click
- Sound notification when a task completes

---

## Usage

### YouTube → MP3
1. Click **YouTube → MP3**
2. Paste the YouTube playlist URL
3. Click **Run** — MP3s are saved in `~/PlaylistManager/`
4. Click **📱 Télécharger sur mobile** to sync to your phone

---

## Installation from source

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

---

## License

[MIT](LICENSE) © 2026 Yma061
