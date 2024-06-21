import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tedfinance_mobile/core/Dashboard/dashboard.dart';
import 'package:tedfinance_mobile/core/auth/forgotPassword/forgot_password.dart';
import 'package:tedfinance_mobile/core/auth/signup/create_username.dart';
import 'package:tedfinance_mobile/core/env/utils/string_resources.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/theme/custom_text_style.dart';

import '../../../providers/auth_provider.dart';
import '../../../shared/models/auth_models/user.dart';
import '../../../shared/navigations/routes/navigation_service.dart';

import '../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../shared/util/widgets/custom_text_form_field.dart';
import '../../env/utils/alert_toast.dart';
import '../../env/utils/colors.dart';
import '../signup/create_pin.dart';
import '../signup/sign_up.dart';
import '../signup/verify_sign_up.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final gradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFE071DF), Color(0xFF02E4F0)],
  );

  late User user;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 60),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32.0),
                          topRight: Radius.circular(32.0),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 25.0.w, vertical: 28.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            10.verticalSpace,
                            ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return gradient.createShader(bounds);
                              },
                              blendMode: BlendMode.srcIn,
                              child: Text(
                                'Welcome Back',
                                style: TextStyle(
                                  color: Colors
                                      .black, // Text color to be masked with gradient
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              StringResources.hello_signIn_continue,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.tedBlackText)),
                            ),
                            15.verticalSpace,
                            Center(
                                child: SvgPicture.asset(
                                    AssetResources.signInIcon)),
                            const SizedBox(height: 24.0),
                            const SizedBox(height: 16.0),
                            CustomTextFormField(
                              hintText: 'Email Address',
                              controller: _emailController,
                            ),
                            SizedBox(height: 26.0.h),
                            CustomTextFormField(
                              hintText: 'Password',
                              controller: _passwordController,
                              obscureText: !_passwordVisible,
                              suffix: IconButton(
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 46.0.h),
                            Row(
                              children: [
                                const Spacer(),
                                TextButton(
                                    onPressed: () {
                                      // if (_emailController.text.isNotEmpty) {
                                        pushToWithRoute(
                                          context,
                                          CustomRoutes.fadeIn(
                                            ForgotPassword(email: ''
                                                //emailController.text
                                            ),
                                          ),
                                        );
                                     // }
                                     //  else {
                                     //    // Handle the case where the email is empty or null
                                     //  }
                                  },
                                  child: Text('Forgot your password ?',
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 13.sp,
                                              color: AppColors.tedGreyText,
                                              fontWeight: FontWeight.w500))),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24.0),
                            Center(
                              child: AppButton(
                                onPressed: () async {
                                 signIn();
                                },
                                text: StringResources.Sign_In,
                                radius: 18.r,
                                textStyle: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600),
                                //width: 320.w,
                              ),
                            ),
                            35.verticalSpace,
                            Center(
                                child: SvgPicture.asset(
                                    AssetResources.fingerPrintIcon)),
                            SizedBox(height: 14.0.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an account? ",
                                    style: CustomTextStyles.bodySmallBlack900),
                                TextButton(
                                  onPressed: () {
                                    pushToWithRoute(
                                        context,
                                        CustomRoutes.fadeIn(
                                            const SignUpScreen()));
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: AppColors.tedTextBlue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  signIn() async {
    if ( _formKey.currentState!.validate())  {
      try {
        AuthenticationProvider authenticationProvider =
        Provider.of<AuthenticationProvider>(
            context,
            listen: false);

        if (await authenticationProvider.login(
            _emailController.text,
            _passwordController.text)) {
          User? userData = await authenticationProvider.fetchUser();

          if (userData != null) {
            await trackOnboardingProgress(userData);
                    } else {
            AlertToast(context: context).showError(
                'Failed to fetch user data');
          }
        } else {
          AlertToast(context: context).showError(
              authenticationProvider.errorMessage);
        }
      } catch (e) {
        AlertToast(context: context).showError(e.toString());
      }
    }
  }

  Future<void> trackOnboardingProgress(User? user) async {

    if (user != null) {
      if (user.onboardingComplete! ) {
      pushToWithRoute(context, CustomRoutes.fadeIn(const DashboardScreen()));
      }
      else if (  user.onboardingStep == OnBoardingSteps.createPin ){
        pushToWithRoute(context, CustomRoutes.fadeIn(
            const CreatePinScreen())
        );

      }
      else if(user.onboardingStep == OnBoardingSteps.username){

      pushToWithRoute(context, CustomRoutes.fadeIn(
      const CreateUsername())
    );
      }
    }
  }
}
