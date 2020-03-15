import 'dart:async';
import 'package:http/http.dart' as http;
import '../database_helper.dart';
import '../exception_helper.dart';
import 'user_data.dart';

class RandomUserRepository implements UserRepository {
  static const _RandomUserUrl = 'http://api.randomuser.me/?results=15';

  DatabaseHelper dbHelper;

  RandomUserRepository() {
    dbHelper = DatabaseHelper();
  }

  Future<User> fetchUser() async {
    final response = await http.get(_RandomUserUrl);
    final jsonBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw FetchDataException(
          "Error while getting contacts [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
    }

  }

  @override
  Future<User> createUser(User people) async {
    return await dbHelper.addUser(people);
  }

  @override
  Future<int> deleteUser(User user) async {
    return await dbHelper.deleteByEmail(user.email);
  }


  @override
  Future<List<User>> getAllUser() async {
    return await dbHelper.getAllUser();
  }


  }



