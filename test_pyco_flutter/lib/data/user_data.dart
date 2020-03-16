import 'package:sqflite/sqflite.dart';
import 'package:testpycoflutter/model/user.dart';

import 'database_helper.dart';

final userData = UserData();

class UserData {
  final dbProvider = DatabaseProvider.instance;

  Future<List<User>> getFavoriteUsers() async {
    final Database db = await dbProvider.database;

    final List<Map<String, dynamic>> maps = await db.query('users');

    if (maps == null) {
      return [];
    } else {
      return List.generate(maps.length, (i) {
        return User.fromMap(maps[i]);
      });
    }
  }

  Future<User> insertFavoriteUser(User user) async {
    final Database db = await dbProvider.database;

    await db.insert(
      "users",
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return user;
  }
}
