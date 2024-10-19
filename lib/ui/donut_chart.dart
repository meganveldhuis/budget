import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';


class DonutChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  final List<_PieData> pieData = [
            _PieData('Jack', 25, 'Jack'),
            _PieData('Steve', 38, 'Steve'),
            _PieData('Lucy', 34, 'Lucy'),
            _PieData('Others', 52,'Others')
        ];

 return Center(
   child:SfCircularChart(
   title: ChartTitle(text: 'Sales by sales person'),
   legend: Legend(isVisible: true),
   series: <PieSeries<_PieData, String>>[
     PieSeries<_PieData, String>(
       explode: true,
       explodeIndex: 0,
       dataSource: pieData,
       xValueMapper: (_PieData data, _) => data.xData,
       yValueMapper: (_PieData data, _) => data.yData,
       dataLabelMapper: (_PieData data, _) => data.text,
       dataLabelSettings: DataLabelSettings(isVisible: true)
       ),
      ]
    )
  );
  }
}

class _PieData {
 _PieData(this.xData, this.yData, [this.text]);
 final String xData;
 final num yData;
 String? text;
}

class ExpDonutChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  final List<ExpensesPieData> pieData = [
            ExpensesPieData('Groceries', 250),
            ExpensesPieData('Shopping', 38),
            ExpensesPieData('Rent', 34),
            ExpensesPieData('Others', 52)
        ];

 return Center(
   child:SfCircularChart(
   title: ChartTitle(text: 'Money spent per category'),
   legend: Legend(isVisible: true),
   series: <DoughnutSeries<ExpensesPieData, String>>[
     DoughnutSeries<ExpensesPieData, String>(
       explode: false,
       explodeIndex: 0,
       dataSource: pieData,
       xValueMapper: (ExpensesPieData data, _) => data.category,
       yValueMapper: (ExpensesPieData data, _) => data.amount,
       dataLabelMapper: (ExpensesPieData data, _) => data.category,
       dataLabelSettings: DataLabelSettings(isVisible: true),
       ),
      ]
    )
  );
  }
}

class ExpensesPieData{
  ExpensesPieData(this.category, this.amount);
  final String category;
  final num amount;
}