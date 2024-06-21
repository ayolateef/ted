import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tedfinance_mobile/core/Dashboard/dashboard.dart';

import '../../../../../shared/navigations/routes/navigation_service.dart';
import '../../../../../shared/util/asset_images.dart';
import '../../../../../shared/util/widgets/custom_containers.dart';
import '../../../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../../../theme/custom_text_style.dart';
import '../../../../env/utils/colors.dart';
import '../../../../env/utils/string_resources.dart';
import '../../../card1/cards/virtual_cards.dart';
import '../../pay_bills/cable_tv.dart';
import '../../../card1/transfer/bank_account_details.dart';

class UtilitiesSheet extends StatelessWidget {
  const UtilitiesSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      height: MediaQuery.of(context).size.height / 2.3,
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(AssetResources.shortLeftArrow),
             150.horizontalSpace,
              Text(StringResources.utilities,
                  style: CustomTextStyles.titleLargeBlack),
            ],
          ),
          20.verticalSpace,
          PaymentContainer(
            onTap: () {
              Navigator.pop(context);
              PageNavigator(ctx: context)
                  .nextPage(page: const BankAccountDetails());
            },
            imagePath: AssetResources.addPayIcon,
            titleText: StringResources.electricity,
            subTitleText: StringResources.pay_for_electricity,
            icon: Icons.arrow_forward_ios,
            isSvg: true,
          ),
          30.verticalSpace,
          PaymentContainer(
            onTap: () {
              Navigator.pop(context);
              PageNavigator(ctx: context)
                  .nextPage(page: const  CableTv());
            },
            imagePath: AssetResources.downloadIcon,
            titleText: StringResources.cable_tv,
            subTitleText: StringResources.pay_for_your_cable_TV,
            icon: Icons.arrow_forward_ios,
            isSvg: true,
          ),
        ],
      ),
    );
  }
}




class AirtimeDataSheet extends StatelessWidget {
  const AirtimeDataSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      height: MediaQuery.of(context).size.height / 2.3,
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(AssetResources.shortLeftArrow),
              130.horizontalSpace,
              Text(StringResources.airtime_data,
                  style: CustomTextStyles.titleLargeBlack),
            ],
          ),
          20.verticalSpace,
          PaymentContainer(
            onTap: () {
              Navigator.pop(context);
              PageNavigator(ctx: context)
                  .nextPage(page: const BankAccountDetails());
            },
            imagePath: AssetResources.addPayIcon,
            titleText: StringResources.buy_airtime_data,
            subTitleText: StringResources.buy_airtime_for_aall_network,
            icon: Icons.arrow_forward_ios,
            isSvg: true,
          ),
          30.verticalSpace,
          PaymentContainer(
            onTap: () {},
            imagePath: AssetResources.downloadIcon,
            titleText: StringResources.buy_data,
            subTitleText: StringResources.buy_data_for_all_network,
            icon: Icons.arrow_forward_ios,
            isSvg: true,
          ),
        ],
      ),
    );
  }
}


