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
//     nin = json['nin'] ?? '';
//     firstName = json['firstName'] ?? '';
//     lastName = json['lastName'] ?? '';
//     middleName = json['middleName'] ?? '';
//     phoneNumber = json['phoneNumber'] ?? '';
//     email = json['email'] ?? '';
//     birthDate = json['birthDate'] ?? '';
//     photo = json['photo'] ?? '';
//     gender = json['gender'] ?? '';
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
//   NINModel({
//     this.nin,
//     this.firstName,
//     this.lastName,
//     this.middleName,
//     this.phoneNumber,
//     this.email,
//     this.birthDate,
//     this.photo,
//     this.gender,
//   });
//
//   NINModel.fromJson(Map<String, dynamic> json) {
//     try {
//       if (json != null) {
//         final data = json['data'];
//         if (data != null && data['responseObject'] != null) {
//           final responseObject = data['responseObject'];
//           nin = responseObject ['nin'];
//           firstName = responseObject ['firstName'];
//           lastName = responseObject ['lastName'];
//           middleName = responseObject ['middleName'];
//           phoneNumber = responseObject ['phoneNumber'];
//           email = responseObject ['email'];
//           birthDate = responseObject ['birthDate'];
//           photo = responseObject ['photo'];
//           gender = responseObject ['gender'];
//           print("Parsed NINModel: $this");
//         }
//
//       } else {
//         print("Data is null");
//       }
//     } catch (e) {
//       print("Error parsing NINModel: $e");
//     }
//   }
//
//   @override
//   String toString() {
//     return 'NINModel{nin: $nin, firstName: $firstName, lastName: $lastName, middleName: $middleName, phoneNumber: $phoneNumber, email: $email, birthDate: $birthDate, photo: $photo, gender: $gender}';
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

  NINModel(
      {this.nin,
        this.firstName,
        this.lastName,
        this.middleName,
        this.phoneNumber,
        this.email,
        this.birthDate,
        this.photo,
        this.gender});

  // NINModel.fromJson(Map<String, dynamic> json) {
  //   nin = json['nin'];
  //   firstName = json['firstName'] ?? '';
  //   lastName = json['lastName'] ?? '';
  //   middleName = json['middleName'] ?? '';
  //   phoneNumber = json['phoneNumber'] ?? '';
  //   email = json['email'];
  //   birthDate = json['birthDate'] ?? '';
  //   photo = json['photo'] ?? '';
  //   gender = json['gender'] ?? '';
  // }
  factory NINModel.fromJson(Map<String, dynamic> json) {
    print('JSON data: $json'); // Add this log
    return NINModel(
      nin: json['nin'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      middleName: json['middleName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      birthDate: json['birthDate'] ?? '',
      photo: json['photo'] ?? '',
      gender: json['gender'] ?? '',
    );
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