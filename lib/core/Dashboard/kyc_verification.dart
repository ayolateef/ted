import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tedfinance_mobile/core/Dashboard/bvn.dart';
import 'package:tedfinance_mobile/core/Dashboard/personal_bio.dart';
import 'package:tedfinance_mobile/shared/navigations/routes/navigation_service.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';
import '../../shared/util/widgets/appbar.dart';
import '../../shared/util/widgets/custom_stepper.dart';
import '../env/utils/colors.dart';
import '../env/utils/string_resources.dart';

class KYCVerification extends StatefulWidget {
  const KYCVerification({super.key});

  @override
  State<KYCVerification> createState() => _KYCVerificationState();
}

class _KYCVerificationState extends State<KYCVerification> {
  bool showStepperContent = false;
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
        child: Column(
          children: [
            TedTopWidget(
              titleText: StringResources.KYC_KYB_VERIFICATION,
              rightIconOnTap: () {
                // PageNavigator(ctx: context).nextPageOnly(
                //     page: const KYCVerification());
              },
            ),
            10.verticalSpace,
            Text(
              StringResources.verify_your_profile,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            20.verticalSpace,
            StepperContainer(
              svgIcon: AssetResources.bioIcon,
              rowText: StringResources.personal_bio,
              boxDecoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: 8.0,
              currentStep: 1,
              totalSteps: 3,
              longText: '',
            ),
            // 20.verticalSpace,
            // const StepperContainer(
            //   svgIcon: AssetResources.frame2,
            //   rowText: StringResources.additional_info,
            //   longText: StringResources.additional_info_message,
            //   currentStep: 2,
            //   totalSteps: 4,
            // ),
            20.verticalSpace,
            const StepperContainer(
              svgIcon: AssetResources.frame3,
              rowText: StringResources.uploaads,
              longText: StringResources.uploaads_id,
              currentStep: 2,
              totalSteps: 3,
            ),
            20.verticalSpace,
            const StepperContainer(
              svgIcon: AssetResources.frame4,
              rowText: StringResources.selfie,
              longText: StringResources.take_a_selfie,
              currentStep: 3,
              totalSteps: 3,
            ),
            20.verticalSpace,
            const BigPinkContainer(
              text: StringResources.Additional_info_required,
            ),
            40.verticalSpace,
            MouseRegion(
              onHover: (event) {
                setState(() {
                  isHovered = true;
                });
              },
              onExit: (event) {
                setState(() {
                  isHovered = false;
                });
              },
              child: AppButton(
                onPressed: () {
                  setState(() {
                    showStepperContent = true;
                  });
                  pushToWithRoute(context, CustomRoutes.fadeIn(const BVNPage()
                  ) );
                  // PageNavigator(ctx: context)
                  //     .nextPageOnly(page: const PersonalBio());
                },
                text: 'I am ready',
                color: isHovered ? AppColors.primaryColor : AppColors.tedButtonGrey,
                hoverColor: AppColors.primaryColor,
                radius: 20.r,
                height: 52,
              ),
            ),
            20.verticalSpace
          ],
        ),
      ),
    ));
  }
}

class BigPinkContainer extends StatelessWidget {
  final String? text;
  final double? height;
  final Color? containerColor;
  final Widget? containerWidget;
  const BigPinkContainer({
    super.key, this.text, this.height, this.containerColor, this.containerWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ??  100.h,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.r),
          color: containerColor ?? AppColors.tedLightPink),
      child: Row(
        children: [
          SvgPicture.asset(AssetResources.blackWhyIcon),
          10.horizontalSpace,
          containerWidget ?? Text(
            text ?? '',
            style: GoogleFonts.poppins(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.tedDeepPurple),
          )
        ],
      ),
    );
  }
}
