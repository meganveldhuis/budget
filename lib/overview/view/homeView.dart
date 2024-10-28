// import 'package:provider/provider.dart';
// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../db/budgetDatabase.dart';

import '../widgets/donutChart.dart';
// import '../my_app_state.dart';

enum Dropdown {expense, income, budget}


class HomePage extends StatelessWidget{
  
  final BudgetDatabase _databaseService = BudgetDatabase.instance;
  // const HomePage({Key? key, required this.title}) : super(key: key);
  String? _task = null;

  HomePage({super.key});

  @override
  
  Widget build(BuildContext context){
    return 
    // ExpDonutChart();
      Scaffold (
        body: Column(
          children: [
            ExpDonutChart(),
            GestureDetector(
                onTap: () {
                  _databaseService.printCategories();
                  // _databaseService.categoryOptions(Dropdown.expense);
                },
                child: Container(
                  width: 300,
                  height: 30,
                  color: const Color.fromARGB(255, 68, 68, 198),
                  child: const Center(
                      child: Text(
                    "Print category data",
                    style: TextStyle(color: Colors.white),
                  )),
            ))
          ],
        ),
        floatingActionButton: _addTaskButton(context),
          // const Center(
          //   child: 
          //   // Text('Hello World!'),
          //   DonutChart,
          // )
      );
  }

  Widget _addTaskButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Add Task'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                  //  setState(() {
                      _task = value;
                   // });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Task Name...',
                  ),
                ),
                MaterialButton(
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    if (_task == null || _task == "") return; //don't add a null task
                    // _databaseService.addTask(_task!);
                    _databaseService.createCategory(_task!,'this is the description',0);
                    //setState(() {
                      _task = null;
                    //});
                    Navigator.pop(
                      context,
                    );
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: const Icon(
        Icons.add,
      ),
    );
  }
}

