import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../services/music_service.dart';
import 'player_page.dart';

class LibraryDetailPage extends StatelessWidget {
  final Playlist playlist;
  const LibraryDetailPage({super.key, required this.playlist});

  void _openPlayer(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const PlayerPage()));
  }

  @override
  Widget build(BuildContext context) {
    final music      = context.watch<MusicService>();
    final isCurrentPl = music.currentPlaylist?.name == playlist.name;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── Header ────────────────────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            backgroundColor: kAccentGreen,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              title: Text(playlist.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15)),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF1db954), Color(0xFF121212)],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 48),
                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white.withValues(alpha: 0.1),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withValues(alpha: 0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 8))
                        ],
                      ),
                      child: const Icon(Icons.queue_music,
                          size: 60, color: Colors.white70),
                    ),
                    const SizedBox(height: 10),
                    Text('${playlist.tracks.length} titre${playlist.tracks.length > 1 ? 's' : ''}',
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 13)),
                  ],
                ),
              ),
            ),
          ),

          // ── Boutons Play / Shuffle ─────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.play_arrow_rounded),
                      label: const Text('Lire tout'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kAccentGreen,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                      ),
                      onPressed: () {
                        context
                            .read<MusicService>()
                            .playPlaylist(playlist);
                        _openPlayer(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.shuffle_rounded),
                      label: const Text('Aléatoire'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: kAccentGreen,
                        side: const BorderSide(color: kAccentGreen),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                      ),
                      onPressed: () {
                        final idx = DateTime.now().millisecond %
                            playlist.tracks.length;
                        context
                            .read<MusicService>()
                            .playPlaylist(playlist, index: idx);
                        _openPlayer(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Liste des titres ───────────────────────────────────────────────
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                final track    = playlist.tracks[i];
                final isCurrent = isCurrentPl && music.currentIndex == i;

                return ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  leading: CircleAvatar(
                    radius: 18,
                    backgroundColor: isCurrent
                        ? kAccentGreen
                        : kAccentGreen.withValues(alpha: 0.1),
                    child: isCurrent && music.isPlaying
                        ? const Icon(Icons.volume_up,
                            color: Colors.white, size: 16)
                        : Text('${i + 1}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color:
                                  isCurrent ? Colors.white : kAccentGreen,
                            )),
                  ),
                  title: Text(
                    track.name,
                    style: TextStyle(
                      fontWeight: isCurrent
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isCurrent ? kAccentGreen : null,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: isCurrent
                      ? IconButton(
                          icon: Icon(
                            music.isPlaying
                                ? Icons.pause_circle
                                : Icons.play_circle,
                            color: kAccentGreen,
                            size: 30,
                          ),
                          onPressed: () =>
                              context.read<MusicService>().playPause(),
                        )
                      : Icon(Icons.music_note_outlined,
                          size: 18,
                          color: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.color
                              ?.withValues(alpha: 0.4)),
                  onTap: () {
                    context
                        .read<MusicService>()
                        .playPlaylist(playlist, index: i);
                    _openPlayer(context);
                  },
                );
              },
              childCount: playlist.tracks.length,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}
