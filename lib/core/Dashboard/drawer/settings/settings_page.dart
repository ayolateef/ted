import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tedfinance_mobile/core/Dashboard/drawer/settings/payment/add_payment.dart';
import 'package:tedfinance_mobile/shared/navigations/routes/navigation_service.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/theme/custom_text_style.dart';
import '../../../../shared/util/widgets/appbar.dart';
import '../../../../shared/util/widgets/switch_icon.dart';
import '../../../env/utils/colors.dart';
import '../../../env/utils/string_resources.dart';
import 'account_tier/account_tier.dart';
import 'my_account/my_account.dart';

class SettingsProfilePage extends StatefulWidget {
  const SettingsProfilePage({super.key});

  @override
  State<SettingsProfilePage> createState() => _SettingsProfilePageState();
}

class _SettingsProfilePageState extends State<SettingsProfilePage> {
  bool isSwitchMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TedAppBar(
          elevation: 0,
          titleText: StringResources.settings_profile,
          trailing: SizedBox(),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Positioned(
                    right: -MediaQuery.of(context).size.width / 4,
                    top: -5,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 4,
                      width: MediaQuery.of(context).size.width / 2.8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryButtonColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Material(
                      elevation: 3, // Set the elevation here
                      borderRadius: BorderRadius.circular(15.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 18.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: AppColors.primaryColor,
                        ),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                SvgPicture.asset(
                                  AssetResources.officialImageIcon,
                                  height: 75.h,
                                ),
                                Positioned(
                                  bottom: 15,
                                  right: 0,
                                  child: Transform.translate(
                                    offset: const Offset(
                                        10, 10), // Adjust the offset as needed
                                    child: SvgPicture.asset(
                                      AssetResources.userVerifyIcon,
                                      height: 30.h,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            20.horizontalSpace,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tedfinance Lateef',
                                    style:
                                        CustomTextStyles.titleMediumffffffff),
                                5.verticalSpace,
                                Text('@lateef',
                                    style: CustomTextStyles.bodySmallGray5004
                                        .copyWith(
                                            fontSize: 13.0,
                                            color: AppColors.tedGreyText)),
                                5.verticalSpace,
                                Text('Account No: 2001400245',
                                    style: CustomTextStyles.titleSmallffffffff
                                        .copyWith(
                                      fontSize: 13.0.sp,
                                    ))
                              ],
                            ),
                            const Spacer(),
                            SvgPicture.asset(AssetResources.editIcon)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              20.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(10.r),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 21.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: AppColors.white2,
                    ),
                    child: Column(
                      children: [
                        ProfileWidget(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AccountPage()));
                          },
                          titleText: StringResources.my_account,
                          subtitleText: StringResources.make_changes,
                          additionIcon: AssetResources.userVerifyIcon,
                        ),
                        ProfileWidget(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AddPayment()));
                          },
                          titleText: StringResources.payment_method,
                          subtitleText: StringResources.add_payment,
                        ),
                        ProfileWidget(
                          onTap: () {
                            PageNavigator(ctx: context)
                                .nextPage(page: const AccountTier());
                          },
                          svgIcon: AssetResources.accountTierIcon,
                          titleText: StringResources.account_tiers,
                          subtitleText: StringResources.change_tier_to,
                        ),
                        ModeSwitchTile(
                          isRideMode: isSwitchMode,
                          onToggle: (value) {
                            isSwitchMode = value;
                            log("tohhlfifif");
                            setState(() {});
                          },
                        ),
                        // ProfileWidget(
                        //   onTap: (){
                        //
                        //   },
                        //   svgIcon: AssetResources.faceIdIcon,
                        //   titleText: StringResources.face_id,
                        //   subtitleText: StringResources.manage_device_security,
                        // ),
                        ProfileWidget(
                          onTap: () {},
                          svgIcon: AssetResources.twoAuthIcon,
                          titleText: StringResources.two_factor_auth,
                          subtitleText: StringResources.further_secure,
                        ),
                        ProfileWidget(
                          onTap: () {},
                          svgIcon: AssetResources.logoutIcon,
                          smallCircleColor: AppColors.tedLightGrey,
                          titleText: StringResources.log_out,
                          subtitleText: StringResources.further_secure,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              10.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(StringResources.more,
                    style: CustomTextStyles.titleMedium18),
              ),
              30.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 21.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: AppColors.white2,
                  ),
                  child: Column(
                    children: [
                      ProfileWidget(
                        onTap: () {},
                        svgIcon: AssetResources.blueNotificationIcon,
                        titleText: StringResources.help_support,
                      ),
                      ProfileWidget(
                        onTap: () {},
                        svgIcon: AssetResources.aboutIcon,
                        titleText: StringResources.about_app,
                        margin: 0.0,
                      ),
                    ],
                  ),
                ),
              ),
              20.verticalSpace
            ],
          ),
        ));
  }
}

class ProfileWidget extends StatelessWidget {
  final String? svgIcon;
  final String? titleText;
  final String? subtitleText;
  final String? trailingIcon;
  final String? additionIcon;
  final Color? smallCircleColor;
  final double? margin;
  final Function()? onTap;

  const ProfileWidget(
      {super.key,
      this.svgIcon,
      this.titleText,
      this.subtitleText,
      this.trailingIcon,
      this.additionIcon,
      this.smallCircleColor,
      this.margin,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: margin ?? 30.h),
        child: Row(
          children: [
            Container(
              height: 60.h,
              width: 60.w,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: smallCircleColor ?? AppColors.tedVeryLightPurple,
                  shape: BoxShape.circle),
              child: SvgPicture.asset(svgIcon ?? AssetResources.myAccountIcon),
            ),
            10.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titleText ?? StringResources.my_account,
                    style: CustomTextStyles.titleMedium18),
                5.verticalSpace,
                Text(subtitleText ?? '',
                    style: CustomTextStyles.titleMediumGray90002.copyWith(
                        fontSize: 13.sp, color: AppColors.tedGreyText))
              ],
            ),
            30.horizontalSpace,
            SvgPicture.asset(additionIcon ?? ''),
            const Spacer(),
            SvgPicture.asset(
              trailingIcon ?? AssetResources.shortRightArrow,
              height: 20.h,
              width: 20.w,
              color: AppColors.tedGreyShortArrow,
            )
          ],
        ),
      ),
    );
  }
}
