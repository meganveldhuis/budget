part of 'expensePageBloc.dart';


//states   (UI changes that doesn't change the pages)
  // initialized!
  // updateTable
  // updateDropdown



sealed class ExpenseState{
  const ExpenseState();
  // add inputs that are in all of the states here
}

class ExpenseInitialized extends ExpenseState{
  const ExpenseInitialized(); 
  //no inputs needed for initialization step
}
// class ExpenseUpdateTable extends ExpenseState{}

// class ExpenseupdateDropdown extends ExpenseState{}