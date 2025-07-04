import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeToggleButtonController extends ChangeNotifier{
  bool _isLightThemeSelect = true ;
  bool get isLightThemeSelect => _isLightThemeSelect;
  ThemeMode get  currentTheme => _isLightThemeSelect ? ThemeMode.light: ThemeMode.dark;
  void onSelectTheme(){
    _isLightThemeSelect = !_isLightThemeSelect  ;
    notifyListeners();
  }

}