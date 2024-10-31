// NEW ENTRY (income or expense)
import 'package:flutter/material.dart';
import '../bloc/NewEntryCubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class NewEntryView extends StatelessWidget{

  NewEntryView({super.key});

   @override
    Widget build(BuildContext context) {
      return NewExpenseView();
  }
}

class NewExpenseView extends StatelessWidget {
  const NewExpenseView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return 
      Center(
        child: BlocProvider<ToggleEntryCubit>(
                    create: (_) => ToggleEntryCubit(false),
                    child: isIncomeSwitch()
                    )
      );
  }
}

class isIncomeSwitch extends StatelessWidget {
  isIncomeSwitch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: context.watch<ToggleEntryCubit>().state,
      onChanged: (value){
        context.read<ToggleEntryCubit>().toggle();
      },
    );
  }
}




// switch / btn for income vs expense

// Date Dropdown (I and E)

// Numerical Entry (amount) (I and E)

// Currency Dropdown (I and E)
//    defaults to CAD

// Category Dropdown (I and E)

// Text Entry (name) (E)

// Trip Checkbox (E)
//    if checked : 
//          Trip dropdown (E)

// longer Text Entry (note) (I)

// SUBMIT button (I and E)


