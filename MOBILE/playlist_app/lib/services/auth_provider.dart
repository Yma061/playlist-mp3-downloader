import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

const String kBackendBase = 'https://playlist-manager-backend.onrender.com';

class AuthProvider extends ChangeNotifier {
  String? _jwtToken;
  bool    _loading = true;

  String? get jwtToken  => _jwtToken;
  bool    get isLoggedIn => _jwtToken != null;
  bool    get isLoading  => _loading;

  AuthProvider() {
    _loadToken();
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _jwtToken = prefs.getString('jwt_token');
    _loading  = false;
    notifyListeners();
  }

  Future<void> handleToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
    _jwtToken = token;
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
    _jwtToken = null;
    notifyListeners();
  }

  Future<void> startLogin() async {
    final response = await http.get(Uri.parse('$kBackendBase/auth/url'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final url  = data['url'] as String;
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }
}
