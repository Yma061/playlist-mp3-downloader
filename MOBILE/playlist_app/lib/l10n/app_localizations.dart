import 'package:flutter/material.dart';
import 'strings.dart';

class AppLocalizations extends ChangeNotifier {
  String _lang = 'fr';

  String get lang => _lang;

  void toggle() {
    _lang = _lang == 'fr' ? 'en' : 'fr';
    notifyListeners();
  }

  void setLang(String lang) {
    if (lang == 'fr' || lang == 'en') {
      _lang = lang;
      notifyListeners();
    }
  }

  String t(String key) {
    final map = kStrings[_lang] ?? kStrings['fr']!;
    final val = map[key] ?? kStrings['fr']![key];
    if (val is String) return val;
    return key;
  }

  List<String> tList(String key) {
    final map = kStrings[_lang] ?? kStrings['fr']!;
    final val = map[key] ?? kStrings['fr']![key];
    if (val is List) return List<String>.from(val);
    return [];
  }
}
