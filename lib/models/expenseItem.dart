

// id INTEGER PRIMARY KEY,
// date TEXT,
// timestamp TEXT,
// name TEXT,
// cat_id INTEGER,
// trip_id INTEGER,
// amount REAL,
// currency_id INTEGER,

import 'dart:ffi';

class expenseItem {
  String date;
  String timestamp;
  String name;
  int cat_id;
  int trip_id;
  Float amount;
  int currency_id;

  expenseItem({required this.date, required this.timestamp, 
              required this.name, required this.cat_id,
              required this.trip_id, required this.amount,
              required this.currency_id});
}