import 'package:flutter/cupertino.dart';
import 'package:flutter_expense_tracker/component/indiviual_bar.dart';
import 'package:flutter_expense_tracker/core/helperFunction/convert_function.dart';
import 'package:flutter_expense_tracker/expense_database/expense_adapter.dart';
import 'package:flutter_expense_tracker/expense_database/hive_intializer.dart';
import 'package:hive_flutter/adapters.dart';

class BarScreenController extends ChangeNotifier {
  final box = Hive.box<ExpenseAdapter>(HiveInitializer.boxName);
  List<ExpenseAdapter> _allExpenses = [];

  Future<Map<int, double>>? _monthlyTotalsFuture;
  Future<Map<int, double>> get monthlyTotalsFuture => _monthlyTotalsFuture ?? Future.value({});

  Future<void> initController() async {
    _allExpenses = box.values.toList();
    _monthlyTotalsFuture = calculateMonthlyTotals(); // assign the correct Future
    notifyListeners();
  }

  List<double> generate12MonthSummary(Map<int, double> monthlyTotals, int year) {
    return List.generate(12, (index) {
      int month = index + 1;
      int key = year * 100 + month;
      return monthlyTotals[key] ?? 0.0;
    });
  }

  Future<Map<int, double>> calculateMonthlyTotals() async {
    final List<ExpenseAdapter> allExpenses = box.values.toList();
    Map<int, double> map = {};

    for (var expense in allExpenses) {
      final date = expense.dateTime!;
      int key = date.year * 100 + date.month; // calculated key to sort the list accordingly

      if (!map.containsKey(key)) {
        map[key] = expense.amount!;
      } else {
        map[key] = map[key]! + expense.amount!;
      }
    }

    return map;
  }

  //get Starting month
  int getStartMonth() {
    _allExpenses = box.values.toList();
    if (_allExpenses.isEmpty) {
      return DateTime.now().month;
    }
    //sort Expenses to find the date at earliest
    _allExpenses.sort((a, b) => a.dateTime!.compareTo(b.dateTime!));
    return _allExpenses.first.dateTime!.month;
  }

  int getStartYear() {
    _allExpenses = box.values.toList();
    if (_allExpenses.isEmpty) {
      return DateTime.now().year;
    }
    //sort Expenses to find the date at earliest
    _allExpenses.sort((a, b) => a.dateTime!.compareTo(b.dateTime!));
    return _allExpenses.first.dateTime!.year;
  }
}
