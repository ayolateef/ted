import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tedfinance_mobile/core/Dashboard/dashboard.dart';
import 'package:tedfinance_mobile/core/auth/login/sign_in.dart';
import 'package:tedfinance_mobile/core/auth/onboarding/onboarding_screen.dart';
import '../../providers/auth_provider.dart';
import '../../shared/models/auth_models/user.dart';
import '../../shared/navigations/routes/navigation_service.dart';
import '../../shared/util/asset_images.dart';
import '../../shared/util/share_preference_util.dart';
import '../../shared/util/storage.dart';
import '../env/app_config.dart';
import '../env/utils/colors.dart';
import 'login/login_pin.dart';

class WhiteSplashScreen extends StatefulWidget {
  const WhiteSplashScreen({super.key});

  @override
  State<WhiteSplashScreen> createState() => _WhiteSplashScreenState();
}

class _WhiteSplashScreenState extends State<WhiteSplashScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _animationController;
   bool isFirstTime = true;
  late AuthenticationProvider authenticationProvider ;
  TextEditingController? username;
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.addObserver(this);
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
    authenticationProvider  = Provider.of<AuthenticationProvider>(
        context,
        listen: false);

  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      _saveLastActiveTime();
    } else if (state == AppLifecycleState.resumed) {
      _checkAppState();
    }
  }

  void _saveLastActiveTime() async {
    final prefs = await SharedPreferences.getInstance();
    final currentTime = DateTime.now().toIso8601String();
    await prefs.setString('lastActiveTime', currentTime);
  }

  void _checkAppState() async {
    final prefs = await SharedPreferences.getInstance();
    final lastActiveTimeStr = prefs.getString('lastActiveTime');
    if (lastActiveTimeStr != null) {
      final lastActiveTime = DateTime.parse(lastActiveTimeStr);
      final currentTime = DateTime.now();
      final duration = currentTime.difference(lastActiveTime);

      if (duration.inMinutes > 10) {
        _navigateToLoginPinScreen();
      } else {
        _navigateToDashboardScreen();
      }
    }
  }

  void _navigateToLoginPinScreen() {
    pushToWithRoute(context, CustomRoutes.slideIn( LoginPinScreen(username: username?.text ?? '',)));
  }

  void _navigateToDashboardScreen() {
    pushToWithRoute(context, CustomRoutes.slideIn(const DashboardScreen()));
  }

  void setIsNotFirstTime() async {
    await LocalStorageUtils.write(AppConstants.isUserFirstTime, false.toString());
  }
  // void _navigateToNextScreen(BuildContext
  // context) async {
  //   print("Navigating to next screen...");
  //   if (isFirstTime != null) {
  //     if (isFirstTime == true) {
  //       pushToWithRoute(context, CustomRoutes.slideIn(const OnBoardingScreen()));
  //       setIsNotFirstTime();
  //     }
  //     else {
  //       final lastLoginTime = await getLastLoginTime();
  //       if (lastLoginTime != null) {
  //         final currentTime = DateTime.now();
  //         final duration = currentTime.difference(lastLoginTime);
  //         if (duration.inMinutes > 10) {
  //           pushToWithRoute(context, CustomRoutes.slideIn(const LoginPinScreen()));
  //         }
  //         else {
  //           pushToWithRoute(context, CustomRoutes.slideIn(const DashboardScreen()));
  //         }
  //       }
  //
  //     }
  //   }
  //
  // }

  // void _navigateToNextScreen() async {
  //   if (isFirstTime == true) {
  //     pushToWithRoute(context, CustomRoutes.slideIn(const OnBoardingScreen()));
  //   }  else {
  //       User? user = authenticationProvider.user;
  //       if (authenticationProvider.isUserRegistered(user )){
  //         pushToWithRoute(context,  CustomRoutes.slideIn( const DashboardScreen()));
  //   }
  //       else{
  //         pushToWithRoute(context,  CustomRoutes.slideIn( const SignInScreen()));
  //       }
  //   }
  // }

  void _navigateToNextScreen() async {
    if (isFirstTime ) {
      pushToWithRoute(context, CustomRoutes.slideIn(const OnBoardingScreen()));

    }  else {
      User? user = authenticationProvider.user;
      if (authenticationProvider.isUserRegistered(user)){
        final token = await SharedPreferenceUtils.getToken();

        if (token != '') {
          _navigateToDashboardScreen();
          //pushToWithRoute(context, CustomRoutes.slideIn(const DashboardScreen()));
        } else {
          _navigateToLoginPinScreen();
          //pushToWithRoute(context, CustomRoutes.slideIn(const LoginPinScreen()));
        }
      }
      else{
        pushToWithRoute(context,  CustomRoutes.slideIn( const SignInScreen()));
      }

    }
  }


  Future<DateTime?> getLastLoginTime() async {
    final prefs = await SharedPreferences.getInstance();
    final lastLoginTimeStr = prefs.getString('lastLoginTime');
    return lastLoginTimeStr != null ? DateTime.parse(lastLoginTimeStr) : null;
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
      canPop: false,
      onPopInvoked: (value) => onBackPress(context, value),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: SvgPicture.asset(AssetResources.splashLogo2)),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<bool> isUserFirstTime() async {
    var firstTime = await LocalStorageUtils.read(AppConstants.isUserFirstTime);
    if (firstTime == null) {
      // If no value is stored, it's a first-time user
      return true;
    } else {
      // If a value is stored, it's not a first-time user
      return false;
    }
  }

  // Future<bool> isUserFirstTime() async {
  //   var firstTime = await LocalStorageUtils.read(AppConstants.isUserFirstTime);
  //   return firstTime == null ? true : firstTime == 'true';
  //  // return firstTime == null ? true : isFirstTime!;
  // }
}