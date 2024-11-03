// import 'dart:js_interop';

import 'package:budgetapp/new_entry/bloc/NewEntryBloc.dart';
import 'package:budgetapp/expensesList/expensesList.dart';
import 'package:flutter/material.dart';
import '../bloc/NewEntryCubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

import 'package:budgetapp/models/expenseItem.dart';
import 'package:budgetapp/models/incomeItem.dart';
// import 'dart:ffi';

const double padding = 20;

class NewEntryView extends StatelessWidget{

  NewEntryView({super.key});

   @override
    Widget build(BuildContext context) {
      return Center(
        child: SwitchView()
      );
  }
}

class SwitchView extends StatelessWidget {
  SwitchView({
    super.key,
  });  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        SingleChildScrollView(
          child: Column(
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
  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
  // var newExpenseItem;
  ExpenseItem newExpenseItem = ExpenseItem(
    date: '', 
    timestamp: '', 
    name: '', 
    categoryID: 0, 
    tripID: 0, 
    amount: 0,
    currencyID: 0
  );
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: padding),
            DatePicker(),
            SizedBox(height: padding),
            Text(
              'Amount:',
              style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.2)
            ),
            SizedBox(
              width: 200,
              child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d\.]')),
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Amount paid",
                  border: OutlineInputBorder(),
                ),
                validator: (String? value){
                  if(value==null || value.isEmpty){
                    return 'Please enter some text';
                  }
                  return null;
                }
                // onEditingComplete: () {newExpenseItem.name = value;},
              ),
            ),
            SizedBox(height: padding),
            Text(
              'Name:',
              style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.2)
            ),
            TextField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              )
            ),
            SizedBox(height: padding),
            Text(
              'Category:',
              style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.2)
            ),
            ExpenseCategoryDropdown(),
            SizedBox(height: padding),
            TripWidget(),
            ElevatedButton(
              // style: buttonStyle,
              onPressed: () {},
              child: const Text('Submit'),
            ),
          ]
        ),
      ),
    );
  }
}

class TripWidget extends StatelessWidget {
  const TripWidget({ super.key});

  @override
  Widget build(BuildContext context) {
    return 
      BlocBuilder<ToggleTripCubit, bool>(
        builder: (context, state) {

          return Row(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children:[
                      Text(
                        'Trip:',
                        style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.2)
                      ),
                      Checkbox(
                        value: context.read<ToggleTripCubit>().state, 
                        onChanged: (value){context.read<ToggleTripCubit>().toggle();}
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Visibility(
                    visible: context.watch<ToggleTripCubit>().state,
                    child: Row(
                      children: [
                        SizedBox(width: padding),
                        DropdownMenu(
                          dropdownMenuEntries: [],
                        ),
                      ],
                    ),
                  ),
                ),
              ]
          );
        }
      );
  }
}

class ExpenseCategoryDropdown extends StatelessWidget {
  const ExpenseCategoryDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return 
      BlocBuilder<ExpensePageBloc, ExpenseState>(
        builder: (context, state) {
          List<String> categoryStrings = [];
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
        Align(
          alignment: Alignment.topLeft,
          child: RichText(
            text: TextSpan(
              text: "Date:",
              style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.2),
            )
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: BlocBuilder<DateEntryCubit, DateTime>(
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
  }
}