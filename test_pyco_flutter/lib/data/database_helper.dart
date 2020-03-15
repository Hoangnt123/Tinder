import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';

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

  Future<Database> initDb() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "note.db";
    var opendatabase =
    await openDatabase(path, version: 1, onCreate: _createDb);
    return opendatabase;
  }

  void _createDb(Database db, int newVersion) async {
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
    var db = await this.db;
    user.id = await db.insert("users", user.toMap());
    return user;
  }

  Future<List<User>> getAllUser() async {
    var db = await this.db;
    List<Map> maps = await db.query('users');
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
    var db = await this.db;
    int result = await db.delete("users");
    return result;
  }

  Future<int> delete(int id) async {
    var db = await this.db;
    return await db.delete(
      'users',
      where: '$id = ?',
      whereArgs: [id]
    );
  }

  Future<int> deleteByEmail(String email) async {
    var db = await this.db;
    return await db.delete(
      'users',
      where: 'email = ?',
      whereArgs: [email]
    );
  }

  Future<int> update(User people) async {
    var db = await this.db;
    return await db.update(
      'users',
      people.toMap(),
      where: 'id = ?',
      whereArgs: [people.id]
    );
  }


  Future close() async {
    var db = await this.db;
    db.close();
  }
}