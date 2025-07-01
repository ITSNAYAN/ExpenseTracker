import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/core/helperFunction/convert_function.dart';
import 'package:flutter_expense_tracker/expense_database/expense_adapter.dart';
import 'package:flutter_expense_tracker/expense_database/hive_intializer.dart';
import 'package:hive/hive.dart';

class HomepageController extends ChangeNotifier {
  TextEditingController descriptionText = TextEditingController();
  TextEditingController amountText = TextEditingController();
  DateTime _dateTime = DateTime.now();
  List<ExpenseAdapter> _expenseData = [];
  List<int> _expenseKeys = [];

  List<ExpenseAdapter> get expenseData => _expenseData;

  //Read Database
  void fetchData() {
    final box = Hive.box<ExpenseAdapter>(HiveInitializer.boxName);
    _expenseData = box.values.toList();
    _expenseKeys = box.keys.cast<int>().toList();
    // for (int i = 0; i < _expenseData.length; i++) {
    //   print("KEY: ${_expenseKeys[i]} | DateTime: ${_expenseData[i].dateTime}");
    // }
    notifyListeners();
  }

  //open new ExpenseBox
  void openNewExpense(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xfff7f6cf),
        title: Text("New Expense"),
        actions: [_cancelButton(context), _createNewDataBase(context)],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(hintText: "Description"),
              controller: descriptionText,
            ),
            TextField(
              decoration: InputDecoration(hintText: "Amount"),
              controller: amountText,
            ),
          ],
        ),
      ),
    );
  }

  // Save Button
  Widget _createNewDataBase(BuildContext context) {
    final box = Hive.box<ExpenseAdapter>(HiveInitializer.boxName);
    return MaterialButton(
      onPressed: () async {
        if (descriptionText.text.isNotEmpty && amountText.text.isNotEmpty) {
          // P O P  B O X
          Navigator.pop(context);
          //  C R E A T E   A   N E W  E X P E N S E
          final newExpense = ExpenseAdapter(
            description: descriptionText.text,
            amount: convertStringToDouble(amountText.text),
            dateTime: DateTime.now(),
          );
          await box.add(newExpense); //  S A V E    I N    D A T A B A S E
          descriptionText.clear(); // clearing controller
          amountText.clear();
          fetchData(); // F E T C H  D A T A
          notifyListeners();
        }
      },
      child: Text("Save"),
    );
  }

  // Update  New ExpenseBOX
  void updateNewExpense(
    BuildContext context,
    ExpenseAdapter expenses,
    int index,
  ) {
    descriptionText.text = expenses.description!;
    amountText.text = expenses.amount.toString();
    descriptionText.selection = TextSelection.fromPosition(
      TextPosition(offset: descriptionText.text.length),
    );
    amountText.selection = TextSelection.fromPosition(
      TextPosition(offset: amountText.text.length),
    );
    final key =
        _expenseKeys[index]; // for syncing the internal key of hive in case if it take index of listUi
    // List index ≠ Hive key — always use keyAt(index) for update/delete!"
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Expense"),
        actions: [
          _editExpenseButton(context, expenses, key),
          _cancelButton(context),
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            TextField(
              decoration: InputDecoration(labelText: descriptionText.text),
              controller: descriptionText,
            ),
            TextField(
              decoration: InputDecoration(hintText: amountText.text),
              controller: amountText,
            ),
          ],
        ),
      ),
    );
  }

  Widget _editExpenseButton(
    BuildContext context,
    ExpenseAdapter expense,
    int index,
  ) {
    final box = Hive.box<ExpenseAdapter>(HiveInitializer.boxName);
    return MaterialButton(
      onPressed: () async {
        if (descriptionText.text.isNotEmpty || amountText.text.isNotEmpty) {
          Navigator.pop(context);
          ExpenseAdapter updatedExpense = ExpenseAdapter(
            description: descriptionText.text.isNotEmpty
                ? descriptionText.text
                : expense.description,
            amount: amountText.text.isNotEmpty
                ? convertStringToDouble(amountText.text)
                : expense.amount,
            dateTime: _dateTime,
          );
          final key =
              index; // Safely get key from index before updating to avoid key mismatch
          await box.put(key, updatedExpense);
          descriptionText.clear();
          amountText.clear();
          fetchData();
          notifyListeners();
        }
      },
      child: Text("Update"),
    );
  }

  // Delete ExpenseBOX
  void deleteExpense(BuildContext context, ExpenseAdapter expenses, int index) {
    final key = _expenseKeys[index];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Expense"),
        actions: [
          _deleteExpenseButton(context, expenses, key),
          _cancelButton(context),
        ],
      ),
    );
  }

  //Delete Button
  Widget _deleteExpenseButton(
    BuildContext context,
    ExpenseAdapter expenses,
    int index,
  ) {
    final box = Hive.box<ExpenseAdapter>(HiveInitializer.boxName);
    return MaterialButton(
      onPressed: () async {
        Navigator.pop(context);
        final key = index;
        await box.delete(key);
        fetchData();
        notifyListeners();
      },
      child: Text("Delete"),
    );
  }

  // Cancel Button
  Widget _cancelButton(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text("Cancel"),
    );
  }
}
