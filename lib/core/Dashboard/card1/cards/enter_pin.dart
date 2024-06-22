import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tedfinance_mobile/core/Dashboard/drawer/bottom_sheet/root.dart';
import 'package:tedfinance_mobile/core/env/utils/string_resources.dart';
import 'package:tedfinance_mobile/shared/models/kyc_model/transfer_model.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';
import 'package:tedfinance_mobile/theme/custom_text_style.dart';
import '../../../../../shared/util/widgets/custom_pin_code_text_field.dart';
import '../../../../providers/auth_provider.dart';
import '../../../../providers/dashboard_provider.dart';
import '../../../../shared/models/dashboard_models/wallet_model.dart';
import '../../../../shared/util/share_preference_util.dart';
import '../../../env/utils/alert_toast.dart';
import '../../../env/utils/colors.dart';

class EnterPinVirtualSheet extends StatefulWidget {
  final String? originPage;
  final String? amountNGN;
  final String? amountUSD;
  final String? selectedCurrency;
  final String? accountNum;
  final String? accountName;
  final String? bankName;

  final OutwardTransferModel? outwardTransferModel;
  const EnterPinVirtualSheet({
    super.key,
    this.originPage,
    this.amountNGN,
    this.selectedCurrency,
    this.amountUSD,
    this.outwardTransferModel, this.accountNum, this.accountName, this.bankName
  });

  @override
  State<EnterPinVirtualSheet> createState() => _EnterPinVirtualSheetState();
}

class _EnterPinVirtualSheetState extends State<EnterPinVirtualSheet> {
  final TextEditingController _enterPinController = TextEditingController();
  late AuthenticationProvider authenticationProvider;
  final bool _isCardActivated = false;
  late DashboardProvider dashboardProvider;
  OutwardTransferModel? outwardTransferModel;
  bool _isLoading = false ;
  WalletModel? walletModel;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      Provider.of<DashboardProvider>(context, listen: false)
          .outwardTransfer(
        destinationAccount: widget.accountNum ?? '',
        destinationAccountName: widget.accountName ?? '',
        destinationBankName:  widget.bankName ?? '',

      )
          .then((value) {
        if (mounted) {
          setState(() {
            outwardTransferModel= value;
          });
        }
      });

    });


  }

  @override
  void dispose() {
    _enterPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authenticationProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  30.verticalSpace,
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, top: 20.0),
                    child: InkWell(
                        onTap: () {
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
                      Text(StringResources.enter_your_digit,
                          style: CustomTextStyles.bodySmallGray500),
                      30.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: CustomPinCodeTextField(
                          context: context.widget != null ? context : null,
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
                          //Navigator.of(context).pop;
                          cardActivity();
                          //  paymentSuccessSheet(context: context);
                          //virtualCardActivatedSheet(context: context);
                          //  fundAddedSuccessSheet(context:  context);
                          //  successfulWithdrawSheet(context:  context);
                          //  frozenSuccessSheet(context: context);
                          // deleteSuccessSheet(context: context);
                        },
                        text: _isLoading ? 'Loading...' : 'Continue',
                        width: 350.w,
                        color: AppColors.primaryColor,
                        radius: 30.r,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.white.withOpacity(0.8),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void cardActivity() async {
    final pin = _enterPinController.text;
    final savedPin = await SharedPreferenceUtils.getPin();

    print("Entered PIN: $pin");
    print("Saved PIN: $savedPin");

    if (savedPin == null) {
      AlertToast(context: context)
          .showError("No PIN found. Please create a PIN first.");
      return;
    }

    if (pin == savedPin) {
      try {
        if (widget.originPage == "Activate Card") {
          await activateCard();
          dashboardProvider.setCardActivated(true);
          if (mounted) {
            virtualCardActivatedSheet(context: context);
          }
        }

        else if (widget.originPage == 'Add Fund') {
          await fundCard();
          if (mounted) {
            fundAddedSuccessSheet(context: context);
          }
        }
        else if (widget.originPage == 'FreezeCard') {
          await freezeUnfreezeCard();
          if (mounted) {
            frozenSuccessSheet(context: context);
          }
        } else if (widget.originPage == "Withdraw Fund") {
          withdrawFromCard();
          if (mounted) {
            successfulWithdrawSheet(context: context);
          }
        } else if (widget.originPage == "Delete Card") {
          await deleteCard();
          if (mounted) {
            deleteSuccessSheet(context: context);
          }
        }
      } catch (e) {
        AlertToast(context: context).showError(e.toString());
      }
    } else {
      AlertToast(context: context).showError("Invalid PIN. Please try again.");
    }
  }

  Future<void> activateCard() async {
    try {
      await dashboardProvider.requestCard();
      dashboardProvider.setCardActivated(true);
      final sharedPrefs = await SharedPreferences.getInstance();
      sharedPrefs.setBool('card_activated', true);
    } catch (e) {
      AlertToast(context: context).showError(e.toString());
      throw e;
    }
  }

  Future<void> fundCard() async {
    try {
      await dashboardProvider.fundCard(
          amountUsd: double.parse(widget.amountUSD.toString().replaceAll(",", "")).toInt(),
          amountNGN: double.parse(widget.amountNGN.toString().replaceAll(",", "")).toInt(),
          sourceOfFund: widget.selectedCurrency ?? '');
      dashboardProvider.setCardActivated(true);
    } catch (e) {
      AlertToast(context: context).showError(e.toString());
      throw e;
    }
  }

  Future<void> freezeUnfreezeCard() async {
    try {
      await dashboardProvider.freezeOrUnfreezeAccount(false);
      dashboardProvider.setCardActivated(true);
    } catch (e) {
      AlertToast(context: context).showError(e.toString());
      rethrow;
    }
  }

  Future<void> deleteCard() async {
    try {
      await dashboardProvider.deleteCard();
      dashboardProvider.setCardActivated(true);
    } catch (e) {
      AlertToast(context: context).showError(e.toString());
      throw e;
    }
  }

  Future<void> withdrawFromCard() async {
    try {
      await dashboardProvider.withdrawFromCard(int.parse(widget.amountUSD.toString()));
      dashboardProvider.setCardActivated(true);
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(e.toString()),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      rethrow;
    }
  }

  Future<void> outwardTransfer() async {
    try {
      OutwardTransferModel result =
      await Provider.of<DashboardProvider>(context, listen: false)
          .outwardTransfer(
        sourceAccountId: walletModel!.accountId.toString(),
        amount: widget.outwardTransferModel?.amount,
        //int.parse(_amountController.text),
        clientReference: widget.outwardTransferModel?.clientReference,
        narration: widget.outwardTransferModel?.narration,
        //_narrationController.text,
        destinationBankCode: widget.outwardTransferModel?.destinationBankCode,
        destinationAccount: widget.outwardTransferModel?.destinationAccount,
        destinationAccountName: widget.outwardTransferModel?.destinationAccountName,
        destinationBankName: widget.outwardTransferModel?.destinationBankName
      );
      if(result != null){
        dashboardProvider.setCardActivated(true);
      }

    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(e.toString()),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      rethrow;
    }
  }

}
