import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tedfinance_mobile/core/auth/signup/sign_up.dart';
import 'package:tedfinance_mobile/core/env/utils/colors.dart';
import 'package:tedfinance_mobile/core/env/utils/string_resources.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import '../../../shared/navigations/routes/navigation_service.dart';
import '../../../shared/util/widgets/custom_elevated_button.dart';

class OnBoardingScreen extends StatefulWidget {
  final int initialStep;
  const OnBoardingScreen({super.key, this.initialStep = 0});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool _isHovering = false;
  void _onHover(bool isHovering) {
    setState(() {
      _isHovering = isHovering;
    });
  }
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
    return  PopScope(
      onPopInvoked: (value) => onBackPress(context, value),
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: PopScope(
          onPopInvoked: (canPop) async => false,
          child: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: -50,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    AssetResources.onBoardingImage,
                    fit: BoxFit.cover,

                  ),
                ),
                Positioned(
                  bottom: -260,
                  left: 0,
                  right: 0,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 500),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Text(
                            StringResources.LET_GET_STARTED,
                            style: GoogleFonts.poppins(
                              color: AppColors.white,
                              fontSize: 35.0.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            StringResources.NEVER_A_BETTER,
                            textAlign: TextAlign.start,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: AppColors.white,
                                fontSize: 17.sp,
                              ),
                            )


                          ),
                        ),
                        SizedBox(height: 16.0.h),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.circle, color: Colors.white.withOpacity(0.3), size: 15.0),
                            SizedBox(width: 4.0),
                            Icon(Icons.circle, color: Colors.white.withOpacity(0.5), size: 15.0),
                            SizedBox(width: 4.0),
                            Icon(Icons.circle, color: Colors.white, size: 15.0),
                          ],
                        ),
                        SizedBox(height: 35.0.h),
                        Center(
                          child: MouseRegion(
                            onEnter: (_) => _onHover(true),
                            onExit: (_) => _onHover(false),
                            child: AppButton(
                              onPressed: () {
                               pushToWithRoute(context, CustomRoutes.fadeIn(const SignUpScreen()));
                              },
                              radius: 30.r,
                              width: 270.w,
                              color: _isHovering ? AppColors.primaryColor : AppColors.white,
                              borderColor: _isHovering ? AppColors.white : AppColors.primaryColor,
                              buttonType: ButtonType.primary,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Get Started',
                                    style: TextStyle(
                                      color: _isHovering ? AppColors.white : AppColors.primaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                  8.horizontalSpace,
                                  SvgPicture.asset(AssetResources.longRightArrow),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32.0),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}


