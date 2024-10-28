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
        BlocProvider(
          create: (context) => InitExpensePageBloc(),
          child:
          //Category Dropdown (expenses only). 
            DropdownButton(items: options, onChanged: changestate)
        ),
      )
    )
  }
}