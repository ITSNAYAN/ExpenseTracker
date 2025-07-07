import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/controller/home_page_controller.dart';
import 'package:flutter_expense_tracker/core/appLocalization/app_localizations.dart';
import 'package:flutter_expense_tracker/core/component/customAppBar/customAppBar.dart';
import 'package:flutter_expense_tracker/core/component/my_list_tile.dart';
import 'package:flutter_expense_tracker/core/helperFunction/convert_function.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Use addPostFrameCallback to safely call Provider after the first frame is built.
  // This avoids calling context too early during initState.

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomepageController>(context, listen: false).fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _controller = Provider.of<HomepageController>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(text: AppLocalizations.of(context)!.homeScreenTitle),
        floatingActionButton: FloatingActionButton(onPressed: () => _controller.openNewExpense(context), child: Icon(Icons.add)),
        // bottomNavigationBar: Padding(
        //   padding: const EdgeInsets.only(right: 12,left: 12,bottom: 50),
        //   child: CustomBottomNavigationButton(),
        // ),
        body: Stack(
          children: [
            SafeArea(
              child: Consumer<HomepageController>(
                builder: (context, value, child) {
                  final loadExpenses = value.expenseData;
                  return loadExpenses.isEmpty
                      ? Center(child: Text("No Such data"))
                      : ListView.builder(
                          itemCount: loadExpenses.length,
                          itemBuilder: (context, index) {
                            final expense = loadExpenses[index];
                            String? formatDateValue = formatDate(expense.dateTime!);
                            return MyListTile(
                              leading: formatDateValue.toString(),
                              title: expense.description!,
                              trailing: expense.amount.toString(),
                              onEditPressed: (context) => _controller.updateNewExpense(context, expense, index),
                              onDeletePressed: (context) => _controller.deleteExpense(context, expense, index),
                            );
                          },
                        );
                },
                child: Column(children: []),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
