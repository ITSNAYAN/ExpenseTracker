import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/component/customAppBar/testabc.dart';
import 'package:hive/hive.dart';

class ThemeToggleButtonController extends ChangeNotifier {
  bool _isLightThemeSelect = true;

  bool get isLightThemeSelect => _isLightThemeSelect;

  ThemeMode get currentTheme => _isLightThemeSelect ? ThemeMode.light : ThemeMode.dark;

  ThemeToggleButtonController() {
    _loadAppTheme();
  }

  Future<void> _loadAppTheme() async {
    final box = await Hive.openBox("Setting");
    _isLightThemeSelect = box.get(isLightThemeSelect, defaultValue: true);
    notifyListeners();
  }

  Future<void> onSelectTheme() async {
    _isLightThemeSelect = !_isLightThemeSelect;
    final box = await Hive.openBox("Setting");
    await box.put("isLightTheme", _isLightThemeSelect);
    notifyListeners();
  }
}
