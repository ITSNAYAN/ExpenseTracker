import 'package:flutter/cupertino.dart';

class ScrollAwareController extends ChangeNotifier{
  bool _isVisible = true ;
  double _previousOffset = 0;
  bool get isVisible => _isVisible;
  void updateVisibility (double offset ){
    if(offset>_previousOffset+5 && _isVisible){
      _isVisible= false ;
    }else if (offset<_previousOffset-5 && !_isVisible ){
      _isVisible =true ;
    }
     _previousOffset =offset;

    notifyListeners();

  }
}