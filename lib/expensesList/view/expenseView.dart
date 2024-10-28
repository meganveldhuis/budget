// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

/* 
 * BLOCS:
 *    - YearDropdownOptionsBloc
 *    - MonthDropdownOptionsBloc
 *    - CategoryOptionsBloc <expenses>
 *    - UpdateExpenseTableBloc
 * 
 * CUBITS:
*/

// page list at top
// YearDropdown
// MonthDropdown
// CategoryDropdown
// ExpensesTable

// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/expensePageBloc.dart';


class ExpensesPage extends StatelessWidget{
  ExpensesPage({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: ,
      body: Center(
        child: 
          BlocBuilder<ExpensePageBloc, ExpenseState>(
            builder: (context, state) {
              List<String> categoryStrings = [];
              print(state);
              if (state is ExpenseInitializing){
                context.read<ExpensePageBloc>().add(InitExpensePage());
              }
              if (state is ExpenseInitialized){
                categoryStrings = state.categories;
              }
              List<DropdownMenuEntry> categoryItems = [];
              for(String i in categoryStrings){ //this will give elements in the list
                categoryItems.add(
                  DropdownMenuEntry(
                    label: i,
                    value: i
                  )
                );
              }
              return DropdownMenu(
                label: const Text('Filter by Category'),
                width: 200.0,
                enableFilter: true,
                enableSearch: true,
                dropdownMenuEntries: categoryItems,
                onSelected: (dynamic chosenCategory){
                      context.read<ExpensePageBloc>().add(CategoryDropdownPressed(chosenCategory as String));
                },
              );
            }
          )
              // DropdownButton(
              //     items: categoryItems, 
              //     onChanged: 
              //       (dynamic chosenCategory){
              //         context.read<ExpensePageBloc>().add(CategoryDropdownPressed(chosenCategory as String));
              //     },
              //     value: state is DropdownUpdated && state.whichOneTho == DropdownButtons.category? state.chosenCategory : oldValue;
              // );
              // ideally we have blocbuilder around dropdownbutton so we can control a buildwhen
              // CONTAINER with all dropdowns. separate one for table and one for each of the dropdowns 
            
          
      )
    );
  }
}
