import 'package:flutter/cupertino.dart';
import 'package:flutter_expense_tracker/core/expense_database/expense_adapter.dart';


class BarScreenController extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  List<ExpenseAdapter> _allExpenses = [];

  int getStartMonth() {
    if (_allExpenses.isEmpty) return DateTime.now().month;
    _allExpenses.sort((a, b) => a.dateTime!.compareTo(b.dateTime!));
    return _allExpenses.first.dateTime!.month;
  }

  int getStartYear() {
    if (_allExpenses.isEmpty) return DateTime.now().year;
    _allExpenses.sort((a, b) => a.dateTime!.compareTo(b.dateTime!));
    return _allExpenses.first.dateTime!.year;
  }
  void scrollToCurrentMonth(int currentMonthIndex, double barWidth, double spaceBetween, BuildContext context) {
    final double offset = (barWidth + spaceBetween) * currentMonthIndex - MediaQuery.of(context).size.width / 2;


    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          offset.clamp(0, scrollController.position.maxScrollExtent),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }
}