class CablePaymentSuccessSheet extends StatelessWidget {
  const CablePaymentSuccessSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xffDA5ED8),
        const Color(0xffB854B7),
        AppColors.black
      ],
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 35.h),
      child: ClipPath(
        clipper: MyTopClipper(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.4,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(AssetResources.paymentCableImage),
                20.verticalSpace,
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.tedGradientColor,
                      fontSize: 25.sp,
                    ),
                    children:   [
                      const TextSpan(
                        text: 'Your Cable payment was',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.tedGradientColor,
                        ),
                      ),
                      TextSpan(
                        text: 'successful',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          foreground: Paint()
                            ..shader = gradient.createShader(
                                Rect.fromLTRB(0, 0, 1000, 24)
                            ),
                        ),

                      )
                    ],
                  ),
                ),
                20.verticalSpace,
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.tedGradientColor,
                      fontSize: 15.sp,
                    ),
                    children:  const [
                      TextSpan(
                        text: 'Your payment for of 3,500',
                      ),
                      TextSpan(
                        text: 'GOTV JOLLI',
                        style: TextStyle(
                          color: AppColors.tedGradientColor,
                        ),
                      ),
                      TextSpan(
                        text: 'of',
                      ),
                      TextSpan(
                        text: '3,500',
                        style: TextStyle(
                          color: AppColors.tedGradientColor,
                        ),
                      ),
                      TextSpan(
                        text: 'to',
                      ),
                    TextSpan(
                      text: '1234567891011',
                      style: TextStyle(
                        color: AppColors.tedGradientColor,
                      ),
                    ),
                    TextSpan(
                      text: 'was successful',
                    ),
                    ],
                  ),
                ),
                50.verticalSpace,
                AppButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    PageNavigator(ctx: context)
                        .nextPage(page: const DashboardScreen());
                  },
                  text: 'Done',
                  radius: 30.r,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class DataPurchaseSuccessSheet extends StatelessWidget {
  const DataPurchaseSuccessSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xffDA5ED8),
        const Color(0xffB854B7),
        AppColors.black
      ],
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 35.h),
      child: ClipPath(
        clipper: MyTopClipper(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.4,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(AssetResources.paymentCableImage),
                20.verticalSpace,
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return gradient.createShader(bounds);
                  },
                  blendMode: BlendMode.srcIn,
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.tedGradientColor,
                        fontSize: 25.sp,
                      ),
                      children:   [
                        const TextSpan(
                          text: 'Your Data purchase was',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.tedGradientColor,
                          ),
                        ),
                        TextSpan(
                          text: 'successful',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            foreground: Paint()
                              ..shader = gradient.createShader(
                                  Rect.fromLTRB(0, 0, 1000, 24)
                              ),
                          ),

                        )
                      ],
                    ),
                  ),
                ),
                20.verticalSpace,
                Text.rich(
                textAlign: TextAlign.center,
                  TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.tedGradientColor,
                      fontSize: 15.sp,
                    ),
                    children:  const [
                      TextSpan(
                        text: ' Your purchase of',
                      ),
                      TextSpan(
                        text: 'MTN-NG Data',
                        style: TextStyle(
                          color: AppColors.tedGradientColor,
                        ),
                      ),
                      TextSpan(
                        text: 'of',
                      ),
                      TextSpan(
                        text: '100mb',
                        style: TextStyle(
                          color: AppColors.tedGradientColor,
                        ),
                      ),
                      TextSpan(
                        text: 'for 1 day to',
                      ),
                      TextSpan(
                        text: '1234567891011',
                        style: TextStyle(
                          color: AppColors.tedGradientColor,
                        ),
                      ),
                      TextSpan(
                        text: 'was successful',
                      ),
                    ],
                  ),
                ),
                50.verticalSpace,
                AppButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    PageNavigator(ctx: context)
                        .nextPage(page: const DashboardScreen());
                  },
                  text: 'Done',
                  radius: 30.r,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class AirtimePurchaseSuccessSheet extends StatelessWidget {
  const AirtimePurchaseSuccessSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xffDA5ED8),
        const Color(0xffB854B7),
        AppColors.black
      ],
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 35.h),
      child: ClipPath(
        clipper: MyTopClipper(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.4,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(AssetResources.paymentCableImage),
                20.verticalSpace,
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return gradient.createShader(bounds);
                  },
                  blendMode: BlendMode.srcIn,
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.tedGradientColor,
                        fontSize: 25.sp,
                      ),
                      children:   [
                        const TextSpan(
                          text: 'Your Recharge was',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.tedGradientColor,
                          ),
                        ),
                        TextSpan(
                          text: 'successful',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                              foreground: Paint()
                                ..shader = gradient.createShader(
                                    Rect.fromLTRB(0, 0, 1000, 24)
                          ),
                          ),

                        )
                      ],
                    ),
                  ),
                ),
                20.verticalSpace,
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.tedGradientColor,
                      fontSize: 15.sp,
                    ),
                    children:  const [
                      TextSpan(
                        text: ' Your purchase of',
                      ),
                      TextSpan(
                        text: 'MTN-NG Data',
                        style: TextStyle(
                          color: AppColors.tedGradientColor,
                        ),
                      ),
                      TextSpan(
                        text: 'of',
                      ),
                      TextSpan(
                        text: '100mb',
                        style: TextStyle(
                          color: AppColors.tedGradientColor,
                        ),
                      ),
                      TextSpan(
                        text: 'for 1 day to',
                      ),
                      TextSpan(
                        text: '1234567891011',
                        style: TextStyle(
                          color: AppColors.tedGradientColor,
                        ),
                      ),
                      TextSpan(
                        text: 'was successful',
                      ),
                    ],
                  ),
                ),
                50.verticalSpace,
                AppButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    PageNavigator(ctx: context)
                        .nextPage(page: const DashboardScreen());
                  },
                  text: 'Done',
                  radius: 30.r,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}