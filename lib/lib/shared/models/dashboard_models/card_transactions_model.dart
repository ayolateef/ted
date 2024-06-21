
class TransactionsModel {
  String? cardId;
  String? cardName;
  String? currency;
  String? maskedPan;
  int? availableBalance;
  double? amount;
  String? transactionType;
  String? transactionStatus;
  String? createdAt;
  String? reference;
  String? narration;
  String? gatewayResponseMessage;
  String? merchantName;

  TransactionsModel(
      {this.cardId,
        this.cardName,
        this.currency,
        this.maskedPan,
        this.availableBalance,
        this.amount,
        this.transactionType,
        this.transactionStatus,
        this.createdAt,
        this.reference,
        this.narration,
        this.gatewayResponseMessage,
        this.merchantName});

  TransactionsModel.fromJson(Map<String, dynamic> json) {
    cardId = json['cardId'];
    cardName = json['cardName'];
    currency = json['currency'];
    maskedPan = json['maskedPan'];
    availableBalance = json['availableBalance'];
    amount = json['amount'].toDouble();
    transactionType = json['transactionType'];
    transactionStatus = json['transactionStatus'];
    createdAt = json['createdAt'];
    reference = json['reference'];
    narration = json['narration'];
    gatewayResponseMessage = json['gatewayResponseMessage'];
    merchantName = json['merchantName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cardId'] = cardId;
    data['cardName'] = cardName;
    data['currency'] = currency;
    data['maskedPan'] = maskedPan;
    data['availableBalance'] = availableBalance;
    data['amount'] = amount;
    data['transactionType'] = transactionType;
    data['transactionStatus'] = transactionStatus;
    data['createdAt'] = createdAt;
    data['reference'] = reference;
    data['narration'] = narration;
    data['gatewayResponseMessage'] = gatewayResponseMessage;
    data['merchantName'] = merchantName;
    return data;
  }
}