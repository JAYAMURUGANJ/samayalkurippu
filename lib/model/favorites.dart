import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorites extends ChangeNotifier {
  List<String> favoriteItems = [];

  // List<String> get items => getListData() ?? _favoriteItems;

  _save(List<String> _favoriteItems) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favoriteKey', _favoriteItems);
  }

  static Future<List<String>> getfavoritItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favoriteKey') ?? [];
  }

  _clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void add(String dishId) {
    favoriteItems.add(dishId);
    _save(favoriteItems);
    notifyListeners();
  }

  void remove(String dishId) {
    favoriteItems.remove(dishId);
    _clear();
    _save(favoriteItems);
    notifyListeners();
  }
}
