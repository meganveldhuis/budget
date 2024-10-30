part of 'expensePageBloc.dart';


//states   (UI changes that doesn't change the pages)
  // initialized!
  // updateTable
  // updateDropdown

enum DropdownButtons {year, month, category}

sealed class ExpenseState{
  const ExpenseState();
  // add inputs that are in all of the states here
}

class ExpenseInitialized extends ExpenseState{
  final List<String> categories;
  final List<String> yearOptions;
  final List<String> monthOptions;
  const ExpenseInitialized({required this.categories, required this.yearOptions, required this.monthOptions}); 
}

class ExpenseInitializing extends ExpenseState{
  const ExpenseInitializing(); 
  //no inputs needed for initialization step
}

class DropdownUpdated extends ExpenseState{
  final DropdownButtons whichOneTho;
  const DropdownUpdated({required this.whichOneTho});
}

//dropdownUpdated state


// class ExpenseUpdateTable extends ExpenseState{}

// class ExpenseupdateDropdown extends ExpenseState{}