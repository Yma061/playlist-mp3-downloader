import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import '../widgets/mode_card.dart';
import 'detail_page.dart';

class StreamingSelectPage extends StatelessWidget {
  const StreamingSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.watch<AppLocalizations>();
    final fg2 = Theme.of(context).textTheme.bodySmall?.color ?? Colors.grey;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAccentPurple,
        foregroundColor: Colors.white,
        title: Text(loc.t('card_streaming_title'),
            style: const TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ElevatedButton(
              onPressed: loc.toggle,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: kAccentPurple,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                textStyle: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.bold),
              ),
              child: Text(loc.t('lang_btn')),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(loc.t('choose_platform'),
                style: TextStyle(fontSize: 14, color: fg2)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  ModeCard(
                    color: kAccentPurple,
                    icon: '🎵',
                    title: loc.t('card_deezer_title'),
                    desc:  loc.t('card_deezer_desc'),
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const DetailPage(mode: 'deezer'))),
                  ),
                  ModeCard(
                    color: kAccentSpotify,
                    icon: '🟢',
                    title: loc.t('card_spotify_title'),
                    desc:  loc.t('card_spotify_desc'),
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const DetailPage(mode: 'spotify'))),
                  ),
                  ModeCard(
                    color: kAccentSoundCloud,
                    icon: '☁',
                    title: loc.t('card_soundcloud_title'),
                    desc:  loc.t('card_soundcloud_desc'),
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const DetailPage(mode: 'soundcloud'))),
                  ),
                  ModeCard(
                    color: kAccentApple,
                    icon: '🍎',
                    title: loc.t('card_apple_title'),
                    desc:  loc.t('card_apple_desc'),
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const DetailPage(mode: 'applemusic'))),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
