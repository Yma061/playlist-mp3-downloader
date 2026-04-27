import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../services/music_service.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key});

  String _fmt(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final music    = context.watch<MusicService>();
    final track    = music.currentTrack;
    if (track == null) return const SizedBox.shrink();

    final progress = music.duration.inMilliseconds > 0
        ? music.position.inMilliseconds / music.duration.inMilliseconds
        : 0.0;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 36),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('En cours de lecture',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1db954), Color(0xFF121212)],
            stops: [0.0, 0.5],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                const SizedBox(height: 32),

                // ── Pochette ────────────────────────────────────────────────
                Container(
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: kAccentGreen.withValues(alpha: 0.25),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withValues(alpha: 0.5),
                          blurRadius: 40,
                          offset: const Offset(0, 20))
                    ],
                  ),
                  child: const Icon(Icons.music_note_rounded,
                      size: 100, color: Colors.white70),
                ),
                const SizedBox(height: 40),

                // ── Titre + playlist ────────────────────────────────────────
                Text(
                  track.name,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(height: 6),
                if (music.currentPlaylist != null)
                  Text(
                    music.currentPlaylist!.name,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.6)),
                  ),
                const Spacer(),

                // ── Slider ──────────────────────────────────────────────────
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Colors.white.withValues(alpha: 0.2),
                    thumbColor: Colors.white,
                    overlayColor: Colors.white.withValues(alpha: 0.1),
                    trackHeight: 3,
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 6),
                  ),
                  child: Slider(
                    value: progress.clamp(0.0, 1.0),
                    onChanged: (v) {
                      final pos = Duration(
                          milliseconds:
                              (v * music.duration.inMilliseconds).round());
                      context.read<MusicService>().seekTo(pos);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_fmt(music.position),
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withValues(alpha: 0.6))),
                      Text(_fmt(music.duration),
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withValues(alpha: 0.6))),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ── Contrôles ───────────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.skip_previous_rounded, size: 52),
                      color: Colors.white,
                      onPressed: () =>
                          context.read<MusicService>().playPrev(),
                    ),
                    Container(
                      width: 68,
                      height: 68,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: IconButton(
                        icon: Icon(
                          music.isPlaying
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          size: 40,
                        ),
                        color: Colors.black,
                        onPressed: () =>
                            context.read<MusicService>().playPause(),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.skip_next_rounded, size: 52),
                      color: Colors.white,
                      onPressed: () =>
                          context.read<MusicService>().playNext(),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
