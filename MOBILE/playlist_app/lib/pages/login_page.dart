import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import '../theme/theme_provider.dart';
import '../services/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final loc   = context.watch<AppLocalizations>();
    final theme = context.watch<ThemeProvider>();
    final fg2   = Theme.of(context).textTheme.bodySmall?.color ?? Colors.grey;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Top bar ─────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(theme.isDark
                          ? Icons.wb_sunny
                          : Icons.nightlight_round),
                      onPressed: theme.toggle,
                    ),
                    const SizedBox(width: 4),
                    ElevatedButton(
                      onPressed: loc.toggle,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kAccentPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
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

              const Spacer(),

              // ── Logo ────────────────────────────────────────────────────
              const Icon(Icons.music_note, size: 88, color: kAccentPurple),
              const SizedBox(height: 16),
              Text(
                loc.t('app_title'),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                loc.t('login_subtitle'),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: fg2),
              ),

              const Spacer(),

              // ── Bouton connexion ─────────────────────────────────────────
              SizedBox(
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _loading
                      ? null
                      : () async {
                          setState(() => _loading = true);
                          try {
                            await context.read<AuthProvider>().startLogin();
                          } finally {
                            if (mounted) setState(() => _loading = false);
                          }
                        },
                  icon: _loading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white))
                      : const Icon(Icons.account_circle, size: 24),
                  label: Text(loc.t('connect_google')),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kAccentPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    textStyle: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
