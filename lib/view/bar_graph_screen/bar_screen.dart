import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/controller/bar_screen_controller.dart';
import 'package:flutter_expense_tracker/core/appLocalization/app_localizations.dart';
import 'package:flutter_expense_tracker/core/component/customAppBar/customAppBar.dart';
import 'package:flutter_expense_tracker/core/component/myBarGraph/my_bar_graph.dart';
import 'package:provider/provider.dart';

class BarScreen extends StatefulWidget {
  final ScrollController scrollController ;
  const BarScreen({super.key,required this.scrollController });

  @override
  State<BarScreen> createState() => _BarScreenState();
}

class _BarScreenState extends State<BarScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BarScreenController>(context, listen: false).initController();
      // Provider.of<BarScreenController>(context, listen: false).calculateMonthlyTotals() ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BarScreenController>(
      builder: (context, value, child) {
        // get all Dates
        int startMonth = value.getStartMonth();
        int startYear = value.getStartYear();
        int currentMonth = DateTime.now().month;
        int currentYear = DateTime.now().year;
        // calculate the number of month since the first month and current month
        // int monthCount = calculateMonthCount(startYear, startMonth, currentYear, currentMonth);

        return Scaffold(
          appBar: CustomAppBar(text: AppLocalizations.of(context)!.analysisScreenTitle),
          body: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder(
                  future: value.monthlyTotalsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SingleChildScrollView();
                    }
                    if (snapshot.hasError) {
                      return Text("Error:${snapshot.error}");
                    }
                    final data = snapshot.data ?? {};
                    final monthlySummary = value.generate12MonthSummary(data, startYear);
                    return MyBarGraph(monthlySummary: monthlySummary, startMonth: 1);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
