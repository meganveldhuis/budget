import 'package:budgetapp/models/expenseItem.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../db/budgetDatabase.dart';
import 'package:budgetapp/models/expenseItem.dart';
import 'package:budgetapp/models/incomeItem.dart';

part 'NewEntryEvent.dart';
part 'NewEntryState.dart';

class NewEntryBloc extends Bloc<NewEntryEvent, NewEntryState>{
    
  NewEntryBloc() : super(NewEntryInit()){
    // on<InitExpensePage>(_onInitExpense);
    // on<CategoryDropdownPressed>(_onCategoryDropdownPressed);
  }
}

//CUBITS:
  // Toggle Entry (is income or is expense)
  // Date Entry (update Date chosen on UI)
  // Toggle Trip (is it a trip, update UI)

//EVENTS
  // btn pressed

//STATES
  // submitting
  // resetting
  // error