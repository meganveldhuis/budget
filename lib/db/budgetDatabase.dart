import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/expenseItem.dart';
import '../models/incomeItem.dart';

// database stored at: 
// C:\Users\megan\AppData\Local\Google\AndroidStudio2024.1\device-explorer\Pixel 8 API VanillaIceCream\_\data\user\0\com.example.budgetapp\databases

class BudgetDatabase {
  static Database? _db;

  static final BudgetDatabase instance = BudgetDatabase._constructor(); 

  static const tableExpenses = """
    CREATE TABLE IF NOT EXISTS expenses(
        id INTEGER PRIMARY KEY,
        date TEXT,
        timestamp TEXT,
        name TEXT,
        cat_id INTEGER,
        trip_id INTEGER,
        amount REAL,
        currency_id INTEGER,
        FOREIGN KEY (cat_id) REFERENCES categories(id),
        FOREIGN KEY (trip_id) REFERENCES trips(id),
        FOREIGN KEY (currency_id) REFERENCES currency(id)       
    );
  """;
  static const tableIncome = """
    CREATE TABLE IF NOT EXISTS income(
        id INTEGER PRIMARY KEY,
        date TEXT,
        timestamp TEXT,
        note TEXT,
        cat_id INTEGER,
        amount REAL,
        currency_id INTEGER,
        FOREIGN KEY (cat_id) REFERENCES categories(id),
        FOREIGN KEY (currency_id) REFERENCES currency(id)
    )
  """;
  static const tableCategories= """
    CREATE TABLE IF NOT EXISTS categories(
        id INTEGER PRIMARY KEY,
        name TEXT,
        description TEXT,
        is_income INTEGER        
    );
  """;

  static const tableTrips = """
    CREATE TABLE IF NOT EXISTS trips(
        id INTEGER PRIMARY KEY,
        def_currency INTEGER,
        name TEXT,
        month INTEGER,
        year INTEGER,
        FOREIGN KEY (def_currency) REFERENCES currency(id)   
    );
  """;

  static const tableBudget = """
    CREATE TABLE IF NOT EXISTS budget(
        id INTEGER PRIMARY KEY,
        timestamp TEXT,
        cat_id INTEGER,
        amount REAL,
        is_year INTEGER,
        FOREIGN KEY (cat_id) REFERENCES categories(id)
    );
  """;

  static const tableCurrency = """
    CREATE TABLE currency(
        id INTEGER PRIMARY KEY,
        code TEXT,
        conversion REAL
    );
  """;


  BudgetDatabase._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }
  Future<Database> getDatabase() async{
    print("initializing database");
    String databasePath = join(await getDatabasesPath(), "budget_db1.db"); //name of the db
    // await deleteDatabase(databasePath);
    print(databasePath);
    final database = await openDatabase(
      databasePath,
      version: 2,
      onCreate: (Database db, int version) async{
        await db.execute(tableExpenses);
        await db.execute(tableIncome);
        await db.execute(tableBudget);
        await db.execute(tableCategories);
        await db.execute(tableCurrency);
        await db.execute(tableTrips);
        print("oncreate");
      }
    );
    return database;
  }

//---------------------------------//  EXPENSES  //---------------------------------//
  void addExpense(ExpenseItem newEntry) async {
    final db = await database;

    await db.insert(
      'expenses',
      {
        'date': newEntry.date,
        'timestamp':DateTime.now(),
        'name': newEntry.name,
        'cat_id': newEntry.categoryID,
        'trip_id': newEntry.tripID,
        'amount': newEntry.amount,
        'currency_id': newEntry.currencyID
      },
    );
  }

//---------------------------------//  INCOME  //---------------------------------//
  void addIncome(IncomeItem newEntry) async{
    final db = await database;

    await db.insert(
      'income',
      {
        'date': newEntry.date,
        'timestamp':DateTime.now(),
        'note': newEntry.note,
        'cat_id': newEntry.categoryID,
        'amount': newEntry.amount,
        'currency_id': newEntry.currencyID
      },
    );
  }

//---------------------------------//  CATEGORIES  //---------------------------------//
  void createCategory(String name, String description, int isIncome ) async{
    final db = await database;
    await db.insert(
      'categories',{
        'name': name,
        'description': description,
        'is_income': isIncome,
      }
    );
  }

  void printCategories() async {
    final db = await database;
    List data = await db.query('categories');
    print(data);
  }

  Future <List<String>> categoryOptions(Enum valueType) async {
    print("checking category Options");
    String isIncome = '0';
    List<Object> isIncomeList;
    switch(valueType.name){
      case 'expense':
        isIncome = '0';
        break;
      case 'income':
        isIncome = '1';
        break;
    }
    isIncomeList = [isIncome];
    final db = await database;
    List<String> newCategories =[];
    List<Map> categories = await db.query(
                                'categories',
                                where: '? == is_income',
                                whereArgs: isIncomeList
                              );
    for (var row in categories) {
      newCategories.add(row['name'] as String);
    }
    return newCategories;
  }
}