import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_links/app_links.dart';
import 'theme/app_theme.dart';
import 'theme/theme_provider.dart';
import 'l10n/app_localizations.dart';
import 'services/auth_provider.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AppLocalizations()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const PlaylistManagerApp(),
    ),
  );
}

class PlaylistManagerApp extends StatefulWidget {
  const PlaylistManagerApp({super.key});

  @override
  State<PlaylistManagerApp> createState() => _PlaylistManagerAppState();
}

class _PlaylistManagerAppState extends State<PlaylistManagerApp> {
  late final AppLinks _appLinks;

  @override
  void initState() {
    super.initState();
    _appLinks = AppLinks();
    // Écoute les deep links entrants (playlistmanager://auth?token=...)
    _appLinks.uriLinkStream.listen((uri) {
      if (uri.scheme == 'playlistmanager' && uri.host == 'auth') {
        final token = uri.queryParameters['token'];
        if (token != null && mounted) {
          context.read<AuthProvider>().handleToken(token);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final auth          = context.watch<AuthProvider>();

    return MaterialApp(
      title: 'Playlist Manager',
      debugShowCheckedModeBanner: false,
      theme:     lightTheme(),
      darkTheme: darkTheme(),
      themeMode: themeProvider.themeMode,
      home: auth.isLoading
          ? const Scaffold(
              body: Center(child: CircularProgressIndicator()))
          : auth.isLoggedIn
              ? const HomePage()
              : const LoginPage(),
    );
  }
}
