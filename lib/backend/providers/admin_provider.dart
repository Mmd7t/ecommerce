import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class AdminProvider extends ChangeNotifier {
  bool _isAdmin = false;

  bool get admin => _isAdmin;
  SharedPreferences _prefs;

  AdminProvider() {
    _loadPrefs();
  }

  switchAdmin() {
    _isAdmin = !_isAdmin;
    _savePrefs();
    notifyListeners();
  }

  initPrefs() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  _savePrefs() async {
    await initPrefs();
    _prefs.setBool(adminKey, _isAdmin);
  }

  _loadPrefs() async {
    await initPrefs();
    _isAdmin = _prefs.getBool(adminKey) ?? false;
    notifyListeners();
  }
}
