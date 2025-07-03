import 'package:flutter/cupertino.dart';

class ThemeToggleButtonController extends ChangeNotifier{
  bool _isLightThemeSelect = true ;
  bool get isisLightThemeSelect => _isLightThemeSelect;
  isisLightThemeSelect ? themeSelect
  void onSelectTheme(){
    _isLightThemeSelect = !_isLightThemeSelect  ;
    notifyListeners();
  }

}