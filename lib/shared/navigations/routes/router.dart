import 'package:flutter/material.dart';
import 'package:tedfinance_mobile/core/Dashboard/kyc/bvn.dart';
import 'package:tedfinance_mobile/core/Dashboard/dashboard.dart';
import 'package:tedfinance_mobile/core/Dashboard/kyc/nin.dart';
import 'package:tedfinance_mobile/core/Dashboard/kyc/selfie.dart';
import 'package:tedfinance_mobile/core/Dashboard/routes.dart';
import 'package:tedfinance_mobile/core/auth/signup/create_pin.dart';
import 'package:tedfinance_mobile/core/auth/signup/create_username.dart';

import '../../../core/Dashboard/card1/cards/activate_card.dart';
import '../../../core/Dashboard/kyc/kyc-progress.dart';
import '../../../core/Dashboard/kyc/kyc_identity.dart';
import '../../../core/Dashboard/kyc/upload_files.dart';
import '../../../core/auth/forgotPassword/forgot_password.dart';
import '../../../core/auth/login/login_pin.dart';
import '../../../core/auth/login/sign_in.dart';
import '../../../core/auth/signup/sign_up.dart';
import '../../../core/auth/onboarding/onboarding_screen.dart';
import '../../../core/auth/routes.dart';
import '../../../core/auth/splash_screen.dart';
import '../animations/fade_route.dart';

Route<dynamic>? routes(RouteSettings settings) {
  switch (settings.name) {
    case AuthRoutes.initial:
      return FadeRoute(
        page:  SplashScreen(),
      );
    case AuthRoutes.onBoardingPage:
      return FadeRoute(
        page: const OnBoardingScreen(),
      );
    case AuthRoutes.signIn:
      return FadeRoute(
        page: const SignInScreen(),
      );
    case AuthRoutes.createPin :
      return FadeRoute(
        page: const CreatePinScreen(),
      );
    case AuthRoutes.createUsername :
      return FadeRoute(
        page: const CreateUsername(),
      );
  case AuthRoutes.forgotPassword:
  return FadeRoute(
  page: const ForgotPassword(email: '',)
  );
    case AuthRoutes.signUp:
      return FadeRoute(
        page: const SignUpScreen(),
      );
    case AuthRoutes.loginIn:
      return FadeRoute(
        page: const LoginPinScreen(username: '',),
      );
    case DashboardRoutes.kycVerification:
      return FadeRoute(
        page: const KYCIdentity(),
      );
    case DashboardRoutes.dashBoard:
      return FadeRoute(
        page: const DashboardScreen(),
      );
    case DashboardRoutes.uploadFiles:
      return FadeRoute(
        page: const UploadFiles(),
      );
    case DashboardRoutes.selfieSamples:
      return FadeRoute(
        page: const SelfieScreen(),
      );
    case DashboardRoutes.bvnVerify:
      return FadeRoute(
        page: const BVNPage(),
      );
    case DashboardRoutes.nin:
      return FadeRoute(
        page: const NINPage(),
      );
    case DashboardRoutes.kycProgress:
      return FadeRoute(
        page:  const KYCProgress(),
      );
    case DashboardRoutes.activateCard:
      return FadeRoute(
        page:  const ActivateCard(),
      );
    default:
      return null;
  }
}