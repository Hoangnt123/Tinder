import 'package:testpycoflutter/data/model/location_data.dart';
import 'package:testpycoflutter/data/model/personal_data.dart';
import 'dart:convert';



class User {
  int id;
  String gender;
  Personal name;
  Location location;
  String email;
  String username;
  String password;
  String salt;
  String md5;
  String sha1;
  String sha256;
  String registered;
  String dob;
  String phone;
  String cell;
  String SSN;
  String picture;

  User(this.gender, this.name, this.location, this.email, this.username,
      this.password, this.phone, this.cell, this.SSN, this.picture);

  User.fromMap(Map<String, dynamic> map)
      : gender = map["gender"],
        name = Personal.fromMap(map["name"]),
        location = Location.fromMap(map["location"]),
        email = map["email"],
        username = map["username"],
        password = map["password"],
        salt = map["salt"],
        md5 = map["md5"],
        sha1 = map["sha1"],
        sha256 = map["sha256"],
        registered = map["registered"],
        dob = map["dob"],
        phone = map["phone"],
        cell = map["cell"],
        SSN = map["SSN"],
        picture = map["picture"];
  User.fromMapDb(Map<String, dynamic> map)
      : this.gender = map["gender"],
        this.name = Personal.fromMap(json.decode(map["name"].toString())),
        this.location =  Location.fromMap(json.decode(map["location"].toString())),
        this.email = map["email"],
        this.username = map["username"],
        this.password = map["password"],
        this.salt = map["salt"],
        this.md5 = map["md5"],
        this.sha1 = map["sha1"],
        this.sha256 = map["sha256"],
        this.registered = map["registered"],
        this.dob = map["dob"],
        this.phone = map["phone"],
        this.cell = map["cell"],
        this.SSN = map["SSN"],
        this.picture = map["picture"];


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["gender"] = gender;
    map["name"] = name.toJsonString();
    map["location"] = location.toJsonString();
    map["email"] = email;
    map["username"] = username;
    map["password"] = password;
    map["salt"] = salt;
    map["sha1"] = sha1;
    map["sha256"] = sha256;
    map["registered"] = registered;
    map["dob"] = dob;
    map["phone"] = phone;
    map["cell"] = cell;
    map["SSN"] = SSN;
    map["picture"] = picture;
    return map;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "gender": gender,
      "name": name.toJson(),
      "location": location.toJson(),
      "email": email,
      "username": username,
      "password": password,
      "salt": salt,
      "sha1": sha1,
      "sha256": sha256,
      "registered": registered,
      "dob": dob,
      "phone": phone,
      "cell": cell,
      "SSN": SSN,
      "picture": picture,
    };
  }
}


class ApiResponse {
  List<User> userList;

  ApiResponse(this.userList);

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    final results = json['results'] as List;
    List<User> userList = results.map((i) => User.fromJson(i)).toList();

    return ApiResponse(userList);
  }
}


class UserDataException implements Exception {
  String _messages;

  UserDataException(this._messages);

  String toString() {
    return "Login Exception : $_messages";
  }
}
abstract class UserRepository {
  Future<User> fetchUser();
  Future<User> createUser(User user);
  Future<List<User>> getAllUser();
  Future<int> deleteUser(User user);
}