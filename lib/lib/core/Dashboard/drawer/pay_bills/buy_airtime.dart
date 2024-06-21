import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tedfinance_mobile/shared/navigations/routes/navigation_service.dart';

import '../../../../shared/util/asset_images.dart';
import '../../../../shared/util/widgets/appbar.dart';
import '../../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../../shared/util/widgets/custom_text_form_field.dart';
import '../../../../theme/custom_text_style.dart';
import '../../../env/utils/string_resources.dart';
import 'cable_tv_payment.dart';

class BuyAirtime  extends StatelessWidget {
  const BuyAirtime ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  TedAppBar(
          elevation: 0,
          titleWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text( StringResources.buy_airtime, style: CustomTextStyles.titleMedium18,),
              5.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("NGN 00.00 available", style: CustomTextStyles.bodySmallBlack900 ),
                  5.horizontalSpace,
                  SvgPicture.asset(AssetResources.dropdownIcon, height: 10.h, width: 10.w,)
                ],
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              const CustomTextFormField(
                headerText: "Amount",
                hintText: "NGN 0.00",
              ),
              30.verticalSpace,
              // CustomDropdownFormField(
              //   headerText: "Network",
              //   hintText: "Select Network",
              //   currencies: const ["MTN", "GLO"],
              //   onChanged: (currency) {
              //     // Do something with the selected currency
              //   },
              // ),
              40.verticalSpace,
              const CustomTextFormField(
                headerText: "Phone number",
                hintText: "1234 5678 9101",
              ),

              30.verticalSpace,
              AppButton(
                onPressed: (){
                  PageNavigator(ctx: context).nextPage(page: const CableTvPayment());
                },
                text: 'Continue',
                radius: 30.r,
                width: 350.w,

              ),

            ],
          ),
        )

    );
  }
}
