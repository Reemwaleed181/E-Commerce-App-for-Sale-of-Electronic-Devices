import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesController extends ChangeNotifier {
  static const String _prefKey = 'favorite_titles_v1';

  Set<String> _titles = {};

  Set<String> get titles => _titles;

  FavoritesController() {
    _load();
  }

  bool isFavorite(String title) {
    final t = title.trim();
    if (t.isEmpty) return false;
    return _titles.contains(t);
  }

  Future<void> toggle(String title) async {
    final t = title.trim();
    if (t.isEmpty) return;

    if (_titles.contains(t)) {
      _titles.remove(t);
    } else {
      _titles.add(t);
    }

    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final list = _titles.toList()..sort();
    await prefs.setStringList(_prefKey, list);
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_prefKey) ?? const <String>[];
    _titles = stored.map((e) => e.trim()).where((e) => e.isNotEmpty).toSet();
    notifyListeners();
  }
}
