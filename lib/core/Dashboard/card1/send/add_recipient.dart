import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tedfinance_mobile/core/Dashboard/card1/send/review.dart';
import 'package:tedfinance_mobile/core/Dashboard/kyc_verification.dart';
import 'package:tedfinance_mobile/core/env/utils/string_resources.dart';
import 'package:tedfinance_mobile/shared/navigations/routes/navigation_service.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_text_form_field.dart';

import '../../../../../shared/util/widgets/appbar.dart';
import '../../../../shared/util/widgets/custom_containers.dart';
import '../../../env/utils/colors.dart';
import '../../drawer/bottom_sheet/root.dart';


class AddRecipient extends StatefulWidget {
  const AddRecipient({super.key});

  @override
  State<AddRecipient> createState() => _AddRecipientState();
}

class _AddRecipientState extends State<AddRecipient> {
  bool isAddNewRecipient = true ;
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        appBar: const TedAppBar(
          elevation: 0,
          titleText: StringResources.add_recipient,
          trailing: SizedBox(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
            child: Column(
              children: [
              isAddNewRecipient
                  ? Column(
                  children: [
                    CustomTextFormField(
                      fillColor: AppColors.tedButtonGrey,
                      hintText: 'Search',
                      suffix: Padding(
                        padding:  EdgeInsets.symmetric(horizontal:  15.0.w, ),
                        child: SvgPicture.asset(AssetResources.searchIcon, height: 20, width: 20,),
                      ),
                      radius: 30.r,

                    ),
                    40.verticalSpace,
                    PaymentContainer(
                      onTap: () {
                        // addPaymentMethodSheet(context: context);
                        setState(() {
                          isAddNewRecipient = false;
                        });
                      },
                      imagePath: AssetResources.addPayIcon,
                      titleText: StringResources.add_new_recipient,
                      subTitleText: StringResources.method_via_credit,
                      icon: Icons.arrow_forward_ios,
                      isSvg: true,
                    ),
                    30.verticalSpace,
                    PaymentContainer(
                      onTap: () {
                        confirmWithdrawSheet(context: context);
                      },
                      imagePath: AssetResources.picNig,
                      titleText: StringResources.ayoLateef,
                      subTitleText: StringResources.kuda,
                      isSvg: false,

                    )
                  ],
                )
               : Column(
                  children: [
                    CustomTextFormField(
                      headerText: "Delivery Method",
                      hintText: "Bank Account",
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
                      headerText: "Bank",
                      hintText: "Choose Bank",
                      suffix: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0, ),
                        child: SvgPicture.asset(AssetResources.dropdownIcon, height: 12,),
                      ),
                    ),
                    30.verticalSpace,
                    const CustomTextFormField(
                      headerText: "Account Number",
                      hintText: "Recipient Account Number",
                      textInputType: TextInputType.number,

                    ),
                    30.verticalSpace,
                    const CustomTextFormField(
                      headerText: "Full name",
                      hintText: "Recipient Name",
                    ),
                    30.verticalSpace,
                    const CustomTextFormField(
                      headerText: "Email(Optional)",
                      hintText: "Recipient Email Address",
                    ),
                    30.verticalSpace,
                   const BigPinkContainer(
                     text: StringResources.by_proceeding_with_this_payment ,
                   ),
                    30.verticalSpace,
                    AppButton(
                      width: 340.w,
                      onPressed: (){
                        //confirmAccountSheet(context: context);
                        PageNavigator(ctx: context).nextPage(page: const Review());

                      },
                      radius: 30.r,
                      text: 'Continue',
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
