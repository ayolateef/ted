
import 'package:enum_to_string/enum_to_string.dart';

import '../base.dart';

class User extends BaseModel {
  int? id;
  String? name;
  String? username;
  String? dob;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  bool? onboardingComplete;
  OnBoardingSteps? onboardingStep;
  String? isKYCVerified;
  String? gender;
  String? countryOfDocument;
  String? homeAddress;
  String? countryOrigin;
  String? state;
  String? bvn;
  String? nin;
  String? city;
  String? zipcode;
  String? sourceIncome;
  String? employmentStatus;
  String? occupation;
  String? incomeBand;
  String? dateApproved;
  String? idType;
  String? idNumber;
  int? kycStep;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.name,
        this.username,
        this.dob,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.onboardingComplete,
        this.onboardingStep,
        this.isKYCVerified,
        this.gender,
        this.countryOfDocument,
        this.homeAddress,
        this.countryOrigin,
        this.state,
        this.bvn,
        this.nin,
        this.city,
        this.zipcode,
        this.sourceIncome,
        this.employmentStatus,
        this.occupation,
        this.incomeBand,
        this.dateApproved,
        this.idType,
        this.idNumber,
        this.kycStep,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    dob = json['dob'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    onboardingComplete = json['onboardingComplete'];
    onboardingStep = OnBoardingSteps.values.firstWhere((element) =>
    element.onBoarding == json['onboardingStep'],
        orElse: () => OnBoardingSteps.createPin
    );
    isKYCVerified = json['isKYCVerified'];
    gender = json['gender'];
    countryOfDocument = json['countryOfDocument'];
    homeAddress = json['homeAddress'];
    countryOrigin = json['countryOrigin'];
    state = json['state'];
    bvn = json['bvn'];
    nin = json['nin'];
    city = json['city'];
    zipcode = json['zipcode'];
    sourceIncome = json['sourceIncome'];
    employmentStatus = json['employmentStatus'];
    occupation = json['occupation'];
    incomeBand = json['incomeBand'];
    dateApproved = json['dateApproved'];
    idType = json['idType'];
    idNumber = json['idNumber'];
    kycStep = json['kycStep'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['dob'] = dob;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['onboardingComplete'] = onboardingComplete;
    data['onboardingStep'] = EnumToString.convertToString(onboardingStep) ;
    data['isKYCVerified'] = isKYCVerified;
    data['gender'] = gender;
    data['countryOfDocument'] = countryOfDocument;
    data['homeAddress'] = homeAddress;
    data['countryOrigin'] = countryOrigin;
    data['state'] = state;
    data['bvn'] = bvn;
    data['nin'] = nin;
    data['city'] = city;
    data['zipcode'] = zipcode;
    data['sourceIncome'] = sourceIncome;
    data['employmentStatus'] = employmentStatus;
    data['occupation'] = occupation;
    data['incomeBand'] = incomeBand;
    data['dateApproved'] = dateApproved;
    data['idType'] = idType;
    data['idNumber'] = idNumber;
    data['kycStep'] = kycStep;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}



// class User {
//   String? sId;
//   String? name;
//   String? email;
//   String? password;
//   bool? isKYCVerified;
//   bool? onboardingComplete;
//   OnBoardingSteps? onboardingStep;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//
//   User({
//     this.sId,
//     this.name,
//     this.email,
//     this.password,
//     this.isKYCVerified,
//     this.onboardingComplete,
//     this.onboardingStep,
//     this.createdAt,
//     this.updatedAt,
//     this.iV
//
//   });
//
//   User.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     email = json['email'];
//     password = json['password'];
//     isKYCVerified = json['isKYCVerified'];
//     onboardingComplete = json['onboardingComplete'];
//     onboardingStep = OnBoardingSteps.values.firstWhere((element) =>
//   element.onBoarding == json['onboardingStep'],
//   orElse: () => OnBoardingSteps.createPin
//   );
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['name'] = name;
//     data['email'] = email;
//     data['password'] = password;
//     data['isKYCVerified'] = isKYCVerified;
//     data['onboardingComplete'] = onboardingComplete;
//     data['onboardingStep'] = onboardingStep;
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     data['__v'] = iV;
//
//     return data;
//   }
//
// }

enum OnBoardingSteps{
  createPin,username,dashboard
}

extension OnBoardingStepsExt on OnBoardingSteps {
  int get onBoarding {
    switch (this) {
      case OnBoardingSteps.createPin:
        return 1;
      case OnBoardingSteps.username:
        return 2;
      case OnBoardingSteps.dashboard:
        return 3;
      default:
        return -1;
    }
  }

  static OnBoardingSteps fromJson(int value) {
    switch (value) {
      case 1:
        return OnBoardingSteps.createPin;
      case 2:
        return OnBoardingSteps.username;
      case 3:
        return OnBoardingSteps.dashboard;
      default:
        throw Exception('Invalid value');
    }
  }
}






class UserTemp {
  String? pin;
  String? username;

  UserTemp({this.pin, this.username});
}



