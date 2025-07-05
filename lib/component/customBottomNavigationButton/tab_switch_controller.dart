import 'package:flutter/cupertino.dart';

class TabSwitchController extends ChangeNotifier{
   bool _selectExpenseValue =true ;
   bool get selectExpenseValue => _selectExpenseValue;

  void onTapExpense(){

    _selectExpenseValue = true ;
    notifyListeners();
  }
  void onTapAnalysis(){
    _selectExpenseValue = false ;
    notifyListeners();
  }
}