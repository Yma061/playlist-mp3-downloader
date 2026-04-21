"""
Playlist Manager — Serveur de synchronisation Wi-Fi
Démarré automatiquement par l'application desktop.
Interface web : http://localhost:8888
"""
import asyncio
import json
import shutil
import socket
import time
from contextlib import asynccontextmanager
from pathlib import Path

import yt_dlp
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import FileResponse, HTMLResponse, StreamingResponse
from pydantic import BaseModel

MUSIC_DIR = Path.home() / "PlaylistManager"
MUSIC_DIR.mkdir(exist_ok=True)
PORT = 8888

_jobs: dict[str, dict] = {}


def get_local_ip() -> str:
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    try:
        s.connect(("8.8.8.8", 80))
        return s.getsockname()[0]
    except Exception:
        return "127.0.0.1"
    finally:
        s.close()


@asynccontextmanager
async def lifespan(app: FastAPI):
    ip = get_local_ip()
    print(f"[Serveur Wi-Fi] Démarré — téléphone : http://{ip}:{PORT}")
    await _start_mdns(ip, PORT)
    yield


app = FastAPI(title="Playlist Manager", lifespan=lifespan)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)


# ── API bibliothèque ──────────────────────────────────────────────────────────

@app.get("/api/library")
def get_library():
    playlists = []
    for pl_dir in sorted(MUSIC_DIR.iterdir()):
        if not pl_dir.is_dir():
            continue
        tracks = [
            {"name": f.stem, "file": f.name, "size": f.stat().st_size}
            for f in sorted(pl_dir.glob("*.mp3"))
        ]
        if tracks:
            playlists.append({"name": pl_dir.name, "tracks": tracks})
    return playlists


@app.get("/music/{playlist}/{filename}")
def serve_track(playlist: str, filename: str):
    path = MUSIC_DIR / playlist / filename
    if not path.exists():
        raise HTTPException(status_code=404, detail="Not found")
    return FileResponse(str(path), media_type="audio/mpeg",
                        headers={"Accept-Ranges": "bytes"})


@app.delete("/api/library/{playlist_name}")
def delete_playlist(playlist_name: str):
    path = MUSIC_DIR / playlist_name
    if not path.exists() or not path.is_dir():
        raise HTTPException(status_code=404, detail="Playlist introuvable")
    shutil.rmtree(path)
    return {"deleted": playlist_name}


@app.get("/api/ip")
def get_ip():
    return {"ip": get_local_ip()}


# ── API téléchargement ────────────────────────────────────────────────────────

class DownloadRequest(BaseModel):
    url: str
    playlist_name: str = ""


@app.post("/api/download")
async def start_download(req: DownloadRequest):
    job_id = str(time.time_ns())
    _jobs[job_id] = {"status": "running", "done": 0, "total": 0, "current": ""}
    asyncio.create_task(_download_task(job_id, req.url.strip(), req.playlist_name.strip()))
    return {"job_id": job_id}


@app.get("/api/progress/{job_id}")
async def stream_progress(job_id: str):
    async def generate():
        while True:
            p = _jobs.get(job_id, {"status": "unknown"})
            yield f"data: {json.dumps(p)}\n\n"
            if p.get("status") in ("done", "error"):
                break
            await asyncio.sleep(0.4)
    return StreamingResponse(generate(), media_type="text/event-stream")


async def _download_task(job_id: str, url: str, playlist_name: str):
    try:
        info_opts = {"quiet": True, "extract_flat": True, "skip_download": True}
        with yt_dlp.YoutubeDL(info_opts) as ydl:
            info = await asyncio.to_thread(ydl.extract_info, url, False)

        entries = (info or {}).get("entries", [])
        if not entries:
            _jobs[job_id] = {"status": "error", "current": "Aucune vidéo trouvée."}
            return

        pl_name = playlist_name or (info or {}).get("title", "playlist")
        out_dir = MUSIC_DIR / pl_name
        out_dir.mkdir(exist_ok=True)
        _jobs[job_id]["total"] = len(entries)

        finished = [0]
        def _hook(d: dict):
            if d["status"] == "finished":
                finished[0] += 1
                title = Path(d.get("filename", "")).stem
                _jobs[job_id].update({"done": finished[0], "current": title})

        dl_opts = {
            "quiet": True,
            "format": "bestaudio/best",
            "outtmpl": str(out_dir / "%(playlist_index)02d - %(title)s.%(ext)s"),
            "postprocessors": [{
                "key": "FFmpegExtractAudio",
                "preferredcodec": "mp3",
                "preferredquality": "192",
            }],
            "progress_hooks": [_hook],
        }
        with yt_dlp.YoutubeDL(dl_opts) as ydl:
            await asyncio.to_thread(ydl.download, [url])

        _jobs[job_id]["status"] = "done"
        _jobs[job_id]["current"] = f"{finished[0]} titres téléchargés dans « {pl_name} »"
    except Exception as exc:
        _jobs[job_id] = {"status": "error", "current": str(exc)}


