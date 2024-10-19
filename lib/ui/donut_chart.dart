import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';


class ExpDonutChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  List<ExpensesPieDataClass> pieData = [
    ExpensesPieDataClass('Groceries', 250),
    ExpensesPieDataClass('Shopping', 38),
    ExpensesPieDataClass('Rent', 34),
    ExpensesPieDataClass('Others', 52)
  ];

      return Center(
        child:SfCircularChart(
        title: ChartTitle(text: 'Money spent per category'),
        legend: Legend(isVisible: true),
        series: <DoughnutSeries<ExpensesPieDataClass, String>>[
          DoughnutSeries<ExpensesPieDataClass, String>(
            explode: false,
            explodeIndex: 0,
            dataSource: changeDonut(),
            xValueMapper: (ExpensesPieDataClass data, _) => data.category,
            yValueMapper: (ExpensesPieDataClass data, _) => data.amount,
            dataLabelMapper: (ExpensesPieDataClass data, _) => data.category,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            ),
          ]
        )
      );
    }

}

List<ExpensesPieDataClass>changeDonut(){
  print("heck");
  return List.empty();
}




  class ExpensesPieDataClass{
    ExpensesPieDataClass(this.category, this.amount);
    final String category;
    final num amount;
  }