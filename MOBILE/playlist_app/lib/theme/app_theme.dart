import 'package:flutter/material.dart';

const kAccentPurple     = Color(0xFF7c3aed);
const kAccentBlue       = Color(0xFF0ea5e9);
const kAccentGreen      = Color(0xFF10b981);
const kAccentSpotify    = Color(0xFF1db954);
const kAccentSoundCloud = Color(0xFFff5500);
const kAccentApple      = Color(0xFFfc3c44);

ThemeData darkTheme() => ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF1e1e2e),
  colorScheme: ColorScheme.dark(
    primary: kAccentPurple,
    surface: const Color(0xFF2a2a3d),
  ),
  cardColor: const Color(0xFF2a2a3d),
  fontFamily: 'Roboto',
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF2a2a3d),
    foregroundColor: Color(0xFFf1f5f9),
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Color(0xFFf1f5f9)),
    bodySmall:  TextStyle(color: Color(0xFF94a3b8)),
  ),
);

ThemeData lightTheme() => ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFf0f0f8),
  colorScheme: ColorScheme.light(
    primary: kAccentPurple,
    surface: const Color(0xFFdcdcec),
  ),
  cardColor: const Color(0xFFdcdcec),
  fontFamily: 'Roboto',
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFdcdcec),
    foregroundColor: Color(0xFF1a1a2e),
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Color(0xFF1a1a2e)),
    bodySmall:  TextStyle(color: Color(0xFF555577)),
  ),
);
