class KYCProgressModel {
  int? id;
String? name;
String? username;
String? dob;
String? firstName;
String? lastName;
String? email;
String? phone;
bool? onboardingComplete;
int? onboardingStep;
String? isKYCVerified;
String? gender;
KYCSteps? kycStep;
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
String? createdAt;
String? updatedAt;
List<UserDocs>? userDocs;
String? status;

KYCProgressModel ({
  this.id,
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
  this.updatedAt,
  this.userDocs,
  this.status,
});
KYCProgressModel.fromJson(Map<String, dynamic> json) {
  final data = json['data'];
  if (data != null){
    id = json['data']['id'];
    name = json['data']['name'];
    username = json['data']['username'];
    dob = json['data']['dob'];
    firstName = json['data']['firstName'];
    lastName = json['data']['lastName'];
    email = json['data']['email'];
    phone = json['data']['phone'];
    onboardingComplete = json['data']['onboardingComplete'];
    onboardingStep = json['data']['onboardingStep'];
    isKYCVerified = json['data']['isKYCVerified'];
    gender = json['data']['gender'];
    countryOfDocument = json['data']['countryOfDocument'];
    homeAddress = json['data']['homeAddress'];
    countryOrigin = json['data']['countryOrigin'];
    state = json['data']['state'];
    bvn = json['data']['bvn'];
    nin = json['data']['nin'];
    city = json['data']['city'];
    zipcode = json['data']['zipcode'];
    sourceIncome = json['data']['sourceIncome'];
    employmentStatus = json['data']['employmentStatus'];
    occupation = json['data']['occupation'];
    incomeBand = json['data']['incomeBand'];
    dateApproved = json['data']['dateApproved'];
    idType = json['data']['idType'];
    idNumber = json['data']['idNumber'];
    kycStep = KYCSteps.values.firstWhere((element) =>
    element.kycStep == json['data']['kycStep'],
        orElse: () => KYCSteps.none
    );
    createdAt = json['data']['createdAt'];
    updatedAt = json['data']['updatedAt'];
    if (json['userDocs'] != null) {
      userDocs = <UserDocs>[];
      json['data']['userDocs'].forEach((v) {
        userDocs!.add(UserDocs.fromJson(v));
      });
    }
  }
  status = json['status'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = id;
  data['name'] = name;
  data['username'] = username;
  data['dob'] = dob;
  data['firstName'] = firstName;
  data['lastName'] = lastName;
  data['email'] = email;
  data['phone'] = phone;
  data['onboardingComplete'] = onboardingComplete;
  data['onboardingStep'] = onboardingStep;
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
  if (userDocs != null) {
    data['userDocs'] = userDocs!.map((v) => v.toJson()).toList();
  }
  data['status'] = status;
  return data;
}
}

enum KYCSteps {
  setCountry,
  verifyBVN,
  verifyNIN,
  idValidation,
  addressVerification,
  selfieVerification,
  none;


}

extension KYCStepsExt on KYCSteps {
  int get  kycStep {
    switch (this) {
      case KYCSteps.setCountry:
        return 1;
      case KYCSteps.verifyBVN:
        return 2;
      case KYCSteps.selfieVerification:
        return 3;
      case KYCSteps.verifyNIN:
        return 4;
      case KYCSteps.idValidation:
        return 5;
      case KYCSteps.addressVerification:
        return 6;
      default:
        return -1;
    }
  }

  static KYCSteps fromJson(int value) {
    switch (value) {
      case 1:
        return KYCSteps.setCountry;
      case 2:
        return KYCSteps.verifyBVN;
      case 3:
        return KYCSteps.selfieVerification;
      case 4:
        return  KYCSteps.verifyNIN;
      case 5 :
       return KYCSteps.idValidation;
        case 6 :
          return KYCSteps.addressVerification;
      default:
        return KYCSteps.none;
    }
  }
}
class UserDocs {
  int? id;
  String? type;
  num? idNumber;
  String? url;
  String? status;
  String? approvedBy;
  String? kycType;
  String? dateApprovedOrDeclined;
  int? userId;
  String? createdAt;
  String? updatedAt;

  UserDocs(
      {this.id,
        this.type,
        this.idNumber,
        this.url,
        this.status,
        this.approvedBy,
        this.kycType,
        this.dateApprovedOrDeclined,
        this.userId,
        this.createdAt,
        this.updatedAt});

  UserDocs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    idNumber = json['idNumber'];
    url = json['url'];
    status = json['status'];
    approvedBy = json['approvedBy'];
    kycType = json['kycType'];
    dateApprovedOrDeclined = json['dateApprovedOrDeclined'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['idNumber'] = idNumber;
    data['url'] = url;
    data['status'] = status;
    data['approvedBy'] = approvedBy;
    data['kycType'] = kycType;
    data['dateApprovedOrDeclined'] = dateApprovedOrDeclined;
    data['userId'] = userId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}