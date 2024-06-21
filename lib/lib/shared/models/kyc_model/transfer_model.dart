

class OutwardTransferModel {
  String sourceAccountId;
  int amount;
  String clientReference;
  String narration;
  String destinationBankCode;
  String destinationAccount;
  String destinationAccountName;
  String destinationBankName;

  OutwardTransferModel({
    required this.sourceAccountId,
    required this.amount,
    required this.clientReference,
    required this.narration,
    required this.destinationBankCode,
    required this.destinationAccount,
    required this.destinationAccountName,
    required this.destinationBankName,
  });

  factory OutwardTransferModel.fromJson(Map<String, dynamic> json) {
    return OutwardTransferModel(
      sourceAccountId: json['sourceAccountId'] ?? '',
      amount: json['amount'] ?? '',
      clientReference: json['clientReference'],
      narration: json['narration'] ?? '',
      destinationBankCode: json['destinationBankCode'] ?? '',
      destinationAccount: json['destinationAccount'] ?? '',
      destinationAccountName: json['destinationAccountName'] ?? '',
      destinationBankName: json['destinationBankName'] ?? '',
    );
  }
}

