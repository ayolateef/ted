import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tedfinance_mobile/core/env/utils/string_resources.dart';
import 'package:tedfinance_mobile/shared/models/dashboard_models/transfer_tedFinance_user.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';
import 'package:tedfinance_mobile/theme/custom_text_style.dart';

import '../../../../../providers/dashboard_provider.dart';
import '../../../../../shared/models/dashboard_models/card_bal_model.dart';
import '../../../../../shared/models/dashboard_models/current_ex_model.dart';
import '../../../../../shared/models/dashboard_models/username_lookup_model.dart';
import '../../../../../shared/models/dashboard_models/wallet_model.dart';
import '../../../../../shared/util/share_preference_util.dart';
import '../../../../../shared/util/widgets/custom_pin_code_text_field.dart';
import '../../../../env/utils/alert_toast.dart';
import '../../../../env/utils/colors.dart';
import '../root.dart';

class EnterPinSheet extends StatefulWidget {
  final bool isFromSellButton;
  final String? originPage;
  final String? receiverName;
  final String? receiverUsername;
  final double? amount;
  final String? narration;
  final String? clientReference;
  final int? receiverId;
  final String? currency;


  const EnterPinSheet({super.key, required this.isFromSellButton, this.originPage, this.amount, this.receiverName, this.receiverUsername, this.narration, this.clientReference, this.receiverId, this.currency });

  @override
  State<EnterPinSheet> createState() => _EnterPinSheetState();
}

class _EnterPinSheetState extends State<EnterPinSheet> {
  late  TextEditingController _enterPinController = TextEditingController();
  Username? usernameModel;
  CardBalModel? cardBalModel;
  CurrentFxModel? currentFxModel;
  int? receiverId;
  String narration = 'Send1';
  WalletModel? walletModel;
  late DashboardProvider dashboardProvider ;
  TedFinanceUser? tedFinanceUser;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void dispose() {
    _enterPinController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          30.verticalSpace,
          Padding(
            padding:  EdgeInsets.only(left: 20.w, top: 20.0),
            child: InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Image.asset(AssetResources.closeIcon)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              40.verticalSpace,
              Container(
                color: Colors.transparent,
                child: Image.asset(
                  AssetResources.enterPinImage,
                ),
              ),
              30.verticalSpace,
              Text(
                StringResources.enterPin,
                style: CustomTextStyles.headlineSmallOnPrimary
                    .copyWith(color: (AppColors.tedBigTextPurpleColor)),
              ),
              30.verticalSpace,
              Text(
                StringResources.enter_your_digit,
                style: CustomTextStyles.bodySmallGray500
              ),
              30.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: CustomPinCodeTextField(
                  context: context,
                  controller: _enterPinController,
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a PIN';
                    }
                    return null;
                  },
                  readOnly: false,
                  borderRadius: BorderRadius.circular(1.1),
                ),
              ),
              40.verticalSpace,
              AppButton(
                onPressed: () {
                  Navigator.of(context).pop;
                  userActivity();
                 // paymentSuccessSheet(context: context);
                  // userActivity();
                  //exchangeSuccessfulSheet(context:  context);
                  // buySuccessfulSheet(
                  //     context: context,
                  //   isFromSellButton: widget.isFromSellButton,
                  //
                  // );


                },
                text: 'Continue',
                width: 350.w,
                color: AppColors.primaryColor,
                radius: 30.r,
              )
            ],
          ),
        ],
      ),
    );
  }
  void userActivity() async {
    final pin = _enterPinController.text;
    // final savedPin = await SharedPreferenceUtils.getPin();
    const storage = FlutterSecureStorage();
    final savedPin = await storage.read(key: 'pin');

    print("Entered PIN: $pin");
    print("Saved PIN: $savedPin");

    if (savedPin == null) {
      AlertToast(context: context)
          .showError("No PIN found. Please create a PIN first.");
        return;
      }
      if (pin == savedPin) {
        try {
          if (widget.originPage == "sendToTedFinanceUser") {
            await sendMoneyWithUsername();
            dashboardProvider.setCardActivated(true);
          if (mounted) {
            paymentSuccessSheet(
                context: context,
                totalAmount: tedFinanceUser?.totalAmount?.toInt(),
              referenceNumber: tedFinanceUser?.clientReference,
                paymentTime: DateFormat('yyyy-MM-dd HH:mm:ss').format(tedFinanceUser?.timestamp ?? DateTime.now()),
              paymentMethod: tedFinanceUser?.transferType,
              senderName: tedFinanceUser?.sourceAccountName



            );
          }
        }
        // else if (widget.originPage == 'Add Fund') {
        //   await fundCard();
        //   if (mounted) {
        //     fundAddedSuccessSheet(context: context);
        //   }
        // }
        // else if (widget.originPage == 'FreezeCard') {
        //   await freezeUnfreezeCard();
        //   if (mounted) {
        //     frozenSuccessSheet(context: context);
        //   }
        // } else if (widget.originPage == "Withdraw Fund") {
        //   withdrawFromCard();
        //   if (mounted) {
        //     successfulWithdrawSheet(context: context);
        //   }
        // } else if (widget.originPage == "Delete Card") {
        //   await deleteCard();
        //   if (mounted) {
        //     deleteSuccessSheet(context: context);
        //   }
        } catch (e) {
        AlertToast(context: context).showError(e.toString());
      }
    } else {
      AlertToast(context: context).showError("Invalid PIN. Please try again.");
    }
  }
  Future <void> sendMoneyWithUsername() async {
    try {
      print('receiverId: ${usernameModel!.id!}');
      //" ${Provider.of<DashboardProvider>(context).amount}"
      await dashboardProvider.sendMoneyToTedFinanceUser(
        amount: widget.amount?.toInt() ,
        recieverId: widget.receiverId,
        clientReference: widget.clientReference,
        narration: widget.narration,
      );

      // withdrawWithUsernameSheet(context: context, isSendWithUsername: usernamePage);
    } catch (e) {
      AlertToast(context: context,).showError(e.toString());
    }
  }
}
