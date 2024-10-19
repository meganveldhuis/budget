import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// database stored at: 
// C:\Users\megan\AppData\Local\Google\AndroidStudio2024.1\device-explorer\Pixel 8 API VanillaIceCream\_\data\user\0\com.example.budgetapp\databases

class DatabaseService {
  static Database? _db;

  static final DatabaseService instance = DatabaseService._constructor(); 

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

  // static const tableTasks = """
  //   CREATE TABLE IF NOT EXISTS tasks(

  //   );
  // """;

  // final String _tasksTableName = "tasks";
  // final String _tasksIdColumnName = "id";
  // final String _tasksContentColumnName = "content";
  // final String _tasksStatusColumnName = "status";

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }
  Future<Database> getDatabase() async{
    print("initializing database");
    // final databaseDirPath = await getDatabasesPath();
    String databasePath = join(await getDatabasesPath(), "budget_db.db"); //name of the db
    await deleteDatabase(databasePath);
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
      }
    );
    return database;
  }


  Future<List>? getTasks() async{
    print("TEST");
    final db = await database;
    final data = await db.query('expenses');
    print("data here:");
    print(data);
    return List.empty();
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
}