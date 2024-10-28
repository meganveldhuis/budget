// id INTEGER PRIMARY KEY,
// date TEXT,
// timestamp TEXT,
// note TEXT,
// cat_id INTEGER,
// amount REAL,
// currency_id INTEGER,

import 'dart:ffi';
class IncomeItem {
  String date;
  String timestamp;
  String note;
  int categoryID;
  Float amount;
  int currencyID;

  IncomeItem({required this.date,   required this.timestamp, 
              required this.note,   required this.categoryID,
              required this.amount, required this.currencyID});
}