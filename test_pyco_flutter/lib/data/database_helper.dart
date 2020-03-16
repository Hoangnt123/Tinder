import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final instance = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    String rootPath = await getDatabasesPath();
    String path = join(rootPath, 'user_app.db');

    return await openDatabase(path, version: 1, onOpen: (db) async {},
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE users(
            username TEXT PRIMARY KEY,
            password TEXT,
            avatarUrl TEXT,
            email TEXT,
            gender TEXT,
            phone TEXT,
            location TEXT,
            cell TEXT,
            sha1 TEXT,
            sha256 TEXT,
            dob TEXT,
            SSN TEXT,
            md5 TEXT
            
            )
        ''');
    });
  }
}
