import 'package:flutter_bloc/flutter_bloc.dart';
import '../../db/budgetDatabase.dart';

part 'NewEntryEvent.dart';
part 'NewEntryState.dart';

class NewEntryBloc extends Bloc<NewEntryEvent, NewEntryState>{
    
  NewEntryBloc() : super(NewEntryInit()){
    // on<InitExpensePage>(_onInitExpense);
    // on<CategoryDropdownPressed>(_onCategoryDropdownPressed);
  }
}