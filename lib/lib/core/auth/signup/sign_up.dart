import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tedfinance_mobile/core/auth/login/sign_in.dart';
import 'package:tedfinance_mobile/core/auth/signup/verify_sign_up.dart';
import 'package:tedfinance_mobile/core/enums/view_state.dart';
import 'package:tedfinance_mobile/core/env/utils/alert_toast.dart';
import 'package:tedfinance_mobile/core/env/utils/string_resources.dart';
import 'package:tedfinance_mobile/providers/auth_provider.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';

import '../../../shared/navigations/routes/navigation_service.dart';
import '../../../shared/util/widgets/custom_checkbox_button.dart';
import '../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../shared/util/widgets/custom_text_form_field.dart';
import '../../../theme/custom_text_style.dart';
import '../../env/utils/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _passwordVisible = false;
  bool _isChecked = false;
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  onSignup() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      if (!_isChecked) {
        AlertToast(context: context).showError('Please agree to the terms and conditions');
        return;
      }
      setState(() {
        _isLoading = true;
      });
      try {
        AuthenticationProvider authenticationProvider =
            Provider.of<AuthenticationProvider>(context, listen: false);

        if (await authenticationProvider.signup(email: emailController.text)) {

          pushToWithRoute(context, CustomRoutes.fadeIn(
              VerifySignUpScreen(
                email: emailController.text,
                password: passwordController.text,
                name: nameController.text,
              ))
          );

        } else {
          AlertToast(context: context)
              .showError(authenticationProvider.errorMessage);
        }
      } catch (e) {
        AlertToast(context: context).showError(e.toString());
      } finally {
        setState(() {
          _isLoading = false;
        });
      }

    }
  }

  Future<bool> onBackPress(context, bool value) {
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
    ) as Future<bool> ;
  }

  @override
  Widget build(BuildContext context) {
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
                      margin: const EdgeInsets.only(top: 70),
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
                              horizontal: 21.0.w, vertical: 28.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: SvgPicture.asset(AssetResources.logoIcon),
                              ),
                              10.verticalSpace,
                              Text(
                                'Welcome,',
                                style: CustomTextStyles.titleLarge38.copyWith(
                                  color: AppColors.primaryColor,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                StringResources.SIGN_UP_TO_START,
                                style:
                                    CustomTextStyles.bodySmallBlack900.copyWith(),
                              ),
                              const SizedBox(height: 24.0),
                              const SizedBox(height: 16.0),
                              CustomTextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Name is required";
                                  }
                                },
                                hintText: 'Name',
                                textInputType: TextInputType.text,
                                controller: nameController,
                               focusNode: FocusNode()
                              ),
                              16.verticalSpace,
                              CustomTextFormField(
                                validator: (v) {
                                  if (v!.trim().isEmpty) {
                                    return "Email is required";
                                  } else if (!EmailValidator.validate(
                                      v.replaceAll(" ", "").trim())) {
                                    return "Email is invalid";
                                  }
                                  return null;
                                },
                                controller: emailController,
                                hintText: 'Email',
                                textInputType: TextInputType.emailAddress,
                                autofocus: false,
                              ),
                              const SizedBox(height: 16.0),
                              CustomTextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Passowrd is required";
                                  }
                                },
                                controller: passwordController,
                                hintText: 'Password',
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
                                autofocus: false,
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                children: [
                                  CustomCheckboxButton(
                                    value: _isChecked,
                                    onChange: (newValue) {
                                      setState(() {
                                        _isChecked = newValue;
                                      });
                                    },
                                    iconSize: 28.sp,
                                  ),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                              text:
                                                  'By creating an account your agree \nto our ',
                                              style: GoogleFonts.lato()),
                                          TextSpan(
                                            text: 'Terms and Conditions',
                                            style: TextStyle(
                                              color: AppColors.tedBlue,
                                            ),
                                            // Add onTap handler for the "Terms and Conditions" part if needed
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24.0),
                              Center(
                                child: Consumer<AuthenticationProvider>(
                                    builder: (context, vm, _) {
                                  return AppButton(
                                    onPressed:
                                       _isChecked
                                           ? vm.signupViewState == ViewState.busy
                                            ? () {}
                                            : () {
                                                onSignup();
                                              }
                                              : null,

                                    isLoading:
                                        vm.signupViewState == ViewState.busy,
                                    text: 'Sign Up',
                                    radius: 25.r,
                                    textStyle: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600),
                                    //width: 320.w,
                                  );
                                }),
                              ),
                              SizedBox(height: 14.0.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Do you have account?",
                                      style: CustomTextStyles.bodySmallBlack900),
                                  TextButton(
                                    onPressed: () {
                                      pushToWithRoute(context, CustomRoutes.fadeIn( const SignInScreen()));

                                      // PageNavigator(ctx: context).nextPage(page:  const SignInScreen()
                                     // LoginPinScreen(username: nameController.text,)
                                    },
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                        color: AppColors.tedTextBlue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 14.0.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Expanded(
                                    child: Divider(
                                      color: AppColors.tedDividerColor,
                                      thickness: 0.2,
                                      indent: 60,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      'or sign in with',
                                      style: CustomTextStyles.titleSmallBlack400
                                          .copyWith(
                                        color: AppColors.tedDividerColor,
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                    child: Divider(
                                      thickness: 0.2,
                                      endIndent: 60,
                                      color: AppColors.tedDividerColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconCircularContainer(
                                      svgIcon: AssetResources.faceBookIcon,
                                      onPressed: () {}),
                                  SizedBox(width: 16.0.w),
                                  IconCircularContainer(
                                      svgIcon: AssetResources.googleIcon,
                                      onPressed: () {}),
                                  SizedBox(width: 16.0.w),
                                  IconCircularContainer(
                                      svgIcon: AssetResources.appleIcon,
                                      onPressed: () {}),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      if (_isLoading)
                      Positioned.fill(
                        child: Container(
                          color: Colors.white.withOpacity(0.5),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
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
}

class IconCircularContainer extends StatelessWidget {
  final String svgIcon;
  final Function() onPressed;
  const IconCircularContainer({
    super.key,
    required this.svgIcon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset(svgIcon),
        ),
      ),
    );
  }
}
