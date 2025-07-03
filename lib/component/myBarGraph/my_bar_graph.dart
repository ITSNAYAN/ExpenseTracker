import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/core/helperFunction/convert_function.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'my_bar_graph_controller.dart';

class MyBarGraph extends StatefulWidget {
  final List<double> monthlySummary;
  final int startMonth;

  const MyBarGraph({super.key, required this.monthlySummary, required this.startMonth});

  @override
  State<MyBarGraph> createState() => _MyBarGraphState();
}

class _MyBarGraphState extends State<MyBarGraph> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Provider.of< BarScreenController>(context, listen: false);

      int startMonth = controller.getStartMonth();
      int startYear = controller.getStartYear();
      int currentMonth = DateTime.now().month;
      int currentYear = DateTime.now().year;

      int currentMonthIndex = calculateMonthCount(startYear, startMonth, currentYear, currentMonth) - 1;

      controller.scrollToCurrentMonth(currentMonthIndex, 25, 15, context); // Assuming 25 bar width, 15 space
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double barWidth = 20;
    double spaceBetween = 15;
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: widget.monthlySummary.length * 50,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: (widget.monthlySummary.reduce((a, b) => a > b ? a : b)) + 20,
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              // backgroundColor: Colors.red,
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  // tooltipBgColor: Colors.black.withOpacity(0.7),
                  // tooltipRoundedRadius: 10,
                  tooltipPadding: const EdgeInsets.all(8),
                  fitInsideVertically: true, // <--- important!
                  fitInsideHorizontally: true,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem(
                      '₹${rod.toY.toStringAsFixed(0)}',
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),

              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                    interval: 100, // Adjust based on your range
                    getTitlesWidget: (value, _) => Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 10.0),
                      child: value >= 1000
                          ? Text("${(value.toDouble()) ~/ 1000}K", style: const TextStyle(fontSize: 10))
                          : Text((value.toInt().toString()), style: const TextStyle(fontSize: 10)),
                    ),
                    reservedSize: 40,
                  ),
                ),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, _) {
                      final month = (value.toInt() % 12) + 1;
                      return Padding(
                        padding: const EdgeInsets.only(top: 4, left: 3, right: 3),
                        child: Text(monthName(month), style: GoogleFonts.saira(fontSize: 12, fontWeight: FontWeight.w800,color: Color(0xff9b7734))),
                      );
                    },
                  ),
                ),
              ),

              barGroups: widget.monthlySummary
                  .asMap()
                  .entries
                  .where((entry) => entry.value >= 0.0)
                  .map(
                    (entry) => BarChartGroupData(
                      x: entry.key,
                      barRods: [
                        BarChartRodData(
                          toY: entry.value,
                          width: 25,
                          color: entry.value == 0.0 ? Color(0xff9b7734) : Color(0xffad853a),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  String monthName(int monthNumber) {
    const monthNames = [
      "", // dummy for 0
      "J", "F", "M", "A", "M", "J",
      "J", "A", "S", "O", "N", "D",
    ];
    return monthNames[monthNumber];
  }
}
