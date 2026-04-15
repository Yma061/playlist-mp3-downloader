STRINGS = {
    # ── General ───────────────────────────────────────────────────────────────
    "app_title":        "Playlist Manager",
    "choose_action":    "Choose an action",
    "theme_dark":       "☀ Theme",
    "theme_light":      "🌙 Theme",
    "lang_btn":         "🇫🇷 FR",
    "back":             "← Back",
    "launch":           "  Run script  ",
    "browse":           "Browse...",
    "open_folder":      "📂 Open folder",
    "retry_failed":     "🔄 Retry missing tracks",
    "recent_dl":        "Recent downloads",
    "choose_platform":  "Choose your platform",

    # ── Progress ──────────────────────────────────────────────────────────────
    "in_progress":      "In progress...",
    "done":             "Done!",
    "calculating_eta":  "Calculating...",
    "less_than_minute": "less than a minute",
    "minutes_left":     "{n} min left",
    "hours_left":       "{h}h {m:02d}min left",
    "tracks_count":     "{done} / {total} tracks",
    "currently":        "Currently: {title}",

    # ── Detail sections ───────────────────────────────────────────────────────
    "what_it_does":     "What it does",
    "what_you_need":    "What you need",

    # ── Home cards ────────────────────────────────────────────────────────────
    "card_streaming_title": "Streaming  →  YouTube",
    "card_streaming_desc":  "Import a Deezer or Spotify playlist\nto your YouTube library",
    "card_youtube_title":   "YouTube  →  MP3",
    "card_youtube_desc":    "Download a YouTube playlist\nand convert each video to MP3",
    "card_excel_title":     "Excel  →  MP3",
    "card_excel_desc":      "Download tracks in the order\ndefined in an Excel file",

    # ── Streaming cards ───────────────────────────────────────────────────────
    "card_deezer_title":      "Deezer  →  YouTube",
    "card_deezer_desc":       "Import a Deezer playlist\nto your YouTube library",
    "card_spotify_title":     "Spotify  →  YouTube",
    "card_spotify_desc":      "Import a Spotify playlist\nto your YouTube library",
    "card_soundcloud_title":  "SoundCloud  →  YouTube",
    "card_soundcloud_desc":   "Import a SoundCloud playlist\nto your YouTube library",
    "card_apple_title":       "Apple Music  →  YouTube",
    "card_apple_desc":        "Import an Apple Music playlist\nto your YouTube library",

    # ── Deezer mode ───────────────────────────────────────────────────────────
    "deezer_what": (
        "Fetches all tracks from a Deezer playlist and automatically imports "
        "them into a new YouTube playlist on your Google account."
    ),
    "deezer_needs": [
        "Your Deezer playlist ID  (e.g. 14838804003)",
        "An internet connection",
        "First launch: sign in to your Google account in the browser",
        "✅  Connection remembered — you only need to sign in once.",
        "⚠  YouTube limit: 10,000 units/day — each track costs 150 units.",
        "⚠  For 190 tracks (~28,500 units), the import will need to be spread over 3 days.",
        "✅  Auto-resume: relaunch with the same ID and the import picks up where it left off.",
    ],
    "deezer_input_label":       "Deezer playlist ID",
    "deezer_input_placeholder": "e.g. 14838804003",
    "deezer_id_help":           "How to find this ID?",

    # ── Spotify mode ──────────────────────────────────────────────────────────
    "spotify_what": (
        "Fetches all tracks from a Spotify playlist and automatically imports "
        "them into a new YouTube playlist on your Google account."
    ),
    "spotify_needs": [
        "Your Spotify playlist URL  (e.g. https://open.spotify.com/playlist/...)",
        "The playlist must be public",
        "An internet connection",
        "First launch: sign in to your Google account in the browser",
        "✅  Connection remembered — you only need to sign in once.",
        "⚠  YouTube limit: 10,000 units/day — each track costs 150 units.",
        "✅  Auto-resume: relaunch with the same URL and the import picks up where it left off.",
    ],
    "spotify_input_label":       "Spotify playlist URL",
    "spotify_input_placeholder": "https://open.spotify.com/playlist/...",

    # ── SoundCloud mode ───────────────────────────────────────────────────────
    "soundcloud_what": (
        "Fetches all tracks from a public SoundCloud playlist and automatically "
        "imports them into a new YouTube playlist on your Google account."
    ),
    "soundcloud_needs": [
        "Your SoundCloud playlist URL  (e.g. https://soundcloud.com/user/sets/playlist)",
        "The playlist must be public",
        "An internet connection",
        "First launch: sign in to your Google account in the browser",
        "✅  Connection remembered — you only need to sign in once.",
        "⚠  YouTube limit: 10,000 units/day — each track costs 150 units.",
        "✅  Auto-resume: relaunch with the same URL and the import picks up where it left off.",
    ],
    "soundcloud_input_label":       "SoundCloud playlist URL",
    "soundcloud_input_placeholder": "https://soundcloud.com/user/sets/playlist",

    # ── Apple Music mode ──────────────────────────────────────────────────────
    "apple_what": (
        "Fetches all tracks from a public Apple Music playlist and automatically "
        "imports them into a new YouTube playlist on your Google account. "
        "No Apple developer account required."
    ),
    "apple_needs": [
        "Your Apple Music playlist URL  (e.g. https://music.apple.com/playlist/...)",
        "The playlist must be public",
        "An internet connection",
        "First launch: sign in to your Google account in the browser",
        "✅  Connection remembered — you only need to sign in once.",
        "⚠  YouTube limit: 10,000 units/day — each track costs 150 units.",
        "✅  Auto-resume: relaunch with the same URL and the import picks up where it left off.",
    ],
    "apple_input_label":       "Apple Music playlist URL",
    "apple_input_placeholder": "https://music.apple.com/playlist/...",

    # ── YouTube mode ──────────────────────────────────────────────────────────
    "youtube_what": (
        "Downloads all videos from a YouTube playlist and converts them "
        "to MP3 files (192 kbps), saved in a folder named after the playlist. "
        "Files are numbered in playlist order."
    ),
    "youtube_needs": [
        "The full YouTube playlist URL",
        "An internet connection",
    ],
    "youtube_input_label":       "YouTube playlist URL",
    "youtube_input_placeholder": "https://www.youtube.com/playlist?list=...",

    # ── Excel mode ────────────────────────────────────────────────────────────
    "excel_what": (
        "Reads an Excel file containing a list of track titles, searches for "
        "each song on YouTube and downloads it as MP3 in file order. "
        "An automatic pause is applied between each track."
    ),
    "excel_needs": [
        "An Excel file with track titles",
        "An internet connection",
    ],
    "excel_input_file_label":       "Excel file",
    "excel_input_file_placeholder": "Click Browse...",
    "excel_input_name_label":       "Playlist name",
    "excel_input_name_placeholder": "e.g. Summer 2026",
    "excel_sheet":      "Sheet",
    "excel_col":        "Column",
    "excel_first_row":  "   First data row",

    # ── Errors ────────────────────────────────────────────────────────────────
    "err_no_deezer_id":        "Error: please enter a Deezer playlist ID.",
    "err_invalid_deezer_id":   "Error: Deezer ID must be a number (e.g. 14838804003).",
    "err_no_spotify_url":      "Error: please enter a Spotify playlist URL.",
    "err_invalid_spotify_url": "Error: invalid Spotify playlist URL.",
    "err_no_sc_url":           "Error: please enter a SoundCloud playlist URL.",
    "err_invalid_sc_url":      "Error: invalid SoundCloud URL.",
    "err_no_apple_url":        "Error: please enter an Apple Music playlist URL.",
    "err_invalid_apple_url":   "Error: invalid Apple Music URL.",
    "err_no_yt_url":           "Error: please enter a YouTube playlist URL.",
    "err_no_excel_file":       "Error: please select an Excel file.",
    "err_no_playlist_name":    "Error: please enter a playlist name.",
    "err_generic":             "ERROR: {e}",
    "stop":                    "⏹  Stop",
    "stopped":                 "⏹  Stopped.",
}
