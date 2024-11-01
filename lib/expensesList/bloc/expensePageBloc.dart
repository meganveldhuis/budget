import 'package:flutter_bloc/flutter_bloc.dart';
import '../../db/budgetDatabase.dart';

// import '../../models/expenseItem.dart';

part 'expenseEvent.dart';
part 'expenseState.dart';


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
      // add options to Year Dropdown
      // add options to Month Dropdown
      // add options to Category Dropdown
      // show all data in table
    final BudgetDatabase _db = BudgetDatabase.instance;
    List<String> categoryOptions = [''];
    List<String> yearOptions = ['2022','2023','2024'];
    List<String> monthOptions = ['January','February','March','April'];
    
    categoryOptions = await _db.categoryOptions(Dropdown.expense);
    emit(ExpenseInitialized(categories: categoryOptions, yearOptions: yearOptions, monthOptions: monthOptions));
  }

  void _onCategoryDropdownPressed(CategoryDropdownPressed event, Emitter<ExpenseState> emit){

  }
}