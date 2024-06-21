// class NINModel {
//   String? nin;
//   String? firstName;
//   String? lastName;
//   String? middleName;
//   String? phoneNumber;
//   String? email;
//   String? birthDate;
//   String? photo;
//   String? gender;
//
//   NINModel(
//       {this.nin,
//         this.firstName,
//         this.lastName,
//         this.middleName,
//         this.phoneNumber,
//         this.email,
//         this.birthDate,
//         this.photo,
//         this.gender});
//
//   NINModel.fromJson(Map<String, dynamic> json) {
//     nin = json['nin'];
//     firstName = json['firstName'];
//     lastName = json['lastName'];
//     middleName = json['middleName'];
//     phoneNumber = json['phoneNumber'];
//     email = json['email'];
//     birthDate = json['birthDate'];
//     photo = json['photo'];
//     gender = json['gender'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['nin'] = nin;
//     data['firstName'] = firstName;
//     data['lastName'] = lastName;
//     data['middleName'] = middleName;
//     data['phoneNumber'] = phoneNumber;
//     data['email'] = email;
//     data['birthDate'] = birthDate;
//     data['photo'] = photo;
//     data['gender'] = gender;
//     return data;
//   }
// }



class NINModel {
  String? nin;
  String? firstName;
  String? lastName;
  String? middleName;
  String? phoneNumber;
  String? email;
  String? birthDate;
  String? photo;
  String? gender;

  NINModel({
    this.nin,
    this.firstName,
    this.lastName,
    this.middleName,
    this.phoneNumber,
    this.email,
    this.birthDate,
    this.photo,
    this.gender,
  });

  NINModel.fromJson(Map<String, dynamic> json) {
    try {
      var data = json['data']?['data']?['responseObject'];
      if (data != null) {
        nin = data['nin'];
        firstName = data['firstName'];
        lastName = data['lastName'];
        middleName = data['middleName'];
        phoneNumber = data['phoneNumber'];
        email = data['email'];
        birthDate = data['birthDate'];
        photo = data['photo'];
        gender = data['gender'];
        print("Parsed NINModel: $this");
      } else {
        print("Data is null");
      }
    } catch (e) {
      print("Error parsing NINModel: $e");
    }
  }

  @override
  String toString() {
    return 'NINModel{nin: $nin, firstName: $firstName, lastName: $lastName, middleName: $middleName, phoneNumber: $phoneNumber, email: $email, birthDate: $birthDate, photo: $photo, gender: $gender}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nin'] = nin;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['middleName'] = middleName;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['birthDate'] = birthDate;
    data['photo'] = photo;
    data['gender'] = gender;
    return data;
  }
}


