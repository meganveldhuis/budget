//note: adding budget, currencies, and data import/export LATER
// trips to do last

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'db/budgetDatabase.dart';

import 'sidenavbar.dart';

void main() {
  runApp(MyApp(budgetDB: BudgetDatabase.instance));
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key, required BudgetDatabase budgetDB})
    : _budgetDB = budgetDB,
      super(key: key);
  // budgetDatabase budgetDB.instance;

  final BudgetDatabase _budgetDB;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _budgetDB,
      child: MaterialApp(
        title: 'Budget App',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.amber,
        ),
        home: SideNavBar(),
      )
    );
  }
}
    // MaterialApp(
    //     title: 'Budget App',
    //     theme: ThemeData(
    //       useMaterial3: true,
    //       primarySwatch: Colors.amber,
    //     ),
    //     home: 
    //       RepositoryProvider(
    //         create: (context) => 
    //       )
        
    // );