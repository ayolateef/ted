class CardDetailsModel {
  String? cardId;
  String? currency;
  String? maskedPan;
  String? ledgerType;
  String? cardStatus;
  String? expiryStatus;
  String? nameOnCard;
  String? cardBrand;
  String? expirationDate;
  String? cvv;
  String? fullCardPan;
  String? billingAddress;
  bool? enableLimit;
  String? createdAt;
  String? dob;

  CardDetailsModel(
      {this.cardId,
        this.currency,
        this.maskedPan,
        this.ledgerType,
        this.cardStatus,
        this.expiryStatus,
        this.nameOnCard,
        this.cardBrand,
        this.expirationDate,
        this.cvv,
        this.fullCardPan,
        this.billingAddress,
        this.enableLimit,
        this.createdAt,
        this.dob});

  CardDetailsModel.fromJson(Map<String, dynamic> json) {
    cardId = json['cardId'];
    currency = json['currency'];
    maskedPan = json['maskedPan'];
    ledgerType = json['ledgerType'];
    cardStatus = json['cardStatus'];
    expiryStatus = json['expiryStatus'];
    nameOnCard = json['nameOnCard'];
    cardBrand = json['cardBrand'];
    expirationDate = json['expirationDate'];
    cvv = json['cvv'];
    fullCardPan = json['fullCardPan'];
    billingAddress = json['billingAddress'];
    enableLimit = json['enableLimit'];
    createdAt = json['createdAt'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardId'] = this.cardId;
    data['currency'] = this.currency;
    data['maskedPan'] = this.maskedPan;
    data['ledgerType'] = this.ledgerType;
    data['cardStatus'] = this.cardStatus;
    data['expiryStatus'] = this.expiryStatus;
    data['nameOnCard'] = this.nameOnCard;
    data['cardBrand'] = this.cardBrand;
    data['expirationDate'] = this.expirationDate;
    data['cvv'] = this.cvv;
    data['fullCardPan'] = this.fullCardPan;
    data['billingAddress'] = this.billingAddress;
    data['enableLimit'] = this.enableLimit;
    data['createdAt'] = this.createdAt;
    data['dob'] = this.dob;
    return data;
  }
}