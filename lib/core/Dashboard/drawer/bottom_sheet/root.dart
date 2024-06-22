import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tedfinance_mobile/core/Dashboard/drawer/bottom_sheet/widget/emeralds_sheet.dart';
import 'package:tedfinance_mobile/core/Dashboard/drawer/bottom_sheet/widget/exchange_successful.dart';
import 'package:tedfinance_mobile/core/Dashboard/drawer/bottom_sheet/widget/money_sent_successfully.dart';
import 'package:tedfinance_mobile/core/Dashboard/drawer/bottom_sheet/widget/ruby_limit.dart';
import 'package:tedfinance_mobile/core/Dashboard/drawer/bottom_sheet/widget/selfie_smple_sheet.dart';
import 'package:tedfinance_mobile/core/Dashboard/drawer/bottom_sheet/widget/utilities_sheet.dart';
import 'package:tedfinance_mobile/core/Dashboard/drawer/bottom_sheet/widget/verify_address.dart';
import 'package:tedfinance_mobile/core/Dashboard/drawer/bottom_sheet/widget/virtual_card_successful.dart';
import 'package:tedfinance_mobile/core/Dashboard/drawer/bottom_sheet/widget/withdraw_success.dart';
import 'package:tedfinance_mobile/core/Dashboard/drawer/bottom_sheet/widget/withdraw_username.dart';
import 'package:tedfinance_mobile/core/Dashboard/drawer/bottom_sheet/widget/add_payment_sheet.dart';
import 'package:tedfinance_mobile/core/Dashboard/drawer/bottom_sheet/widget/confirm_account_sheet.dart';
import 'package:tedfinance_mobile/core/Dashboard/drawer/bottom_sheet/widget/confirm_withdraaw_sheet.dart';
import 'package:tedfinance_mobile/core/Dashboard/drawer/bottom_sheet/widget/enter_pin.dart';
import 'package:tedfinance_mobile/core/Dashboard/drawer/bottom_sheet/widget/success_payment.dart';
import 'package:tedfinance_mobile/core/Dashboard/kyc/selfie.dart';
import 'package:tedfinance_mobile/shared/models/dashboard_models/transfer_tedFinance_user.dart';
import 'package:tedfinance_mobile/shared/models/kyc_model/transfer_model.dart';

import '../../../env/utils/colors.dart';

var _roundedRectangleBorder = const RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(25),
    topLeft: Radius.circular(25),
  ),
);

void addPaymentMethodSheet({
  BuildContext? context,
}) {
  showModalBottomSheet(
    context: context!,
    barrierColor: AppColors.primaryColor.withOpacity(0.2),
    shape: _roundedRectangleBorder,
    isScrollControlled: true,
    builder: (context) {
      return const AddPaymentSheet();
    },
  );
}
void utilitiesSheet({
  BuildContext? context,
}) {
  showModalBottomSheet(
    context: context!,
    barrierColor: AppColors.primaryColor.withOpacity(0.2),
    shape: _roundedRectangleBorder,
    isScrollControlled: true,
    builder: (context) {
      return const  UtilitiesSheet();
    },
  );
}


void airtimeDataSheet({
  BuildContext? context,
}) {
  showModalBottomSheet(
    context: context!,
    barrierColor: AppColors.primaryColor.withOpacity(0.2),
    shape: _roundedRectangleBorder,
    isScrollControlled: true,
    builder: (context) {
      return const  AirtimeDataSheet();
    },
  );
}

void rubyLimitSheet({
  BuildContext? context,
}) {
  showModalBottomSheet(
    context: context!,
    barrierColor: AppColors.primaryColor.withOpacity(0.2),
    shape: _roundedRectangleBorder,
    isScrollControlled: true,
    builder: (context) {
      return const RubyLimitSheet();
    },
  );
}

void emeraldSheet({
  BuildContext? context,
}) {
  showModalBottomSheet(
    context: context!,

    barrierColor: AppColors.primaryColor.withOpacity(0.2),
    shape: _roundedRectangleBorder,
    isScrollControlled: true,
    builder: (context) {
      return const EmeraldsSheet();
    },
  );
}

