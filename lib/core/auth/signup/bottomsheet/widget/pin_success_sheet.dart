import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tedfinance_mobile/core/Dashboard/dashboard.dart';
import 'package:tedfinance_mobile/core/auth/signup/create_username.dart';
import 'package:tedfinance_mobile/core/env/utils/string_resources.dart';

import '../../../../../shared/navigations/routes/navigation_service.dart';
import '../../../../../shared/util/asset_images.dart';
import '../../../../../shared/util/widgets/custom_containers.dart';
import '../../../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../../env/utils/colors.dart';

class PinSuccessSheet extends StatefulWidget {
  const PinSuccessSheet({super.key});

  @override
  State<PinSuccessSheet> createState() => _PinSuccessSheetState();
}

class _PinSuccessSheetState extends State<PinSuccessSheet> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 35.h),
      child: ClipPath(
        clipper: MyTopClipper(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 480,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SvgPicture.asset(AssetResources.successIcon,),
                20.verticalSpace,
            Text(
              StringResources.successful,
              style:GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.tedGradientColor),
              ),
            ),
                20.verticalSpace,
                Text(
                  StringResources.this_action,
                  style:GoogleFonts.poppins(
                    textStyle:  TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.tedGrey,
                      fontSize: 15.sp
                    ),
                  ),
                ),
                50.verticalSpace,
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
                      Navigator.of(context).pop();
                      PageNavigator(ctx: context)
                          .nextPage(page: const CreateUsername());
                    },
                    text: 'Proceed to Username',
                    color: isHovered
                        ? AppColors.primaryColor
                        : AppColors.tedButtonGrey,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class WelcomeSheet extends StatefulWidget {
  const WelcomeSheet({super.key});

  @override
  State<WelcomeSheet> createState() => _WelcomeSheetState();
}

class _WelcomeSheetState extends State<WelcomeSheet> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
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
                SvgPicture.asset( AssetResources.welcomeImage,),
                20.verticalSpace,
                Text(
                  StringResources.welcome_to_ted_finance ,
                  style:GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.tedGradientColor),
                  ),
                ),
                20.verticalSpace,
                Text(
                  StringResources.global_access,
                  style:GoogleFonts.poppins(
                    textStyle:  TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.tedGrey,
                        fontSize: 15.sp
                    ),
                  ),
                ),
                50.verticalSpace,
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
                      Navigator.of(context).pop();
                      PageNavigator(ctx: context)
                          .nextPage(page: const DashboardScreen());
                    },
                    text: 'Dashboard',
                    color: isHovered
                        ? AppColors.primaryColor
                        : AppColors.tedButtonGrey,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}