part of 'NewEntryBloc.dart';

sealed class NewEntryEvent{
  const NewEntryEvent();
}

class EntryBtnPressed extends NewEntryEvent{
  bool isIncome = false;
  // final ExpenseItem to = 
  String date;
  // String timestamp;
  // String name;
  // int categoryID;
  // int tripID;
  // Float amount;
  // int currencyID;


  EntryBtnPressed(this.isIncome, this.date);
}
