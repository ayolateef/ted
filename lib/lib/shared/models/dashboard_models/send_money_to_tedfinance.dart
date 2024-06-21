class SendMoneyToTedUser {
  String? sourceAccountName;
  String? sourceAccount;
  String? destinationAccount;
  String? clientReference;
  String? transactionReference;
  int? amount;
  int? charge;
  int? totalAmount;
  String? destinationAccountName;
  String? transferType;

  SendMoneyToTedUser(
      {this.sourceAccountName,
        this.sourceAccount,
        this.destinationAccount,
        this.clientReference,
        this.transactionReference,
        this.amount,
        this.charge,
        this.totalAmount,
        this.destinationAccountName,
        this.transferType});

  SendMoneyToTedUser.fromJson(Map<String, dynamic> json) {
    sourceAccountName = json['sourceAccountName'];
    sourceAccount = json['sourceAccount'];
    destinationAccount = json['destinationAccount'];
    clientReference = json['clientReference'];
    transactionReference = json['transactionReference'];
    amount = json['amount'];
    charge = json['charge'];
    totalAmount = json['totalAmount'];
    destinationAccountName = json['destinationAccountName'];
    transferType = json['transferType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sourceAccountName'] = this.sourceAccountName;
    data['sourceAccount'] = this.sourceAccount;
    data['destinationAccount'] = this.destinationAccount;
    data['clientReference'] = this.clientReference;
    data['transactionReference'] = this.transactionReference;
    data['amount'] = this.amount;
    data['charge'] = this.charge;
    data['totalAmount'] = this.totalAmount;
    data['destinationAccountName'] = this.destinationAccountName;
    data['transferType'] = this.transferType;
    return data;
  }
}