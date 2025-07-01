import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/component/my_bar_graph.dart';
import 'package:flutter_expense_tracker/controller/bar_screen_controller.dart';
import 'package:flutter_expense_tracker/core/helperFunction/convert_function.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BarScreen extends StatefulWidget {
  const BarScreen({super.key});

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

            appBar: AppBar(title : Center(child: Text("Spend Analysis",style: GoogleFonts.saira(),)), backgroundColor: Colors.transparent),

          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 200.0),
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
                      final data = snapshot.data??{ };
                      final monthlySummary =value.generate12MonthSummary(data, startYear, );
                      return MyBarGraph(monthlySummary: monthlySummary, startMonth: 1);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
