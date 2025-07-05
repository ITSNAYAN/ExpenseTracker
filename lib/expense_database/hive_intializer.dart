import 'package:flutter_expense_tracker/expense_database/expense_adapter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class HiveInitializer {
  static const String boxName = 'expenseBox';

  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ExpenseAdapterAdapter());
    await Hive.openBox<ExpenseAdapter>(boxName);
    await Hive.openBox("Setting");
  }
}
