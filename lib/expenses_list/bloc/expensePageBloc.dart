import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../../db/budget_database.dart';

import '../../models/expenseItem.dart';

part 'expense_event.dart';
part 'expense_state.dart';

enum Dropdown {expense, income, budget}

//longpress on record will be a UI problem
//AddEntryPressed is also a UI problem

class ExpensePageBloc extends Bloc<ExpenseEvent, ExpenseState>{
  ExpensePageBloc() : super(ExpenseInitialized()){
    on<InitExpensePage>(_onInitExpense);
  }
  
  void _onInitExpense(InitExpensePage event, Emitter<ExpenseState> emit){
    //initializes the page: 
      // add options to Year Dropdown
      // add options to Month Dropdown
      // add options to Category Dropdown
      // show all data in table
    final BudgetDatabase _db = BudgetDatabase.instance;
    List<String> categoryOptions = [''];
    
    categoryOptions = _db.categoryOptions(Dropdown.expense) as List<String>;
    
  }
}