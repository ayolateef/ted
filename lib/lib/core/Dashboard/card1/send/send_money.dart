import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tedfinance_mobile/core/Dashboard/card1/send/add_recipient.dart';
import 'package:tedfinance_mobile/core/Dashboard/kyc/kyc_verification.dart';
import 'package:tedfinance_mobile/shared/navigations/routes/navigation_service.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_text_form_field.dart';
import 'package:tedfinance_mobile/theme/custom_text_style.dart';

import '../../../../shared/util/widgets/appbar.dart';
import '../../../../shared/util/widgets/custom_containers.dart';
import '../../../env/utils/colors.dart';
import '../../../env/utils/string_resources.dart';

class SendMoney extends StatefulWidget {
  const SendMoney({super.key});

  @override
  State<SendMoney> createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TedAppBar(
        elevation: 0,
        titleText: StringResources.send_money,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(
                headerText: "Send Currency",
                hintText: "Select Country",
                focusNode: null,
                suffix: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(AssetResources.dropdownIcon)
                ),
              ),
              20.verticalSpace,
              Container(
                width: double.infinity,
                height: 120.h,
                padding: EdgeInsets.only(left: 15.w, top: 15.h),
                color: AppColors.white2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(StringResources.you_re_sending, style: CustomTextStyles.bodySmallGray800
                      .copyWith(color: AppColors.primaryColor),
                      ),
                    10.verticalSpace,
                Text( '\$0.00', style: CustomTextStyles.titleLargeBlack
                    .copyWith(fontSize: 32.0.sp)
                ),
                  ],
                ),
              ),
              20.verticalSpace,
               Row(
                 children: [
                   GreyCirclesWithLines(
                    circleRadius: 7.0,
                    lineWidth: 2.5,
                    circleColor: AppColors.grey[65]!,
                    lineColor: AppColors.grey[65]!,
                               ),
                   20.horizontalSpace,
                    Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text('Rate'),
                       20.verticalSpace,
                       Text('Fee'),
                       20.verticalSpace,
                       Text('Total to Pay'),
                     ],
                   ),
                   Spacer(),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                        Text('\$=N 1420.92',
                           style:CustomTextStyles.titleMediumBlack600
                           .copyWith(),
                        ),
                       20.verticalSpace,
                       Text('FREE', style: CustomTextStyles.titleMediumBlack600
                           .copyWith(color:AppColors.tedGreen2)
                       ),
                       20.verticalSpace,
                       Text('\$4,500.00',
                         style:CustomTextStyles.titleMediumBlack600
                           .copyWith(),),
                     ],
                   )
                 ],
               ),
              20.verticalSpace,
              CustomTextFormField(
                headerText: "Receiver Currency ",
                hintText: "Select Country",
                suffix: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(AssetResources.dropdownIcon)
                ),
              ),
              20.verticalSpace,
              Container(
                width: double.infinity,
                height: 120.h,
                padding: EdgeInsets.only(left: 15.w, top: 15.h),
                color: AppColors.white2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(StringResources.receiver_get, style: CustomTextStyles.bodySmallGray800
                        .copyWith(color: AppColors.primaryColor),
                    ),
                    10.verticalSpace,
                    Text( '\$0.00', style: CustomTextStyles.titleLargeBlack
                        .copyWith(fontSize: 32.0.sp)
                    ),
                  ],
                ),
              ),
              20.verticalSpace,



               BigPinkContainer(
                text: StringResources.your_recipient_will_receive_notification,
                height: 150.h,
              ),
              20.verticalSpace,
              Center(
                child: AppButton(
                  onPressed: (){
                    PageNavigator(ctx: context).nextPage(page: const AddRecipient());
                  },
                  text: 'Confirm',
                  radius: 25.r,
                  width: 320.w,

                ),
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
