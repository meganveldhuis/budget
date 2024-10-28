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
  
  
  ExpensePageBloc() : super(ExpenseInitializing()){
    on<InitExpensePage>(_onInitExpense);
    on<CategoryDropdownPressed>(_onCategoryDropdownPressed);
  }
  
  void _onInitExpense(InitExpensePage event, Emitter<ExpenseState> emit) async{
    //initializes the page: 
      // add options to Year DropdownS
      // add options to Month Dropdown
      // add options to Category Dropdown
      // show all data in table
    final BudgetDatabase _db = BudgetDatabase.instance;
    List<String> categoryOptions = [''];
    
    categoryOptions = await _db.categoryOptions(Dropdown.expense);
    emit(ExpenseInitialized(categories: categoryOptions));
  }

  void _onCategoryDropdownPressed(CategoryDropdownPressed event, Emitter<ExpenseState> emit){

  }
}