part of 'expensePageBloc.dart';

//EVENTS ON THIS PAGE
    // InitExpensePage
    // CategoryDropdownPressed
    // DateDropdownPressed


sealed class ExpenseEvent{
  const ExpenseEvent();
}

class InitExpensePage extends ExpenseEvent{
  //no inputs needed...
  const InitExpensePage();  
}

// class CategoryDropdownPressed extends ExpenseEvent{
//   //inputs?
// }

// class DateDropdownPressed extends ExpenseEvent{
//   //inputs?
// }