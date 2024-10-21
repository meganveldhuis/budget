// import 'package:english_words/english_words.dart';
//import 'package:budgetapp/pages/first_page.dart';
//import 'package:budgetapp/pages/home.dart';

//import '../my_app_state.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart'; //for .watch
import 'package:flutter_bloc/flutter_bloc.dart';
import 'db/budget_database.dart';

//import pages:
import 'widget/dialogs/sidenavbar.dart';

void main() {
  runApp(MyApp(budgetDB: budgetDatabase.instance));
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key, required budgetDatabase budgetDB})
    : _budgetDB = budgetDB,
      super(key: key);
  // budgetDatabase budgetDB.instance;

  final budgetDatabase _budgetDB;

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