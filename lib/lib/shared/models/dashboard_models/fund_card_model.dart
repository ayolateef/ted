
class FundCardModel {
  String? transactionStatus;
  String? cardId;
  int? amount;
  int? balance;
  int? limitBalance;
  String? reference;
  String? transactionDate;

  FundCardModel(
      {this.transactionStatus,
        this.cardId,
        this.amount,
        this.balance,
        this.limitBalance,
        this.reference,
        this.transactionDate});

  FundCardModel.fromJson(Map<String, dynamic> json) {
    transactionStatus = json['transactionStatus'];
    cardId = json['cardId'];
    amount = json['amount'];
    balance = json['balance'];
    limitBalance = json['limitBalance'];
    reference = json['reference'];
    transactionDate = json['transactionDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transactionStatus'] = transactionStatus;
    data['cardId'] = cardId;
    data['amount'] = amount;
    data['balance'] = balance;
    data['limitBalance'] = limitBalance;
    data['reference'] = reference;
    data['transactionDate'] = transactionDate;
    return data;
  }
}

