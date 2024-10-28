//takes input 0 for expense, 1 for income
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../db/budgetDatabase.dart';

// umm need init for page so that the dropdown knows what options to show


enum Dropdown {expense, income, budget}

//initialize the page:
sealed class ExpensePageInit{
  const ExpensePageInit();
}

class ExpenseCategoryDropdownInit extends ExpensePageInit{
  // fill options for the category dropdown (this will be expenses only)
  final Dropdown valueType;
  const ExpenseCategoryDropdownInit({required this.valueType});
}

class InitExpensePageBloc extends Bloc<ExpensePageInit, List>{ //  <event, emit>  : emit is the output

  final BudgetDatabase _db = BudgetDatabase.instance;
  static List<String> categoryOptions = [''];

  InitExpensePageBloc() : super(categoryOptions){
    on<ExpenseCategoryDropdownInit>((event,emit){
      categoryOptions = _db.categoryOptions(event.valueType) as List<String>;
      emit(categoryOptions);
    });
  }
}






// //as a template for next blocs:
// sealed class CategoryEvent{
//   const CategoryEvent();
// }

// class CategoryDropdownPressed extends CategoryEvent{
//   // final Dropdown valueType;
//   // const CategoryDropdownPressed({required this.valueType});
// }

// //isIncome should be an bool. if 0: expense. if 1: income.
// class CategoryOptionsBloc extends Bloc<CategoryEvent, List> {
//   /*
//    * takes input of isIncome (bool)
//    * if isIncome is false, then returns a List of Expense Categories
//    * if isIncome is true, then returns a List of Income Categories
//   */
//     final BudgetDatabase _db = BudgetDatabase.instance;
//   CategoryOptionsBloc() : super(){
//     on<CategoryDropdownPressed>((event, emit){
//       List categories;
//       categories = _db.categoryOptions(valueType) as List;
//       //returns a (future) List of categories where column is_income == isIncome      
//       print(categories);
//       emit(valueType as bool);
//       // return categories;
//     });
//   }
// }