part of 'NewEntryBloc.dart';


sealed class NewEntryState{
  const NewEntryState();
  // add inputs that are in all of the states here
}

class NewEntryInit extends NewEntryState{
  // final List<String> categories;
  // final List<String> yearOptions;
  // final List<String> monthOptions;
  // const ExpenseInitialized({required this.categories, required this.yearOptions, required this.monthOptions}); 
}