# ── Interface Web ─────────────────────────────────────────────────────────────

HTML = r"""<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Playlist Manager</title>
<style>
  *{box-sizing:border-box;margin:0;padding:0}
  body{font-family:system-ui,sans-serif;background:#0f172a;color:#e2e8f0;min-height:100vh;padding:24px}
  h1{font-size:1.5rem;font-weight:700;margin-bottom:24px;color:#4ade80}
  .card{background:#1e293b;border-radius:12px;padding:20px;margin-bottom:20px}
  .card h2{font-size:1rem;font-weight:600;margin-bottom:12px;color:#94a3b8}
  input{width:100%;padding:10px 14px;border-radius:8px;border:1px solid #334155;
        background:#0f172a;color:#e2e8f0;font-size:14px;outline:none}
  input:focus{border-color:#4ade80}
  button{padding:10px 20px;border-radius:8px;border:none;cursor:pointer;font-weight:600;font-size:14px}
  .btn-green{background:#4ade80;color:#0f172a}
  .btn-green:hover{background:#22c55e}
  .btn-green:disabled{opacity:.5;cursor:not-allowed}
  .btn-del{background:#ef4444;color:#fff;border:none;border-radius:6px;
           padding:5px 12px;cursor:pointer;font-size:12px;font-weight:600}
  .btn-del:hover{background:#dc2626}
  .row{display:flex;gap:10px;margin-top:10px}
  .progress-box{margin-top:14px;padding:12px;background:#0f172a;border-radius:8px;display:none}
  .bar-bg{background:#334155;border-radius:4px;height:8px;margin:8px 0}
  .bar{background:#4ade80;height:8px;border-radius:4px;transition:width .3s}
  .status{font-size:13px;color:#94a3b8;margin-top:4px}
  .playlist{margin-bottom:12px;background:#0f172a;border-radius:8px;padding:12px}
  .pl-header{display:flex;align-items:center;justify-content:space-between;margin-bottom:6px}
  .pl-name{font-weight:600;color:#4ade80}
  .track{font-size:13px;color:#94a3b8;padding:2px 0 2px 12px}
  .empty{color:#475569;font-size:14px;text-align:center;padding:20px}
  .ip-badge{display:inline-block;background:#1e3a5f;color:#60a5fa;
            padding:6px 14px;border-radius:20px;font-size:13px;font-family:monospace}
</style>
</head>
<body>
<h1>🎵 Playlist Manager</h1>

<div class="card">
  <h2>Connexion depuis le téléphone</h2>
  <p style="font-size:13px;color:#94a3b8;margin-bottom:10px">
    Ouvrez l'application sur votre téléphone et entrez cette adresse :<br>
    (ou laissez l'app la détecter automatiquement via Wi-Fi)
  </p>
  <span class="ip-badge" id="ip-badge">Chargement...</span>
</div>

<div class="card">
  <h2>Télécharger une playlist YouTube</h2>
  <input id="url" type="url" placeholder="https://www.youtube.com/playlist?list=...">
  <div class="row">
    <input id="plname" type="text" placeholder="Nom de la playlist (optionnel)" style="flex:1">
    <button class="btn-green" id="dl-btn" onclick="startDownload()">Télécharger</button>
  </div>
  <div class="progress-box" id="prog-box">
    <div class="status" id="prog-status">Démarrage...</div>
    <div class="bar-bg"><div class="bar" id="prog-bar" style="width:0%"></div></div>
    <div class="status" id="prog-current"></div>
  </div>
</div>

<div class="card">
  <h2>Bibliothèque locale</h2>
  <div id="library"><div class="empty">Chargement...</div></div>
</div>

<script>
async function loadIp() {
  const r = await fetch('/api/ip');
  const d = await r.json();
  document.getElementById('ip-badge').textContent = d.ip + ':8888';
}

async function loadLibrary() {
  const r = await fetch('/api/library');
  const data = await r.json();
  const el = document.getElementById('library');
  if (!data.length) {
    el.innerHTML = '<div class="empty">Aucune playlist. Téléchargez-en une ci-dessus.</div>';
    return;
  }
  el.innerHTML = data.map(pl => `
    <div class="playlist">
      <div class="pl-header">
        <span class="pl-name">📁 ${pl.name} (${pl.tracks.length} titre${pl.tracks.length>1?'s':''})</span>
        <button class="btn-del" data-name="${pl.name}" onclick="askDelete(this)">🗑 Supprimer</button>
      </div>
      ${pl.tracks.map(t => `<div class="track">🎵 ${t.name}</div>`).join('')}
    </div>`).join('');
}

function askDelete(btn) {
  const name = btn.dataset.name;
  if (btn.dataset.step === '1') {
    fetch('/api/library/' + encodeURIComponent(name), {method: 'DELETE'}).then(loadLibrary);
  } else {
    btn.dataset.step = '1';
    btn.textContent = '⚠ Confirmer ?';
    btn.style.background = '#b91c1c';
    setTimeout(() => {
      btn.dataset.step = '0';
      btn.textContent = '🗑 Supprimer';
      btn.style.background = '';
    }, 3000);
  }
}

async function startDownload() {
  const url = document.getElementById('url').value.trim();
  const name = document.getElementById('plname').value.trim();
  if (!url || !url.includes('youtube.com/playlist')) {
    alert('URL de playlist YouTube invalide.'); return;
  }
  const btn = document.getElementById('dl-btn');
  btn.disabled = true;
  const box = document.getElementById('prog-box');
  box.style.display = 'block';
  document.getElementById('prog-status').textContent = 'Démarrage...';
  document.getElementById('prog-bar').style.width = '0%';
  document.getElementById('prog-current').textContent = '';

  const r = await fetch('/api/download', {
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify({url, playlist_name: name})
  });
  const {job_id} = await r.json();

  const es = new EventSource(`/api/progress/${job_id}`);
  es.onmessage = e => {
    const p = JSON.parse(e.data);
    const pct = p.total > 0 ? Math.round(p.done / p.total * 100) : 0;
    document.getElementById('prog-bar').style.width = pct + '%';
    document.getElementById('prog-status').textContent =
      p.total > 0 ? `${p.done} / ${p.total} (${pct}%)` : 'En cours...';
    document.getElementById('prog-current').textContent = p.current || '';
    if (p.status === 'done' || p.status === 'error') {
      es.close();
      btn.disabled = false;
      if (p.status === 'done') loadLibrary();
    }
  };
}

loadIp();
loadLibrary();
setInterval(loadLibrary, 10000);
</script>
</body>
</html>"""


