import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tedfinance_mobile/core/Dashboard/dashboard.dart';
import 'package:tedfinance_mobile/core/auth/signup/create_pin.dart';
import 'package:tedfinance_mobile/core/auth/signup/create_username.dart';
import 'package:tedfinance_mobile/core/auth/signup/sign_up.dart';
import 'package:tedfinance_mobile/core/auth/onboarding/onboarding_screen.dart';
import '../../shared/navigations/routes/navigation_service.dart';
import '../../shared/util/asset_images.dart';
import '../../shared/util/storage.dart';
import '../env/app_config.dart';
import '../env/utils/colors.dart';
import 'auth_state.dart';
import 'login/login_pin.dart';

class WhiteSplashScreen extends StatefulWidget {
  const WhiteSplashScreen({super.key});

  @override
  State<WhiteSplashScreen> createState() => _WhiteSplashScreenState();
}

class _WhiteSplashScreenState extends State<WhiteSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late bool isFirstTime;

  @override
  void initState() {
    super.initState();

    isUserFirstTime().then((value) {
      setState(() {
        isFirstTime = value;
      });
    }).catchError((error) {
      print('Error occurred while checking isFirstTime: $error');
    });

    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 4));
    _animationController.forward();

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToNextScreen();
      }
    });


  }

  void _navigateToNextScreen() async {
    final progress = await AuthState().getOnboardingProgress();
    if (isFirstTime == true) {
      // Show onboarding screen
      pushToWithRoute(context, CustomRoutes.slideIn(const OnBoardingScreen()));
    }  else {
      pushToAndClearStack(context, const DashboardScreen());

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: SvgPicture.asset(AssetResources.splashLogo2)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<bool> isUserFirstTime() async {
    var firstTime = await LocalStorageUtils.read(AppConstants.isUserFirstTime);
    return firstTime == null;
  }
}