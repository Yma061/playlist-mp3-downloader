from deezer import get_deezer_tracks
from youtube import get_youtube_service, create_playlist, add_videos


if __name__ == "__main__":
    playlist_id_deezer = "14838804003"

    print("Récupération Deezer...")
    tracks = get_deezer_tracks(playlist_id_deezer)
    print(f"{len(tracks)} morceaux récupérés")

    # 🔽 Limite temporaire pour éviter quota
    tracks = tracks[:50]
    print(f"On importe seulement {len(tracks)} morceaux")

    print("Connexion YouTube...")
    youtube = get_youtube_service()

    print("Création playlist...")
    playlist_id_yt = create_playlist(
        youtube,
        "Importée depuis Deezer"
    )

    print("Ajout des vidéos...")
    add_videos(youtube, playlist_id_yt, tracks)

    print("Import terminé !")
