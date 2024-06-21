
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tedfinance_mobile/core/Dashboard/kyc_verification.dart';

import '../../../../shared/navigations/routes/navigation_service.dart';
import '../../../../shared/util/asset_images.dart';
import '../../../../shared/util/widgets/appbar.dart';
import '../../../../shared/util/widgets/custom_containers.dart';
import '../../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../../theme/custom_text_style.dart';
import '../../../env/utils/colors.dart';
import '../../../env/utils/string_resources.dart';
import '../../card1/cards/enter_pin.dart';

class AirtimePayment extends StatelessWidget {
  const AirtimePayment({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  TedAppBar(
        elevation: 0,
        titleWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text( StringResources.buy_data, style: CustomTextStyles.titleMedium18,),
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
      body: SingleChildScrollView(
        child: Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 20.0,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BigPinkContainer(
                containerWidget: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Please confirm you have\n"
                            "provided the correct details.\n",
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: AppColors.tedDeepPurple,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      TextSpan(
                        text: "Providing the wrong information will cause delay.",
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.tedDeepPurple,  // Purple text color
                        ),
                      ),
                    ],
                  ),
                ),

                containerColor: Colors.transparent,
              ),
              20.verticalSpace,
              GeneralContainer(
                widget: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        children: [
                          Text(StringResources.payment_details,
                            style: CustomTextStyles.titleMediumBlack600,),
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
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  const Text('Description'),
                                  20.verticalSpace,
                                  const Text('Package'),
                                  20.verticalSpace,
                                  const Text('Transaction fee'),
                                  20.verticalSpace,
                                  const Text('Destination'),
                                  20.verticalSpace,
                                  const Text(''),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Airtime',
                                    style: CustomTextStyles
                                        .titleMediumBlack600
                                        .copyWith(),
                                  ),
                                  20.verticalSpace,
                                  Text(
                                    '0801 234 5678',
                                    style: CustomTextStyles
                                        .titleMediumBlack600
                                        .copyWith(),
                                  ),
                                  20.verticalSpace,
                                  Text(
                                    'FREE',
                                    style: CustomTextStyles
                                        .titleMediumBlack600
                                        .copyWith(color:
                                    AppColors.tedGreen2),
                                  ),
                                  20.verticalSpace,
                                  Text('1234 5678 9101',
                                      style: CustomTextStyles
                                          .titleMediumBlack600
                                          .copyWith(
                                      )),
                                  20.verticalSpace,
                                  Text(
                                    '',
                                    style: CustomTextStyles
                                        .titleMediumBlack600
                                        .copyWith(),
                                  ),
                                ],
                              )
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Amount', style: CustomTextStyles.bodySmallGray500 .
                                  copyWith(color: AppColors.primaryColor)
                                  ),
                                  Text('N 100.00', style: CustomTextStyles.titleLargeBlack.
                                  copyWith(fontSize: 29.sp),),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.r),
                                    color: AppColors.grey[65]
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AssetResources.mtnIcon),
                                    Text('MTN-NG', style: CustomTextStyles.titleMedium18,)
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),

              ),
              30.verticalSpace,
              AppButton(
                onPressed: (){
                  PageNavigator(ctx: context).nextPage(page: const EnterPinVirtualSheet());
                },
                text: 'Continue',
                radius: 30.r,
                width: 350.w,
              )

            ],
          ),
        ),
      ),

    );
  }
}
