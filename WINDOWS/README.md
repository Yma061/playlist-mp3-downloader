# Playlist Manager

> 🇫🇷 [Version française disponible ici](README_FR.md)

A Windows GUI application to download and manage music playlists.

## Download

Latest version: **v2.0.0**  
**[⬇ Download PlaylistManager.exe](https://github.com/Yma061/playlist-mp3-downloader/releases/download/v2.0.0/PlaylistManager.exe)**

> Windows only — no installation required, just double-click to launch.

### ⚠️ Windows warning on first launch

Windows may display a security warning because the file is not signed by a certified publisher. This is normal for an independent application.

**To launch the application:**

1. Click **"More info"**

   ![SmartScreen step 1](docs/smartscreen_1.png)

2. Click **"Run anyway"**

   ![SmartScreen step 2](docs/smartscreen_2.png)

> The file is open source — you can inspect the full source code in this repository.

---

## Preview

![App preview](docs/Exemple.png)

![Mode page preview](docs/Exemple2.png)

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

- Built-in Google sign-in — a browser window opens on first launch, connection is remembered afterwards
- Automatic resume if the daily API quota is reached
- Limit: ~66 tracks/day (Google quota of 10,000 units/day)

### ▶ YouTube → MP3
Download a full YouTube playlist and convert each video to MP3 (192 kbps).
- Files numbered in playlist order

### 📊 Excel → MP3
Download tracks in the order defined in an Excel file.
- Automatic sheet detection, configurable column and start row
- Random pause between each track to avoid YouTube blocks
- `not_found.txt` file generated if some tracks were not found
- "Retry missing tracks" button to re-run only failed downloads

---

## Interface

- Light / dark theme
- FR / EN language toggle
- Progress bar with estimated time remaining (ETA)
- History of the last 5 downloads on the home page
- Open output folder in one click
- Sound notification when a task completes

---

## Usage

### Streaming → YouTube
1. Launch the application
2. Click **Streaming → YouTube**
3. Choose your platform (Deezer, Spotify, SoundCloud or Apple Music)
4. Paste the URL or ID of your playlist
5. Click **Run** — a Google sign-in window opens on first launch
6. The connection is remembered for next time

### YouTube → MP3
1. Click **YouTube → MP3**
2. Paste the YouTube playlist URL
3. Click **Run** — MP3s are saved in `playlists/`

### Excel → MP3
1. Click **Excel → MP3**
2. Select your Excel file via **Browse...**
3. Choose the sheet, column and first data row
4. Enter a playlist name and click **Run**

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

Python · Tkinter · yt-dlp · spotdl · Deezer API · Spotify · SoundCloud · Apple Music · YouTube Data API v3 · openpyxl · keyring · PyInstaller

---

## License

[MIT](LICENSE) © 2026 Yma061
