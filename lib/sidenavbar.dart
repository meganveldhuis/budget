import 'package:budgetapp/expensesList/bloc/expensePageBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../pages/entry.dart';
import 'settings/view/settings_view.dart';
import 'overview/view/homeView.dart';
import 'expensesList/view/expenseView.dart';


class SideNavBar extends StatefulWidget{
  @override
  State<SideNavBar> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SideNavBar> { //underscore at beginning of name == private class
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context){
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomePage();
      case 1:
        page = SettingsPage();
      case 2:
        // page = ExpensesPage();
        page = BlocProvider<ExpensePageBloc>(
                    create: (context) => ExpensePageBloc(),
                    child: ExpensesPage()
                );
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }


    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea( //ensure it is not obscured by a hardware notch / status bar
                child:NavigationRail(
                  // extended: false, //if true, shows labels next to the icons
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home), 
                      label: Text('Home')
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite), 
                      label: Text('Favourites')
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.receipt_long), 
                      label: Text('Expenses List')
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value){
                    setState((){
                      selectedIndex = value;
                    });
                  },
                )
              ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
            ],
            ),  
        );
      }
    );
  }
}