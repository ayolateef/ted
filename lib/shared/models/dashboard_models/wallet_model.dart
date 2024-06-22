class WalletModel {
  String? accountName;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  int? accountBalance;
  int? ledgerBalance;
  String? accountNo;
  bool? expired;
  String? providerName;
  String? currency;
  String? country;
  String? createdAt;
  String? accountType;
  String? accountId;
  String? dob;
  String? bvnType;

  WalletModel({
    this.accountName,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.accountBalance,
    this.ledgerBalance,
    this.accountNo,
    this.expired,
    this.providerName,
    this.currency,
    this.country,
    this.createdAt,
    this.accountType,
    this.accountId,
    this.dob,
    this.bvnType
  });

  WalletModel.fromJson(Map<String, dynamic> json) {
    accountName = json['accountName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
    accountBalance = json['accountBalance'];
    ledgerBalance = json['ledgerBalance'];
    accountNo = json['accountNo'];
    expired = json['expired'];
    providerName = json['providerName'];
    currency = json['currency'];
    country = json['country'];
    createdAt = json['createdAt'];
    accountType = json['accountType'];
    accountId = json['accountId'];
    dob = json['dob'];
    bvnType = json['bvnType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accountName'] = accountName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phoneNumber'] = phoneNumber;
    data['accountBalance'] = accountBalance;
    data['ledgerBalance'] = ledgerBalance;
    data['accountNo'] = accountNo;
    data['expired'] = expired;
    data['providerName'] = providerName;
    data['currency'] = currency;
    data['country'] = country;
    data['createdAt'] = createdAt;
    data['accountType'] = accountType;
    data['accountId'] = accountId;
    data['dob'] = dob;
    data['bvnType'] = bvnType;
    return data;
  }
}