void verifyAddressSheet({
  BuildContext? context,
}) {
  showModalBottomSheet(
    context: context!,
    barrierColor: AppColors.primaryColor.withOpacity(0.2),
    shape: _roundedRectangleBorder,
    isScrollControlled: true,
    builder: (context) {
      return  VerifyAddressSheet(onUpdateAddressVerification: (bool ) {  },

      );
    },
  );
}


void confirmAccountSheet({
  BuildContext? context,
  OutwardTransferModel? outwardTransferModel,
  String? accountName,
  String? bankName,
  String? accountNum,
  String? clientReference,
  String? narration,
  String? bankCode,
  int? amount
}) {
  showModalBottomSheet(
    context: context!,


    barrierColor: AppColors.primaryColor.withOpacity(0.2),
    shape: _roundedRectangleBorder,
    isScrollControlled: true,
    builder: (context) {
      return  ConfirmAccountSheet(
        outwardTransferModel: outwardTransferModel,
        accountName: accountName,
        bankName: bankName,
        accountNum: accountNum,
        amount: amount,
        clientReference: clientReference,
        narration: narration,
        bankCode: bankCode ?? '',
      );
    },
  );
}

void confirmWithdrawSheet({
  BuildContext? context,
}) {
  showModalBottomSheet(
    context: context!,
    barrierColor: AppColors.primaryColor.withOpacity(0.2),
    shape: _roundedRectangleBorder,
    isScrollControlled: true,
    builder: (context) {
      return const ConfirmWithdrawSheet();
    },
  );
}
void enterPinSheet({
  BuildContext? context,
  required bool isFromSellButton,
  String? originPage,
  final String? receiverName,
  final String? receiverUsername,
  final double? amount,
  final String? narration,
  final String? clientReference,
  final int? receiverId,
  final String? currency,
}) {
  showModalBottomSheet(
    context: context!,
    barrierColor: AppColors.primaryColor.withOpacity(0.2),
    shape: _roundedRectangleBorder,
    isScrollControlled: true,
    builder: (context) {
      return EnterPinSheet(
          isFromSellButton: isFromSellButton,
              originPage: originPage ,
          receiverName: receiverName,
          receiverUsername: receiverUsername,
          amount: amount,
          narration: narration,
          clientReference: clientReference,
          receiverId: receiverId,
          currency: currency
      );
    },
  );
}

void paymentSuccessSheet({
  BuildContext? context,
  int? totalAmount,
  String? referenceNumber,
  String? paymentTime,
  String? paymentMethod,
  String? senderName,
  String? receiverName
}) {
  showModalBottomSheet(
    context: context!,
    barrierColor: AppColors.primaryColor.withOpacity(0.2),
    shape: _roundedRectangleBorder,
    isScrollControlled: true,
    builder: (context) {
      return  PaymentSuccessSheet(
          totalAmount: totalAmount,
          receiverName: receiverName,
          referenceNumber: referenceNumber,
          paymentTime: paymentTime,
          paymentMethod: paymentMethod,
          senderName: senderName


      );
    },
  );
}

void exchangeSuccessfulSheet({
  BuildContext? context,
}) {
  showModalBottomSheet(
    context: context!,
    barrierColor: AppColors.primaryColor.withOpacity(0.2),
    shape: _roundedRectangleBorder,
    isScrollControlled: true,
    builder: (context) {
      return const ExchangeSuccessfulSheet();
    },
  );
}

void buySuccessfulSheet({
  BuildContext? context,
  required bool isFromSellButton,
}) {
  showModalBottomSheet(
    context: context!,
    barrierColor: AppColors.primaryColor.withOpacity(0.2),
    shape: _roundedRectangleBorder,
    isScrollControlled: true,
    builder: (context) {
      return  BuySuccessfulSheet(
        isFromSellButton: isFromSellButton,
      );
    },
  );
}

void withdrawSuccessSheet({
  BuildContext? context,
}) {
  showModalBottomSheet(
    context: context!,
    barrierColor: AppColors.primaryColor.withOpacity(0.2),
    shape: _roundedRectangleBorder,
    isScrollControlled: true,
    builder: (context) {
      return const WithdrawSuccessSheet();
    },
  );
}

