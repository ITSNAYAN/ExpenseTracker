import 'package:flutter/cupertino.dart';

class ThemeToggleButtonController extends ChangeNotifier{
  bool isThemeSelect = true ;

  void onSelectTheme(){
    isThemeSelect = !isThemeSelect  ;
    notifyListeners();
  }

}