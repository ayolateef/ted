import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppState extends ChangeNotifier {
  String _currentRoute = '/';

  String get currentRoute => _currentRoute;

  set currentRoute(String route) {
    _currentRoute = route;
    notifyListeners();
    _saveCurrentRoute(route);
  }

  Future<void> _saveCurrentRoute(String route) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentRoute', route);
  }

  Future<void> loadCurrentRoute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentRoute = prefs.getString('currentRoute') ?? '/';
    notifyListeners();
  }
}
