STRINGS = {
    # ── Général ───────────────────────────────────────────────────────────────
    "app_title":        "Playlist Manager",
    "choose_action":    "Choisissez une action",
    "theme_dark":       "☀ Thème",
    "theme_light":      "🌙 Thème",
    "lang_btn":         "🇬🇧 EN",
    "back":             "← Retour",
    "launch":           "  Lancer le script  ",
    "browse":           "Parcourir...",
    "open_folder":      "📂 Ouvrir le dossier",
    "retry_failed":     "🔄 Réessayer les titres manquants",
    "recent_dl":        "Téléchargements récents",
    "choose_platform":  "Choisissez votre plateforme",

    # ── Progression ───────────────────────────────────────────────────────────
    "in_progress":      "En cours...",
    "done":             "Terminé !",
    "calculating_eta":  "Calcul en cours...",
    "less_than_minute": "moins d'une minute",
    "minutes_left":     "{n} min restante(s)",
    "hours_left":       "{h}h {m:02d}min restante(s)",
    "tracks_count":     "{done} / {total} musiques",
    "currently":        "En cours : {title}",

    # ── Sections détail ───────────────────────────────────────────────────────
    "what_it_does":     "Ce que ça fait",
    "what_you_need":    "Ce dont vous avez besoin",

    # ── Cartes accueil ────────────────────────────────────────────────────────
    "card_streaming_title": "Streaming  →  YouTube",
    "card_streaming_desc":  "Importe une playlist Deezer ou Spotify\ndans ta bibliothèque YouTube",
    "card_youtube_title":   "YouTube  →  MP3",
    "card_youtube_desc":    "Télécharge une playlist YouTube\net convertit chaque vidéo en MP3",
    "card_excel_title":     "Excel  →  MP3",
    "card_excel_desc":      "Télécharge les musiques dans\nl'ordre défini dans un fichier Excel",

    # ── Cartes streaming ──────────────────────────────────────────────────────
    "card_deezer_title":      "Deezer  →  YouTube",
    "card_deezer_desc":       "Importe une playlist Deezer\ndans ta bibliothèque YouTube",
    "card_spotify_title":     "Spotify  →  YouTube",
    "card_spotify_desc":      "Importe une playlist Spotify\ndans ta bibliothèque YouTube",
    "card_soundcloud_title":  "SoundCloud  →  YouTube",
    "card_soundcloud_desc":   "Importe une playlist SoundCloud\ndans ta bibliothèque YouTube",
    "card_apple_title":       "Apple Music  →  YouTube",
    "card_apple_desc":        "Importe une playlist Apple Music\ndans ta bibliothèque YouTube",

    # ── Mode Deezer ───────────────────────────────────────────────────────────
    "deezer_what": (
        "Récupère tous les titres d'une playlist Deezer et les importe "
        "automatiquement dans une nouvelle playlist YouTube sur ton compte Google."
    ),
    "deezer_needs": [
        "L'ID de ta playlist Deezer  (ex : 14838804003)",
        "Une connexion internet",
        "Au premier lancement : connexion à ton compte Google dans le navigateur",
        "✅  Connexion mémorisée — tu n'auras à te connecter qu'une seule fois.",
        "⚠  Limite YouTube : 10 000 unités/jour — chaque titre coûte 150 unités.",
        "⚠  Pour 190 titres (~28 500 unités), l'import devra être étalé sur 3 jours.",
        "✅  Reprise automatique : relancez avec le même ID, l'import reprend là où il s'est arrêté.",
    ],
    "deezer_input_label":       "ID de la playlist Deezer",
    "deezer_input_placeholder": "ex : 14838804003",
    "deezer_id_help":           "Comment obtenir cet ID ?",

    # ── Mode Spotify ──────────────────────────────────────────────────────────
    "spotify_what": (
        "Récupère tous les titres d'une playlist Spotify et les importe "
        "automatiquement dans une nouvelle playlist YouTube sur ton compte Google."
    ),
    "spotify_needs": [
        "L'URL de ta playlist Spotify  (ex : https://open.spotify.com/playlist/...)",
        "La playlist doit être publique",
        "Une connexion internet",
        "Au premier lancement : connexion à ton compte Google dans le navigateur",
        "✅  Connexion mémorisée — tu n'auras à te connecter qu'une seule fois.",
        "⚠  Limite YouTube : 10 000 unités/jour — chaque titre coûte 150 unités.",
        "✅  Reprise automatique : relancez avec la même URL, l'import reprend là où il s'est arrêté.",
    ],
    "spotify_input_label":       "URL de la playlist Spotify",
    "spotify_input_placeholder": "https://open.spotify.com/playlist/...",

    # ── Mode SoundCloud ───────────────────────────────────────────────────────
    "soundcloud_what": (
        "Récupère tous les titres d'une playlist SoundCloud publique et les importe "
        "automatiquement dans une nouvelle playlist YouTube sur ton compte Google."
    ),
    "soundcloud_needs": [
        "L'URL de ta playlist SoundCloud  (ex : https://soundcloud.com/user/sets/playlist)",
        "La playlist doit être publique",
        "Une connexion internet",
        "Au premier lancement : connexion à ton compte Google dans le navigateur",
        "✅  Connexion mémorisée — tu n'auras à te connecter qu'une seule fois.",
        "⚠  Limite YouTube : 10 000 unités/jour — chaque titre coûte 150 unités.",
        "✅  Reprise automatique : relancez avec la même URL, l'import reprend là où il s'est arrêté.",
    ],
    "soundcloud_input_label":       "URL de la playlist SoundCloud",
    "soundcloud_input_placeholder": "https://soundcloud.com/user/sets/playlist",

    # ── Mode Apple Music ──────────────────────────────────────────────────────
    "apple_what": (
        "Récupère tous les titres d'une playlist Apple Music publique et les importe "
        "automatiquement dans une nouvelle playlist YouTube sur ton compte Google. "
        "Aucun compte développeur Apple requis."
    ),
    "apple_needs": [
        "L'URL de ta playlist Apple Music  (ex : https://music.apple.com/fr/playlist/...)",
        "La playlist doit être publique",
        "Une connexion internet",
        "Au premier lancement : connexion à ton compte Google dans le navigateur",
        "✅  Connexion mémorisée — tu n'auras à te connecter qu'une seule fois.",
        "⚠  Limite YouTube : 10 000 unités/jour — chaque titre coûte 150 unités.",
        "✅  Reprise automatique : relancez avec la même URL, l'import reprend là où il s'est arrêté.",
    ],
    "apple_input_label":       "URL de la playlist Apple Music",
    "apple_input_placeholder": "https://music.apple.com/fr/playlist/...",

    # ── Mode YouTube ──────────────────────────────────────────────────────────
    "youtube_what": (
        "Télécharge toutes les vidéos d'une playlist YouTube et les convertit "
        "en fichiers MP3 (192 kbps), classés dans un dossier portant le nom "
        "de la playlist. Les fichiers sont numérotés dans l'ordre de la playlist."
    ),
    "youtube_needs": [
        "L'URL complète de la playlist YouTube",
        "Une connexion internet",
    ],
    "youtube_input_label":       "URL de la playlist YouTube",
    "youtube_input_placeholder": "https://www.youtube.com/playlist?list=...",

    # ── Mode Excel ────────────────────────────────────────────────────────────
    "excel_what": (
        "Lit un fichier Excel contenant une liste de titres, recherche chaque "
        "chanson sur YouTube et la télécharge en MP3 dans l'ordre du fichier. "
        "Une pause automatique est appliquée entre chaque titre."
    ),
    "excel_needs": [
        "Un fichier Excel avec les titres musicaux",
        "Une connexion internet",
    ],
    "excel_input_file_label":       "Fichier Excel",
    "excel_input_file_placeholder": "Clique sur Parcourir...",
    "excel_input_name_label":       "Nom de la playlist",
    "excel_input_name_placeholder": "ex : 1er mai 2026",
    "excel_sheet":      "Feuille",
    "excel_col":        "Colonne",
    "excel_first_row":  "   1ère ligne de données",

    # ── Erreurs ───────────────────────────────────────────────────────────────
    "err_no_deezer_id":       "Erreur : veuillez entrer un ID de playlist Deezer.",
    "err_invalid_deezer_id":  "Erreur : l'ID Deezer doit être un nombre (ex : 14838804003).",
    "err_no_spotify_url":     "Erreur : veuillez entrer une URL de playlist Spotify.",
    "err_invalid_spotify_url":"Erreur : URL de playlist Spotify invalide.",
    "err_no_sc_url":          "Erreur : veuillez entrer une URL de playlist SoundCloud.",
    "err_invalid_sc_url":     "Erreur : URL SoundCloud invalide.",
    "err_no_apple_url":       "Erreur : veuillez entrer une URL de playlist Apple Music.",
    "err_invalid_apple_url":  "Erreur : URL Apple Music invalide.",
    "err_no_yt_url":          "Erreur : veuillez entrer une URL de playlist YouTube.",
    "err_no_excel_file":      "Erreur : veuillez sélectionner un fichier Excel.",
    "err_no_playlist_name":   "Erreur : veuillez entrer un nom de playlist.",
    "err_generic":            "ERREUR : {e}",
    "stop":                   "⏹  Arrêter",
    "stopped":                "⏹  Arrêté.",
}
