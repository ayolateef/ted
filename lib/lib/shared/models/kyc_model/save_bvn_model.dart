
class SaveBVNModel {
  String? sId;
  String? userId;
  String? isKYCVerified;
  String? countryOfDocument;
  int? kycStep;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? bvn;

  SaveBVNModel(
      {this.sId,
        this.userId,
        this.isKYCVerified,
        this.countryOfDocument,
        this.kycStep,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.bvn});

  SaveBVNModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    isKYCVerified = json['isKYCVerified'];
    countryOfDocument = json['countryOfDocument'];
    kycStep = json['kycStep'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    bvn = json['bvn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['isKYCVerified'] = isKYCVerified;
    data['countryOfDocument'] = countryOfDocument;
    data['kycStep'] = kycStep;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['bvn'] = bvn;
    return data;
  }
}