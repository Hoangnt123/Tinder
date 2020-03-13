import 'dart:async';

import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';;

import 'package:sqflite/sqflite.dart';
import 'package:testpycoflutter/data/model/user_data.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;

  DatabaseHelper.internal();


  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

   void initDb() async {
    io.Directory appDirectory = await getApplicationDocumentsDirectory();
    String path = join(appDirectory.path, "appdata_v1.db");
    var dbConnection =
    await openDatabase(path, version: 1, onCreate: _onCreate);
    return dbConnection;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE users(
      id INTEGER PRIMARY KEY, 
      gender TEXT, 
      name TEXT, 
      location TEXT, 
      email TEXT, 
      username TEXT, 
      password TEXT,
      salt TEXT,
      md5 TEXT,
      sha1 TEXT,
      sha256 TEXT,
      registered TEXT,
      dob TEXT,
      phone TEXT,
      cell TEXT,
      SSN TEXT,
      picture TEXT
    )''');
  }

  Future<User> addUser(User user) async {
    var dbClient = await db;
    user.id = await dbClient.insert("users", user.toMap());
    return user;
  }

   Future<List<User>> getAllUser() async {
   var dbClient = await db;
  List<Map> maps = await dbClient.query('users');
    List<User> peoples = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        print(json.decode(maps[i]["name"]));
        peoples.add(User.fromMapDb(maps[i]));
      }
    }
    return peoples;
  }

  Future<int> deleteAllUser() async {
    var dbClient = await db;
    int result = await dbClient.delete("users");
    return result;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      'users',
      where: '$id = ?',
    );
  }

  Future<int> deleteByEmail(String email) async {
    var dbClient = await db;
    return await dbClient.delete(
      'users',
      where: 'email = ?',
    );
  }

  Future<int> update(User people) async {
    var dbClient = await db;
    return await dbClient.update(
      'users',
      people.toMap(),
      where: 'id = ?',
    );
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
