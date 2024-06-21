class BVNModel {
  String? firstName;
  String? otp;
  String? lastName;
  String? dob;
  String? phoneNumber;
  String? bvn;
  String? gender;
  String? state;

  BVNModel({
    this.firstName,
    this.otp,
    this.lastName,
    this.dob,
    this.phoneNumber,
    this.bvn,
    this.gender,
    this.state});

  BVNModel.fromJson(Map<String, dynamic> json) {
    print('JSON Data: $json');
    firstName = json['firstName'] ?? '';
    otp = json['otp'] ?? '';
    lastName = json['lastName'] ?? '';
    dob = json['dob'] ?? '';
    phoneNumber = json['phoneNumber'] ?? '';
    bvn = json['bvn'] ?? '';
    gender = json['gender'] ?? '';
    state = json['state'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['otp'] = otp;
    data['lastName'] = lastName;
    data['dob'] = dob;
    data['phoneNumber'] = phoneNumber;
    data['bvn'] = bvn;
    data['gender'] = gender;
    data['state'] = state;
    return data;
  }
}

