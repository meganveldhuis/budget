

// id INTEGER PRIMARY KEY,
// date TEXT,
// timestamp TEXT,
// name TEXT,
// cat_id INTEGER,
// trip_id INTEGER,
// amount REAL,
// currency_id INTEGER,

import 'dart:ffi';

class ExpenseItem {
  String date;
  String timestamp;
  String name;
  int categoryID;
  int tripID;
  double amount;
  int currencyID;

  ExpenseItem({required this.date, required this.timestamp, 
              required this.name, required this.categoryID,
              required this.tripID, required this.amount,
              required this.currencyID});
}