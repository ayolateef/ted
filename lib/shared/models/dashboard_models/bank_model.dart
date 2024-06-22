import 'package:tedfinance_mobile/shared/util/widgets/custom_text_form_field.dart';

class BankModel extends DropdownBaseModel {
  String? bankCode;
  String? bankName;

  BankModel({this.bankCode, this.bankName});

  BankModel.fromJson(Map<String, dynamic> json) {
    bankCode = json['bankCode'];
    bankName = json['bankName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bankCode'] = bankCode;
    data['bankName'] = bankName;
    return data;
  }
  // @override
  // String getDisplayValue() {
  //   return bankName ?? '';
  // }
  //
  // @override
  // String getGetValue() {
  //   return bankCode ?? '';
  // }

  @override
  // TODO: implement displayName
  String get displayName => bankName ?? '';
}