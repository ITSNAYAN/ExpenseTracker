import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  final List<double> monthlySummary;
  final int startMonth;

  const MyBarGraph({
    super.key,
    required this.monthlySummary,
    required this.startMonth,
  });

  @override
  Widget build(BuildContext context) {
    double barWidth =20;
    double spaceBetween = 15;

    return AspectRatio(
      aspectRatio: 1.2,
      child: SizedBox(
        height: 300,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: (monthlySummary.reduce((a, b) => a > b ? a : b)) + 20,
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            backgroundColor: Colors.red,
            // barTouchData: BarTouchData(enabled: true),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 100, // Adjust based on your range
                  getTitlesWidget: (value, _) => Padding(
                    padding: const EdgeInsets.only(right: 8.0,left: 10.0),
                    child: value>=1000? Text(
                      "${(value.toDouble())~/1000}K",
                      style: const TextStyle(fontSize: 10),
                    ):Text(
                      (value.toInt().toString()),
                      style: const TextStyle(fontSize: 10),
                    ) ,
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
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        monthName(month),
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    );
                  },
                ),
              ),
            ),

            barGroups: monthlySummary
                .asMap()
                .entries
                .where((entry) => entry.value >= 0.0)
                .map((entry) => BarChartGroupData(
              x: entry.key,
              barRods: [
                BarChartRodData(
                  toY: entry.value,
                  width: 20,
                  color: entry.value == 0.0 ? Colors.black : Colors.black,

                  borderRadius: BorderRadius.zero,
                )
              ],
            ))
                .toList(),

          ),
        ),
      ),
    );
  }

  String monthName(int monthNumber) {
    const monthNames = [
      "", // dummy for 0
      "J", "F", "M", "A", "M", "J",
      "J", "A", "S", "O", "N", "D"
    ];
    return monthNames[monthNumber];
  }
}