@app.get("/", response_class=HTMLResponse)
def web_ui():
    return HTML


# ── mDNS ─────────────────────────────────────────────────────────────────────

async def _start_mdns(ip: str, port: int):
    try:
        from zeroconf import ServiceInfo
        from zeroconf.asyncio import AsyncZeroconf
        zc = AsyncZeroconf()
        info = ServiceInfo(
            "_playlist._tcp.local.",
            "PlaylistManager._playlist._tcp.local.",
            addresses=[socket.inet_aton(ip)],
            port=port,
            properties={"version": b"1"},
        )
        await zc.async_register_service(info)
        print(f"[mDNS] Annoncé : PlaylistManager @ {ip}:{port}")
    except Exception as e:
        print(f"[mDNS] Non disponible : {e}")


# ── Démarrage en thread (appelé par interface.py) ─────────────────────────────

def start_in_background():
    import asyncio
    import sys
    import traceback
    if sys.platform == "win32":
        asyncio.set_event_loop_policy(asyncio.WindowsSelectorEventLoopPolicy())
    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)
    try:
        loop.run_until_complete(_serve())
    except Exception:
        log = MUSIC_DIR / "server_error.log"
        with open(log, "w", encoding="utf-8") as f:
            traceback.print_exc(file=f)
    finally:
        try:
            loop.close()
        except Exception:
            pass


async def _serve():
    import uvicorn
    config = uvicorn.Config(
        app,
        host="0.0.0.0",
        port=PORT,
        log_level="warning",
        loop="asyncio",
        http="h11",
        log_config=None,
    )
    server = uvicorn.Server(config)
    await server.serve()
