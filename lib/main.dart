// import 'package:english_words/english_words.dart';
import '../my_app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; //for .watch
import 'db/database_service.dart';

//import pages:
import 'ui/sidenavbar.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  MyApp({super.key});
  final DatabaseService _databaseService = DatabaseService.instance;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Budget App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(227, 138, 168, 1)),
        ),
        home: SideNavBar(),
      ),
    );
  }
}