
import 'package:tedfinance_mobile/shared/models/dashboard_models/username_lookup_model.dart';

class TedFinanceUser {
  String? sourceAccountName;
  String? sourceAccount;
  String? destinationAccount;
  String? clientReference;
  String? transactionReference;
  double? amount;
  double? charge;
  double? totalAmount;
  String? destinationAccountName;
  String? transferType;
  DateTime? timestamp = DateTime.now();

  TedFinanceUser(
      {this.sourceAccountName,
        this.sourceAccount,
        this.destinationAccount,
        this.clientReference,
        this.transactionReference,
        this.amount,
        this.charge,
        this.totalAmount,
        this.destinationAccountName,
        this.transferType,
        this.timestamp
      });

  TedFinanceUser.fromJson(Map<String, dynamic> json) {
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
    timestamp = json['timestamp'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sourceAccountName'] = sourceAccountName;
    data['sourceAccount'] = sourceAccount;
    data['destinationAccount'] = destinationAccount;
    data['clientReference'] = clientReference;
    data['transactionReference'] = transactionReference;
    data['amount'] = amount;
    data['charge'] = charge;
    data['totalAmount'] = totalAmount;
    data['destinationAccountName'] = destinationAccountName;
    data['transferType'] = transferType;

    return data;
  }
}

// class SendMoneyResponse {
//   Username? usernameModel;
//   TedFinanceUser? tedFinanceUser;
//
//   SendMoneyResponse({this.usernameModel, this.tedFinanceUser});
//
//   factory SendMoneyResponse.fromJson(Map<String, dynamic> json) {
//     return SendMoneyResponse(
//       usernameModel: Username.fromJson(json ['usernameModel']),
//       tedFinanceUser: TedFinanceUser.fromJson(json['tedFinanceUser']),
//     );
//   }
// }