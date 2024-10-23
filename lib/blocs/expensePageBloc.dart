import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../db/budget_database.dart';

import '../models/expenseItem.dart';


//longpress on record will be a UI problem
//AddEntryPressed is also a UI problem


//EVENTS ON THIS PAGE
    // InitExpensePage
    // CategoryDropdownPressed
    // DateDropdownPressed


//states   (UI changes that doesn't change the pages)
  // initialized!
  // updateTable
  // updateDropdown

sealed class ExpenseEvent{
  const ExpenseEvent();
}

class InitExpensePage extends ExpenseEvent{
  //initializes the page: 
      // add options to Year Dropdown
      // add options to Month Dropdown
      // add options to Category Dropdown
      // show all data in table
  //no inputs needed...
  const InitExpensePage();  
}

// class CategoryDropdownPressed extends ExpenseEvent{
//   //inputs?
// }

// class DateDropdownPressed extends ExpenseEvent{
//   //inputs?
// }

sealed class ExpenseState{
  const ExpenseState();
}

class ExpenseInitialized extends ExpenseState{

}
// class ExpenseUpdateTable extends ExpenseState{}

// class ExpenseupdateDropdown extends ExpenseState{}



class ExpensePageBloc extends Bloc<ExpenseEvent, ExpenseState>{
  final BudgetDatabase _db = BudgetDatabase.instance;

  ExpensePageBloc(this._db) : super(){
    on<InitExpensePage>((event, emit) {
      
    });
  }
}