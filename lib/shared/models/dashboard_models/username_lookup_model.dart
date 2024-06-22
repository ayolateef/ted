class Username {
  int? id;
  String? name;
  String? username;
  String? firstName;
  String? lastName;

  Username({this.id, this.name, this.username, this.firstName, this.lastName});

  Username.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    return data;
  }
}