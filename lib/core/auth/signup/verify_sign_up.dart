import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tedfinance_mobile/core/auth/signup/sign_up.dart';
import '../../../providers/auth_provider.dart';
import '../../../shared/navigations/routes/navigation_service.dart';
import '../../../shared/util/asset_images.dart';
import '../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../shared/util/widgets/custom_text_form_field.dart';
import '../../../theme/custom_text_style.dart';
import '../../env/utils/alert_toast.dart';
import '../../env/utils/colors.dart';
import '../../env/utils/string_resources.dart';
import 'create_pin.dart';

class VerifySignUpScreen extends StatefulWidget {
  final String email;
  final String password;
  final String name;
  const VerifySignUpScreen(
      {super.key,
      required this.email,
      required this.name,
      required this.password});

  @override
  State<VerifySignUpScreen> createState() => _VerifySignUpScreenState();
}

class _VerifySignUpScreenState extends State<VerifySignUpScreen> {
  bool? isVerified;
  bool isHovered = false;
  int _countdown = 60;
  Timer? _timer;
  String code = " ";
  bool _isButtonEnabled = false;
  final TextEditingController _codeController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    isVerified = false;
    startTimer();
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 70),
                    height: MediaQuery.of(context).size.height,
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
                        child: isVerified == true
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  20.verticalSpace,
                                  Image.asset(AssetResources.verifySignUp),
                                  16.verticalSpace,
                                  Center(
                                    child: Text(
                                      StringResources.email_verified,
                                      style: CustomTextStyles.titleMediumWhite16
                                          .copyWith(
                                              color: AppColors.tedPurpleText),
                                    ),
                                  ),
                                  10.verticalSpace,
                                  Center(
                                    child: Text(
                                      StringResources
                                          .emaail_successfully_verified,
                                      textAlign: TextAlign.center,
                                      style: CustomTextStyles.titleSmallBlack400
                                          .copyWith(),
                                    ),
                                  ),
                                  SizedBox(height: 25.0.h),
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
                                        pushToWithRoute(
                                            context, CustomRoutes.fadeIn(const CreatePinScreen()));
                                      },
                                      text: "Proceed to Create PIN",
                                      color: isHovered
                                          ? AppColors.primaryColor
                                          : AppColors.tedButtonGrey,
                                      radius: 15,
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  10.verticalSpace,
                                  Text(
                                    'Type a Code',
                                    style: CustomTextStyles.titleSmallGray500
                                        .copyWith(
                                      color: AppColors.tedBlackText,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  10.verticalSpace,
                                  Row(
                                    children: [
                                      Expanded(
                                          child: CustomTextFormField(
                                        hintText: 'Code',
                                        radius: 20.r,
                                        textInputType: TextInputType.number,
                                            controller: _codeController,
                                      )

                                      ),
                                      18.horizontalSpace,
                                      Expanded(
                                        child: AppButton(
                                          onPressed: _isButtonEnabled
                                              ? () {
                                            resendCode();
                                            _countdown = 60;
                                            startTimer();
                                            setState(() {
                                              _isButtonEnabled = false;
                                            });
                                          }
                                              : null,
                                          text: _countdown > 0
                                              ? 'Resend in ${_countdown.toString().padLeft(2, '0')}:00'
                                              : 'Resend',
                                          radius: 20.r,
                                        )
                                      )
                                    ],
                                  ),
                                  16.verticalSpace,
                                  SizedBox(height: 14.0.h),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              "We sent you a code to verify your Email address ",
                                          style: CustomTextStyles
                                              .bodySmallGray500
                                              .copyWith(
                                                  color:
                                                      AppColors.tedBlackText),
                                        ),
                                        TextSpan(
                                          text: widget.email,
                                          style: const TextStyle(
                                              color: AppColors.tedTextBlue2),
                                        ),
                                      ],
                                    ),
                                  ),
                                  10.verticalSpace,
                                  Text(
                                    StringResources.code_expires,
                                    style: CustomTextStyles.bodySmallGray500
                                        .copyWith(
                                            color: AppColors.tedBlackText),
                                  ),
                                  SizedBox(height: 45.0.h),
                                  Center(
                                    child: MouseRegion(
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
                                          verifyCode(_codeController.text);
                                          // setState(() {
                                          //   isVerified = true;
                                          // });
                                        },
                                        text: "Verify",
                                        radius: 20.r,
                                        height: 59.h,
                                        color: isHovered
                                            ? AppColors.primaryColor
                                            : AppColors.tedButtonGrey,
                                        hoverColor: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                  45.verticalSpace,
                                  Center(
                                    child: TextButton(
                                      onPressed: () {
                                        //Navigator.of(context, rootNavigator: true).pop();
                                        PageNavigator(ctx: context).nextPageOnly(
                                            page: const SignUpScreen()
                                        );
                                      },
                                      child: Text(
                                        StringResources.change_email,
                                        style: CustomTextStyles.titleMediumWhite16
                                            .copyWith(
                                                color: AppColors.tedPurpleText),
                                      ),
                                    ),
                                  )
                                ],
                              )

                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else {
        _timer?.cancel();
        setState(() {});
        _isButtonEnabled = true;
      }
    });
  }

  void resendCode() async {
    AuthenticationProvider authenticationProvider =
    Provider.of<AuthenticationProvider>(context, listen: false);
    await authenticationProvider.resendOtp(email: widget.email);
    startTimer();
  }


  void verifyCode(String code) async {
    AuthenticationProvider authenticationProvider =
    Provider.of<AuthenticationProvider>(context, listen: false);
    bool isVerified = await authenticationProvider.verifyEmailSignup(
      name: widget.name,
      email: widget.email,
      password: widget.password,
      code: code,
    );

    if (isVerified) {
      setState(() {
        this.isVerified = true;
      });
    } else {
      AlertToast(context: context)
          .showError(authenticationProvider.errorMessage);
    }
  }
}
