class ApiResponse {
  List<User> userList;

  ApiResponse(this.userList);

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    final results = json['results'] as List;
    List<User> userList = results.map((i) => User.fromJson(i)).toList();

    return ApiResponse(userList);
  }
}

class User {
  String username;
  String password;
  String avatarUrl;
  String email;
  String gender;
  String phone;
  String location;
  String salt;
  String md5;
  String sha1;
  String sha256;
  String registered;
  String dob;
  String cell;
  String SSN;

  User({
    this.username,
    this.password,
    this.avatarUrl,
    this.email,
    this.gender,
    this.phone,
    this.location,
    this.sha256,
    this.SSN,
    this.sha1,
    this.salt,
    this.registered,
    this.cell,
    this.dob,
    this.md5,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final user = json["user"];
    final _Location location = _Location.fromJson(user["location"]);

    return User(
      username: user["username"],
      password: user["password"],
      avatarUrl: user["picture"],
      email: user["email"],
      gender: user["gender"],
      phone: user["phone"],
      SSN: user["SSN"],
      sha256: user["sha256"],
      salt: user["salt"],
      registered: user["registered"],
      dob: user["dob"],
      cell: user["cell"],
      md5: user["md5"],
      sha1: user["sha1"],
      location: location.toString(),
    );
  }

  factory User.fromMap(Map<String, dynamic> query) {
    return User(
      username: query["username"],
      password: query["password"],
      avatarUrl: query["avatarUrl"],
      email: query["email"],
      gender: query["gender"],
      phone: query["phone"],
      location: query["location"],
      SSN: query["SSN"],
      sha256: query["sha256"],
      salt: query["salt"],
      registered: query["registered"],
      dob: query["dob"],
      cell: query["cell"],
      md5: query["md5"],
      sha1: query["sha1"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'avatarUrl': avatarUrl,
      'email': email,
      'gender': gender,
      'phone': phone,
      'location': location,
      'SSN': SSN,
      'salt': salt,
      'sha1': sha1,
      'sha256': sha256,
      'dob': dob,
      'md5': md5,
      'registered': registered,
      'cell': cell,
    };
  }
}

class _Location {
  final String street;
  final String city;
  final String state;

  _Location({this.street, this.city, this.state});

  @override
  String toString() {
    return "$street, $city, $state";
  }

  factory _Location.fromJson(Map<String, dynamic> json) {
    return _Location(
      street: json["street"],
      city: json["city"],
      state: json["state"],
    );
  }
}
