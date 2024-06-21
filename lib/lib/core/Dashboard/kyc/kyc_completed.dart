import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tedfinance_mobile/core/Dashboard/dashboard.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';

import '../../../shared/navigations/routes/navigation_service.dart';
import '../../../shared/util/widgets/appbar.dart';
import '../../../theme/custom_text_style.dart';
import '../../env/utils/colors.dart';
import '../../env/utils/string_resources.dart';

class KYCCompleted extends StatefulWidget {
  const KYCCompleted({super.key});

  @override
  State<KYCCompleted> createState() => _KYCCompletedState();
}

class _KYCCompletedState extends State<KYCCompleted> {
  Future<bool?> onBackPress(context, bool value) {
    return showDialog <bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Do you wish to exit?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => {Navigator.pop(context, false)},
            ),
            TextButton(
                onPressed: () => {Navigator.pop(context, true)},
                child: Text('Exit'))
          ],
        )
    )  ;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (value) => onBackPress(context, value),
      canPop: false,
      child: Scaffold(
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TedTopWidget(
                      titleText: StringResources.kyc_completed,
                      rightIconOnTap: () {},
                    ),
                    20.verticalSpace,
                    20.verticalSpace,
                    SvgPicture.asset(AssetResources.completedIcon),
                    20.verticalSpace,
                    Text(StringResources.kyc_completed,
                      style: CustomTextStyles.titleLargeBlack.copyWith(
                        fontSize: 18.sp
                      )


                    ),

                    120.verticalSpace,
                    Text(StringResources.thanks_for_submitting,
                      textAlign: TextAlign.center,

                      style: CustomTextStyles.bodySmallBlack900,


                    ),
                    30.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: AppButton(
                        onPressed: (){
                          PageNavigator(ctx: context)
                              .nextPageOnly(page: const DashboardScreen());
                        },
                        radius: 30.r,
                        width: 290.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AssetResources.shortLeftArrow,
                              color: AppColors.white,
                              height: 15.h,
                              width: 15.w,

                            ),
                            10.horizontalSpace,
                            Text('Back to home', style: CustomTextStyles.titleMediumWhite16.copyWith(
                              fontSize:14.sp
                            ),)

                          ],
                        ),
                      ),
                    ),
                    180.verticalSpace,
                    40.verticalSpace,
                    Center(
                      child: Text(StringResources.if_you_re_facing_difficulties,
                          style: CustomTextStyles.bodySmallBlack900.copyWith(color: AppColors.tedLightBlack)
                      ),
                    ),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AssetResources.faceBookIcon,),
                        20.horizontalSpace,
                        SvgPicture.asset(AssetResources.twitterIcon),
                        20.horizontalSpace,
                        SvgPicture.asset(AssetResources.snapchatIcon),
                        20.horizontalSpace,
                        SvgPicture.asset(AssetResources.instagramIcon),
                        20.horizontalSpace,
                        SvgPicture.asset(AssetResources.linkedinIcon),
                        20.horizontalSpace,
                      ],)
                  ],
                ),
              )))),
    );
  }
}
