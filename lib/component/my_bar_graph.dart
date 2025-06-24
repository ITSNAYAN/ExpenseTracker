import 'indiviual_bar.dart';

class MyBarGraph {
  List<double> monthlySummary; //define monthExpense [200,800,600,100]
  final int startMonth; //01 jan
  MyBarGraph({required this.monthlySummary,required this.startMonth});

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = List.generate(monthlySummary.length, (index) {
      return IndividualBar(x: index, y: monthlySummary[index]);
    });
  }
}