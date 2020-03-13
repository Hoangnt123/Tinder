class Location {
  String street;
  String city;
  String state;
  String zip;

  Location(this.street, this.city, this.state, this.zip);

  Location.fromMap(Map<String, dynamic> map)
      : this.street = map["street"],
        this.city = map["city"],
        this.state = map["state"],
        this.zip = map["zip"];

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["street"] = street;
    map["city"] = city;
    map["state"] = state;
    map["zip"] = zip;
    return map;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "street": street,
      "city": city,
      "state": state,
      "zip": zip
    };
  }

  Map<String, dynamic> toJsonString() {
    return <String, dynamic>{
      "street": "${street}",
      "city": "${city}",
      "state": "${state}",
      "zip": "${zip}"
    };
  }
}
