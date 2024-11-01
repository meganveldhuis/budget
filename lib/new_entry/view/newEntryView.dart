// NEW ENTRY (income or expense)
import 'package:budgetapp/new_entry/bloc/NewEntryBloc.dart';
import 'package:budgetapp/expensesList/expensesList.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import '../bloc/NewEntryCubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

const double padding = 20;

class NewEntryView extends StatelessWidget{

  NewEntryView({super.key});

   @override
    Widget build(BuildContext context) {
      return Center(
        child: BlocProvider<ToggleEntryCubit>(
                    create: (_) => ToggleEntryCubit(false),
                    child: isIncomeSwitch()
                    )
      );
  }
}

// class NewExpenseView extends StatelessWidget {
//   const NewExpenseView({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Placeholder();
//   }
// }

class isIncomeSwitch extends StatelessWidget {
  isIncomeSwitch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80), 
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[Colors.blue, Colors.pink],
            ),
          ),
          child: AppBarContent()
        )
      ),
      body: 
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Expense",
                      style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.8),
                    )
                  ),

                  Switch(
                    value: context.watch<ToggleEntryCubit>().state,
                    onChanged: (value){
                      context.read<ToggleEntryCubit>().toggle();
                    },
                  ),

                  RichText(
                    text: TextSpan(
                      text: "Income",
                      style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.8),
                    )
                  ),
                ],
              ),
            ),
            
            Visibility(
              visible: !context.watch<ToggleEntryCubit>().state,
              child: ExpenseFormView()
            ),
            Visibility(
              visible: context.watch<ToggleEntryCubit>().state,
              child: IncomeFormView()
            ),
          ]
        ),
    );
  }
}

class IncomeFormView extends StatelessWidget {
  const IncomeFormView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(initialValue: 'ON',);
  }
}

class ExpenseFormView extends StatelessWidget {
  ExpenseFormView({
    super.key,
  });
  DateTime now = DateTime.now();
  DateTime selectedDate = DateTime.now();
  bool isTrip = false;
  
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime(now.year, now.month, now.day);
    Future<DateTime> chosenDate;
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: padding),
          DatePicker(),
          SizedBox(height: padding),
          Text('Amount:'),
          TextField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[\d\.]')),
            ],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Amount paid",
              border: OutlineInputBorder(),
            )
          ),
          SizedBox(height: padding),
          Text('Name:'),
          TextField(
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            )
          ),
          SizedBox(height: padding),
          Text('Category:'),
          categoryDropdown(),
          SizedBox(height: padding),
          Text('Trip:'),
          Checkbox(
            value: isTrip, 
            onChanged: null //ToggleTripCubit
          ),
        ]
      ),
    );
  }
}

class categoryDropdown extends StatelessWidget {
  const categoryDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return 
      BlocBuilder<ExpensePageBloc, ExpenseState>(
        builder: (context, state) {
          List<String> categoryStrings = [];
          print(state);
          if (state is ExpenseInitializing){
            context.read<ExpensePageBloc>().add(InitExpensePage());
          }
          if (state is ExpenseInitialized){
            categoryStrings = state.categories;
          }
          List<DropdownMenuEntry> categoryItems = [];
          for(String i in categoryStrings){ //this will give elements in the list
            categoryItems.add(
              DropdownMenuEntry(
                label: i,
                value: i
              )
            );
          }
          return DropdownMenu(
            label: const Text('Filter by Category'),
            width: 200.0,
            enableFilter: true,
            enableSearch: true,
            dropdownMenuEntries: categoryItems,
            onSelected: (dynamic chosenCategory){
                  context.read<ExpensePageBloc>().add(CategoryDropdownPressed(chosenCategory as String));
            },
          );
        }
      );
  }
}

class DatePicker extends StatelessWidget {
  const DatePicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            text: "Date:",
            style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5),
          )
        ),
        BlocBuilder<DateEntryCubit, DateTime>(
          builder: (context, state) {
            return
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: 
                  Text(
                    "${context.watch<DateEntryCubit>().state.toLocal()}".split(' ')[0],
                  ),
              );
          }
        ),
      ]
    );
  }
}

_selectDate(BuildContext context) async {
  
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: context.read<DateEntryCubit>().chosenDate,
    firstDate: DateTime(2020),
    lastDate: DateTime(2025),
  );
  
  if (picked != null && picked !=  context.read<DateEntryCubit>().chosenDate){
    context.read<DateEntryCubit>().updateDate(picked);
  }
}


class AppBarContent extends StatelessWidget {
  const AppBarContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
              child: RichText(
                text: TextSpan(
                  text: "Add New Entry",
                  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
                )
              ),
            );
    
    // Column(
    //   mainAxisAlignment: MainAxisAlignment.end,
    //   children: <Widget>[
    //     Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 10),
    //       child: Row(
    //         children: <Widget>[
    //           const Text(
    //             'fuck this',
    //             style: TextStyle(color: Colors.white),
    //           ),
    //           const Spacer(),
    //           IconButton(
    //             icon: const Icon(
    //               Icons.search,
    //               size: 20,
    //             ),
    //             color: Colors.white,
    //             onPressed: () {},
    //           ),
    //           IconButton(
    //             icon: const Icon(
    //               Icons.more_vert,
    //               size: 20,
    //             ),
    //             color: Colors.white,
    //             onPressed: () {},
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
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


