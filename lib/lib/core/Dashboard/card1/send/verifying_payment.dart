import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tedfinance_mobile/core/Dashboard/drawer/bottom_sheet/root.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_containers.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_text_form_field.dart';
import 'package:tedfinance_mobile/theme/custom_text_style.dart';

import '../../../../shared/util/asset_images.dart';
import '../../../../shared/util/widgets/appbar.dart';
import '../../../env/utils/colors.dart';
import '../../../env/utils/string_resources.dart';

class VerifyingPayment extends StatefulWidget {
  const VerifyingPayment({super.key});

  @override
  State<VerifyingPayment> createState() => _VerifyingPaymentState();
}

class _VerifyingPaymentState extends State<VerifyingPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TedAppBar(
            elevation: 0,
            titleText: StringResources.verifying_payments,
            trailing: Container()),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(AssetResources.masterCard2),
                    Image.asset(AssetResources.chaseBank),
                  ],
                ),
                Text.rich(
                  textScaler: TextScaler.linear(1.0),
                  TextSpan(
                    style: TextStyle(
                        color: AppColors.tedBlackText,
                        fontSize: 12.sp,
                        height: 2.5.h),
                    children: [
                      const TextSpan(
                        text:
                            "Please enter your Mastercard SecureCode One Time Pass Code (OTP) in\nthe field below to confirm your identity for the payment with your Chase\nDebit Card. ",
                      ),
                      const TextSpan(
                        text:
                            "This information has been sent via SMS to your Mobile No.\nregistered with your bank and is not shared with the merchant.\n",
                      ),
                      TextSpan(
                        text:
                            "NOTE: Don’t share code with anyone if you didn’t authorize this Pay.",
                        style: TextStyle(
                            color: AppColors.tedRedText, fontSize: 13.sp),
                      ),
                    ],
                  ),
                ),
                20.verticalSpace,
               GeneralContainer(
                   widget: Column(
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           const Text('Card Number'),
                           Text(
                             'XXXX XXXX XXXX 5068',
                             style: CustomTextStyles.titleMediumBlack600,
                           ),
                         ],
                       ),
                       20.verticalSpace,
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           const Text('Merchant'),
                           Text(
                             'TedFinance',
                             style: CustomTextStyles.titleMediumBlack600,
                           ),
                         ],
                       ),
                       20.verticalSpace,
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           const Text('Amount'),
                           Text(
                             '\$4,500.97',
                             style: CustomTextStyles.titleMediumBlack600,
                           ),
                         ],
                       ),
                       20.verticalSpace,
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           const Text('Mobile No.'),
                           Text(
                             'XXX XXX 8305',
                             style: CustomTextStyles.titleMediumBlack600,
                           ),
                         ],
                       ),
                       30.verticalSpace,
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text('Enter OTP'),
                           20.horizontalSpace,
                           Container(
                             width: 200,
                             child:   const CustomTextFormField(
                               hintText: 'Enter Code',
                             ),
                           )
                         ],
                       ),
                       20.verticalSpace,
                       TextButton(
                         onPressed: () {  },
                         child: const Text(
                             'Resend OTP',
                             style: TextStyle(
                                 color: AppColors.primaryColor,
                                 decoration: TextDecoration.underline,
                                 fontWeight: FontWeight.w600
                             )
                         ),
                       ),
                       30.verticalSpace,
                       AppButton(
                         onPressed: (){
                          moneySentSuccessfullySheet(context: context);
                         },
                         text: "Send \$4,500.97",
                         radius: 30.r,
                         width: 330.w,
                       ),
                       70.verticalSpace,
                     ],
                   ),

               )
              ],
            ),
          ),
        ));
  }
}
