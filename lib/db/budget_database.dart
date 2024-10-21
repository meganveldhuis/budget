import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// database stored at: 
// C:\Users\megan\AppData\Local\Google\AndroidStudio2024.1\device-explorer\Pixel 8 API VanillaIceCream\_\data\user\0\com.example.budgetapp\databases

class budgetDatabase {
  static Database? _db;

  static final budgetDatabase instance = budgetDatabase._constructor(); 

  // final String _expTableName = "expenses";

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


  budgetDatabase._constructor();

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


  void addTask(
    String content,
  ) async {
    final db = await database;
    List data = await db.query('expenses');
    print("adding to this db:");
    print(data);
    await db.insert(
      'expenses',
      {
        'date': content,
        'amount': 0,
      },
    );
    data = await db.query('expenses');
    print(data);
    String path = await getDatabasesPath();
    print(path);
  }

  void createCategory(String name, String description, int isIncome ) async{
    //note that while is_income is a bool, we need to add it to the database as an integer.
    print("Creating Category");
    final db = await database;
    // int intIsIncome=0;

    // if (isIncome){
    //   intIsIncome = 1;
    // }else if(!isIncome){
    //   intIsIncome = 0;
    // }else{
    //   intIsIncome = 99; //error
    //   print("ERROR: bool value not found");
    // }
    await db.insert(
      'categories',{
        'name': name,
        'description': description,
        'is_income': isIncome,
      }
    );
    print("added a category");
    List data = await db.query('categories');
    print(data);
    data = await db.query('expenses');
    print(data);
    String path = await getDatabasesPath();
    print(path);
  }

  void printCategories() async {
    final db = await database;
    List data = await db.query('categories');
    print(data);
  }
}

