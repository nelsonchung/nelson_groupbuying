import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = "orders.db";
  static final _databaseVersion = 1;

  static final table = 'orders';

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnDescription = 'description';
  static final columnPrice = 'price';
  static final columnQuantity = 'quantity';
  static final columnPhoto = 'photo';
  static final columnShop = 'shop';

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only have a single app-wide reference to the database.
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnDescription TEXT NOT NULL,
            $columnPrice REAL NOT NULL,
            $columnQuantity REAL NOT NULL,
            $columnPhoto TEXT,
            $columnShop TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }
}
