import 'dart:core';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tedfinance_mobile/core/Dashboard/card1/cards/enter_pin.dart';
import 'package:tedfinance_mobile/core/Dashboard/drawer/bottom_sheet/widget/enter_pin.dart';
import 'package:tedfinance_mobile/core/env/utils/colors.dart';
import 'package:tedfinance_mobile/core/env/utils/string_resources.dart';
import 'package:tedfinance_mobile/core/utililies.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';

import '../../../../../providers/dashboard_provider.dart';
import '../../../../../shared/models/kyc_model/transfer_model.dart';
import '../../../../../shared/navigations/routes/navigation_service.dart';
import '../../../../../theme/custom_text_style.dart';
import '../../../card1/transfer/traansfer.dart';

class ConfirmAccountSheet extends StatefulWidget {
  final String? accountName;
  final String? bankName;
  final String? accountNum;
  final int? amount;
  final String? clientReference;
  final String? narration;
  final String? bankCode;
  final OutwardTransferModel? outwardTransferModel;

  const ConfirmAccountSheet({super.key,
    this.accountName,
    this.bankName,  this.accountNum, this.amount, this.clientReference, this.narration, this.bankCode, this.outwardTransferModel});

  @override
  State<ConfirmAccountSheet> createState() => _ConfirmAccountSheetState();
}

class _ConfirmAccountSheetState extends State<ConfirmAccountSheet> {
  OutwardTransferModel? outwardTransferModel;

Utilities utilis = Utilities();

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
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 55.h),
      child: SizedBox(
        height: 550,
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(AssetResources.questionIcon),
                8.horizontalSpace,
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "Please confirm you have\nprovided the correct details.",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.tedDeepPurple),
                      ),
                      TextSpan(
                        text: "\n",
                      ),
                      TextSpan(
                        text:
                            "Providing the wrong information will cause delay\nwith payment.",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppColors.tedDeepPurple),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            30.verticalSpace,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10.r)),
              child: Column(
                children: [
                  Text(
                    StringResources.bankAccountDetails,
                    style: CustomTextStyles.titleMedium18,
                  ),
                  40.verticalSpace,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(AssetResources.stepperIcon2),
                      20.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Account Name'),
                          65.verticalSpace,
                          Text('Bank Name'),
                          18.verticalSpace,
                          Text('Account No'),
                          20.verticalSpace,
                          const Text(
                            'Change Method',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                          )
                        ],
                      ),
                      50.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(  widget.accountName ?? 'Abdullateef Ayodele ',
                              style:
                                  CustomTextStyles.titleSmallBlack400.copyWith(
                                fontWeight: FontWeight.w600,
                              )),
                          43.verticalSpace,
                          Text(
                             utilis. shortenBankName(widget.bankName ?? 'Kuda Bank'),
                              style:
                                  CustomTextStyles.titleSmallBlack400.copyWith(
                                fontWeight: FontWeight.w600,
                              )),
                          18.verticalSpace,
                          Text(
                             widget.accountNum ?? '222222222',
                            style: CustomTextStyles.titleSmallBlack400.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          18.verticalSpace,
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            60.verticalSpace,
            AppButton(
              onPressed: () {
                // pushToWithRoute(context, CustomRoutes.slideIn(EnterPinVirtualSheet(
                //   originPage: "OutWardTransfer",
                // outwardTransferModel: outwardTransferModel,
                //
                //
                // //     OutwardTransferModel result =
                // // await Provider.of<DashboardProvider>(context, listen: false)
                // //     .outwardTransfer(
                // //   sourceAccountId: walletModel!.accountId.toString(),
                // //   amount: int.parse(_amountController.text),
                // //   clientReference: utils.generateClientReference(),
                // //   narration: _narrationController.text,
                // //   destinationBankCode: selectedBank!.bankCode ?? '',
                // //   destinationAccount: _accountNumberController.text,
                // //   destinationAccountName: _fullNameController.text,
                // //   destinationBankName: selectedBank!.displayName,
                // // );
                // ) ));
              pushToAndClearStack(context, const TransferPage());
              },
              text: 'Add Payment Method',
              width: 350.w,
              color: AppColors.primaryColor,
              radius: 30.r,
            )
          ],
        ),
      ),
    );
  }
}
