import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
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

import '../../../shared/util/share_preference_util.dart';
import '../../../shared/util/storage.dart';
import '../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../shared/util/widgets/custom_text_form_field.dart';
import '../../env/app_config.dart';
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
  final TextEditingController _emailController = TextEditingController(text: "eobilo@yopmail.com");
  final TextEditingController _passwordController = TextEditingController(text: "Ayodele2");
  bool _passwordVisible = false;
  bool _isLoading = false;


  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics = false;
  bool _isAuthenticating = false;
  String _authorized = 'Not Authorized';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final gradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFE071DF), Color(0xFF02E4F0)],
  );

  late User user;
  late AuthenticationProvider authenticationProvider ;

  @override
  void initState() {
    LocalStorageUtils.write(AppConstants.isUserFirstTime, "true");
    _checkBiometrics();
    super.initState();
  }
  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } catch (e) {
      canCheckBiometrics = false;
    }
    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<bool?> onBackPress(context, bool value) {
    return showDialog <bool>(
        context: context,
        builder: (context) =>
            AlertDialog(
          // title: Text('Do you wish to exit?'),
          // actions: <Widget>[
          //   TextButton(
          //     child: Text('Cancel'),
          //     onPressed: () => {Navigator.pop(context, false)},
          //   ),
          //   TextButton(
          //       onPressed: () => {Navigator.pop(context, true)},
          //       child: Text('Exit'))
          // ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    authenticationProvider  = Provider.of<AuthenticationProvider>(
        context,
        listen: false);
    return PopScope(
      canPop: false,
      onPopInvoked: (value) => onBackPress(context, value),
      child: Scaffold(
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
                                textInputType: TextInputType.emailAddress,
                                autofocus: false,
                                // textInputFormatters: [
                                //   FilteringTextInputFormatter(
                                //     RegExp(
                                //       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                                //     ),
                                //     allow: true,
                                //   ),
                                // ],
      
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Please enter an email address';
                                //   } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                                //     return 'Please enter a valid email address';
                                //   }
                                //   return null;
                                // },
                                textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp),
                              ),
                              SizedBox(height: 26.0.h),
                              CustomTextFormField(
                                hintText: 'Password',
                                autofocus: false,
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
                                              const ForgotPassword(email: ''
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
                                  child: InkWell(
                                    onTap: _canCheckBiometrics ? _authenticate : null,
                                    child: SvgPicture.asset(
                                        AssetResources.fingerPrintIcon),
                                  )),
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
                      if (_isLoading)
                        Visibility(
                          visible: _isLoading,
                          child: Positioned.fill(
                            child: Container(
                              color: Colors.white.withOpacity(0.5),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  signIn() async {
    if ( _formKey.currentState!.validate())  {
      try {
        setState(() {
          _isLoading = true;
        });
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
      finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> trackOnboardingProgress(User? user) async {

    if (user != null) {
      if (user.onboardingComplete! ) {
        pushToWithRoute(context, CustomRoutes.fadeIn( const DashboardScreen()));
      }
      else if ( user.onboardingStep == OnBoardingSteps.createPin ){
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

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          useErrorDialogs: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = authenticated ? 'Authorized' : 'Not Authorized';
      });
    } catch (e) {
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - $e';
      });
      return;
    }
    if (!mounted) return;

    if (authenticated) {
      // Call updateToken here
      String token = await  SharedPreferenceUtils.getToken();
      try {
        String updatedToken = await authenticationProvider.updateToken(token);
        print("FCM Token updated successfully: $updatedToken");
      } catch (e) {
        print("Failed to update FCM token: $e");
      }
    }
  }


}
