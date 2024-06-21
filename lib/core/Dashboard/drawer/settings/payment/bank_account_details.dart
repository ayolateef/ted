import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tedfinance_mobile/core/env/utils/string_resources.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_text_form_field.dart';
import 'package:tedfinance_mobile/theme/custom_text_style.dart';

import '../../../../../shared/util/widgets/appbar.dart';
import '../../../../env/utils/colors.dart';
import '../../bottom_sheet/root.dart';

class BankAccountDetails extends StatefulWidget {
  const BankAccountDetails({super.key});

  @override
  State<BankAccountDetails> createState() => _BankAccountDetailsState();
}

class _BankAccountDetailsState extends State<BankAccountDetails> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        appBar: const TedAppBar(
          elevation: 0,
          titleText: StringResources.bankAccountDetails,
          trailing: SizedBox(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
            child: Column(
                  children: [
                  CustomTextFormField(
              headerText: "Bank",
              hintText: "Select Bank",
              prefix: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(AssetResources.addPayIcon, height: 12,width: 14.w),
              ),
              suffix: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0, ),
                child: SvgPicture.asset(AssetResources.dropdownIcon, height: 12,),
              ),
            ),
                    30.verticalSpace,
                    CustomTextFormField(
                      headerText: "Account Number",
                      hintText: "Recipient  Account Number ",
          
                    ),
                    30.verticalSpace,
                    CustomTextFormField(
                      headerText: "Full name",
                      hintText: "Recipient Name",
          
                    ),
                    30.verticalSpace,
                    CustomTextFormField(
                      headerText: "Email(Optional)",
                      hintText: "Recipient Email Address",
                    ),
                   180.verticalSpace,
                    Row(
                      children: [
                        SvgPicture.asset(AssetResources.questionIcon),
                        10.horizontalSpace,
                        Text(StringResources.by_proceeding_with_this_payment ,
                          style: CustomTextStyles.titleSmallBlack400.copyWith(
                            color: AppColors.tedDeepPurple
                          ),
                        )
                      ],
                    ),
                     30.verticalSpace,
                     AppButton(
                       width: 340.w,
                      onPressed: (){
                        confirmAccountSheet(context: context);
                              },
                       radius: 30.r,
                      text: 'Continue',
                    )
                  ],
                ),
          ),
        ));
  }
}
