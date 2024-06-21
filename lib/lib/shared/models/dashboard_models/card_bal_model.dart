class CardBalModel {
  String? cardId;
  String? cardPAN;
  String? nameOnCard;
  String? currency;
  String? brand;
  int? balance;
  int? limitBalance;
  int? amountSpentInLimitCycle;
  String? limitCycle;
  int? transactionLimit;
  String? status;

  CardBalModel(
      {this.cardId,
        this.cardPAN,
        this.nameOnCard,
        this.currency,
        this.brand,
        this.balance,
        this.limitBalance,
        this.amountSpentInLimitCycle,
        this.limitCycle,
        this.transactionLimit,
        this.status});

  CardBalModel.fromJson(Map<String, dynamic> json) {
    cardId = json['cardId'];
    cardPAN = json['cardPAN'];
    nameOnCard = json['nameOnCard'];
    currency = json['currency'];
    brand = json['brand'];
    balance = json['balance'];
    limitBalance = json['limitBalance'];
    amountSpentInLimitCycle = json['amountSpentInLimitCycle'];
    limitCycle = json['limitCycle'];
    transactionLimit = json['transactionLimit'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cardId'] = cardId;
    data['cardPAN'] = cardPAN;
    data['nameOnCard'] = nameOnCard;
    data['currency'] = currency;
    data['brand'] = brand;
    data['balance'] = balance;
    data['limitBalance'] = limitBalance;
    data['amountSpentInLimitCycle'] = amountSpentInLimitCycle;
    data['limitCycle'] = limitCycle;
    data['transactionLimit'] = transactionLimit;
    data['status'] = status;
    return data;
  }
}