void  withdrawWithUsernameSheet ({
  BuildContext? context,
  TedFinanceUser? tedFinanceUser,
  String? receiverUsername,
  String? receiverName,
  String? currency,
  int? amount,
  int? recieverId,
  String? clientReference,
  String? narration,

}) {
  showModalBottomSheet(
    context: context!,
    barrierColor: AppColors.primaryColor.withOpacity(0.2),
    shape: _roundedRectangleBorder,
    isScrollControlled: true,
    builder: (context) {
      return  WithdrawUsernameSheet(
        receiverName: receiverName,
        amount: amount,
        receiverUsername: receiverUsername,
        clientReference: clientReference,
        narration: narration,
        receiverId: recieverId,
        currency: currency,
        tedFinanceUser: tedFinanceUser,

      );
    },
  );

}
void  moneySentSuccessfullySheet ({
  BuildContext? context,
}) {
  showModalBottomSheet(
    context: context!,
    barrierColor: AppColors.primaryColor.withOpacity(0.2),
    shape: _roundedRectangleBorder,
    isScrollControlled: true,
    builder: (context) {
      return const MoneySentSuccessSheet();
    },
  );

}
void  virtualCardActivatedSheet ({
  BuildContext? context,
}) {
  showModalBottomSheet(
    context: context!,
    barrierColor: AppColors.primaryColor.withOpacity(0.2),
    shape: _roundedRectangleBorder,
    isScrollControlled: true,
    builder: (context) {
      return const VirtualCardActivatedSheet();
    },
  );

}
void  fundAddedSuccessSheet ({
  BuildContext? context,
}) {
  showModalBottomSheet(
    context: context!,
    barrierColor: AppColors.primaryColor.withOpacity(0.2),
    shape: _roundedRectangleBorder,
    isScrollControlled: true,
    builder: (context) {
      return const FundAddedSuccessSheet();
    },
  );
}


void cablePaymentSuccessSheet ({
  BuildContext? context,
}) {
  showModalBottomSheet(
    context: context!,
    barrierColor: AppColors.primaryColor.withOpacity(0.2),
    shape: _roundedRectangleBorder,
    isScrollControlled: true,
    builder: (context) {
      return const CablePaymentSuccessSheet();
    },
  );
}

void dataPurchaseSuccessSheet ({
  BuildContext? context,
}) {
  showModalBottomSheet(
    context: context!,
    barrierColor: AppColors.primaryColor.withOpacity(0.2),
    shape: _roundedRectangleBorder,
    isScrollControlled: true,
    builder: (context) {
      return const DataPurchaseSuccessSheet();
    },
  );
}
void airtimePurchaseSuccessSheet ({
  BuildContext? context,
}) {
  showModalBottomSheet(
    context: context!,
    barrierColor: AppColors.primaryColor.withOpacity(0.2),
    shape: _roundedRectangleBorder,
    isScrollControlled: true,
    builder: (context) {
      return const AirtimePurchaseSuccessSheet();
    },
  );
}

void  successfulWithdrawSheet ({
  BuildContext? context,
}) {
  showModalBottomSheet(
    context: context!,
    barrierColor: AppColors.primaryColor.withOpacity(0.2),
    shape: _roundedRectangleBorder,
    isScrollControlled: true,
    builder: (context) {
      return const SuccessfulWithdrawalSheet();
    },
  );
}

void  frozenSuccessSheet ({
  BuildContext? context,
}) {
  showModalBottomSheet(
    context: context!,
    barrierColor: AppColors.primaryColor.withOpacity(0.2),
    shape: _roundedRectangleBorder,
    isScrollControlled: true,
    builder: (context) {
      return const FrozenCardSheet();
    },
  );
}

void  deleteSuccessSheet ({
  BuildContext? context,
}) {
  showModalBottomSheet(
    context: context!,
    barrierColor: AppColors.primaryColor.withOpacity(0.2),
    shape: _roundedRectangleBorder,
    isScrollControlled: true,
    builder: (context) {
      return const DeleteSuccessSheet();
    },
  );
}
void  selfieSampleSheet ({
  BuildContext? context,
}) {
  showModalBottomSheet(
    context: context!,
    barrierColor: AppColors.primaryColor.withOpacity(0.2),
    shape: _roundedRectangleBorder,
    isScrollControlled: true,
    builder: (context) {
      return const SelfieSampleSheet();
    },
  );
}