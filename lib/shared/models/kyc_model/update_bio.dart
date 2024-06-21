class UpdateBio {
  String? status;
  Data? data;
  String? message;

  UpdateBio({this.status, this.data, this.message});

  UpdateBio.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? sId;
  String? userId;
  String? isKYCVerified;
  String? countryOfDocument;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? city;
  String? countryOrigin;
  String? dob;
  String? firstName;
  String? gender;
  String? homeAddress;
  String? lastName;
  String? state;

  Data(
      {this.sId,
        this.userId,
        this.isKYCVerified,
        this.countryOfDocument,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.city,
        this.countryOrigin,
        this.dob,
        this.firstName,
        this.gender,
        this.homeAddress,
        this.lastName,
        this.state});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    isKYCVerified = json['isKYCVerified'];
    countryOfDocument = json['countryOfDocument'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    city = json['city'];
    countryOrigin = json['countryOrigin'];
    dob = json['dob'];
    firstName = json['firstName'];
    gender = json['gender'];
    homeAddress = json['homeAddress'];
    lastName = json['lastName'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['isKYCVerified'] = this.isKYCVerified;
    data['countryOfDocument'] = this.countryOfDocument;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['city'] = this.city;
    data['countryOrigin'] = this.countryOrigin;
    data['dob'] = this.dob;
    data['firstName'] = this.firstName;
    data['gender'] = this.gender;
    data['homeAddress'] = this.homeAddress;
    data['lastName'] = this.lastName;
    data['state'] = this.state;
    return data;
  }
}
