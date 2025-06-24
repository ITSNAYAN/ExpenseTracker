import 'package:flutter/cupertino.dart';
import 'package:flutter_expense_tracker/component/indiviual_bar.dart';
import 'package:flutter_expense_tracker/core/helperFunction/convert_function.dart';
import 'package:flutter_expense_tracker/expense_database/expense_adapter.dart';
import 'package:flutter_expense_tracker/expense_database/hive_intializer.dart';
import 'package:hive_flutter/adapters.dart';

class BarScreenController extends ChangeNotifier {
  Future<Map<String, double>> calculateMonthlyTotals() async {
    final box = Hive.box<ExpenseAdapter>(HiveInitializer.boxName);
    final List<ExpenseAdapter> allExpenses = await box.values.toList();
    Map<String, double> map = {};
    for (var expense in allExpenses) {
      final month = formatDate(expense.dateTime!);
      if (!map.containsKey(month)) {
        map[month!] = expense.amount!;
      } else {
        map[month!] = map[month]! + expense.amount!;
      }
    }
    return map;
  }
}
