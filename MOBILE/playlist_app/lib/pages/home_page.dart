import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import '../theme/theme_provider.dart';
import '../widgets/mode_card.dart';
import '../services/auth_provider.dart';
import 'streaming_select_page.dart';
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc   = context.watch<AppLocalizations>();
    final theme = context.watch<ThemeProvider>();
    final fg2   = Theme.of(context).textTheme.bodySmall?.color ?? Colors.grey;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ── Top bar ────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Logout
                  IconButton(
                    icon: const Icon(Icons.logout),
                    tooltip: loc.t('logout'),
                    onPressed: () => context.read<AuthProvider>().logout(),
                  ),
                  // Theme toggle
                  IconButton(
                    icon: Icon(theme.isDark ? Icons.wb_sunny : Icons.nightlight_round),
                    onPressed: theme.toggle,
                    tooltip: loc.t(theme.isDark ? 'theme_dark' : 'theme_light'),
                  ),
                  const SizedBox(width: 4),
                  // Lang toggle
                  ElevatedButton(
                    onPressed: loc.toggle,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kAccentPurple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      textStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    child: Text(loc.t('lang_btn')),
                  ),
                ],
              ),
            ),

            // ── Title ──────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 4),
              child: Text(loc.t('app_title'),
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold)),
            ),
            Text(loc.t('choose_action'),
                style: TextStyle(fontSize: 14, color: fg2)),
            const SizedBox(height: 20),

            // ── Cards ──────────────────────────────────────────────────────
            Expanded(
              child: ListView(
                children: [
                  ModeCard(
                    color: kAccentPurple,
                    icon: '🎵',
                    title: loc.t('card_streaming_title'),
                    desc:  loc.t('card_streaming_desc'),
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const StreamingSelectPage())),
                  ),
                  ModeCard(
                    color: kAccentBlue,
                    icon: '▶',
                    title: loc.t('card_youtube_title'),
                    desc:  loc.t('card_youtube_desc'),
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const DetailPage(mode: 'youtube'))),
                  ),
                  ModeCard(
                    color: kAccentGreen,
                    icon: '📊',
                    title: loc.t('card_excel_title'),
                    desc:  loc.t('card_excel_desc'),
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const DetailPage(mode: 'excel'))),
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
