import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LanguageChangeController extends ChangeNotifier {
  bool _isEnglish = true;

  bool get isEnglish => _isEnglish;

  void selectLanguage() {
    _isEnglish = !_isEnglish;
    notifyListeners();
  }

  Widget languageChangeButton(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(right: 14.0),
      child: Container(
        height: screenWidth*0.09,
        width: screenWidth*0.09,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).colorScheme.secondary, width: 1),
        ),
        child: InkWell(
          onTap: () {
            selectLanguage();
          },
          child: _isEnglish ? _languageText("A", Theme.of(context).colorScheme.secondary) : _languageText("अ", Theme.of(context).colorScheme.secondary),
        ),
      ),
    );
  }

  Center _languageText(String text, Color color) => Center(
    child: Text(
      text,
      style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}
