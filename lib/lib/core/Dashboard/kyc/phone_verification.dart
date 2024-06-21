import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/kyc_provider.dart';
import '../../../shared/navigations/routes/navigation_service.dart';
import '../../../shared/util/share_preference_util.dart';
import '../../../shared/util/widgets/appbar.dart';
import '../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../shared/util/widgets/custom_text_form_field.dart';
import '../../../theme/custom_text_style.dart';
import '../../env/utils/alert_toast.dart';
import '../../env/utils/colors.dart';
import '../../env/utils/string_resources.dart';
import 'nin.dart';

class PhoneVerification extends StatefulWidget {
  final String? phoneNumber;
  final String? otp;
  final String? email;

  const PhoneVerification({super.key, this.phoneNumber,  this.otp, this.email});

  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {

  bool isHovered = false;
  String? _inputOTP;
  bool? isVerified;
  final TextEditingController _codeController = TextEditingController(text: "");
  late AuthenticationProvider authenticationProvider;
  late KYCProvider kycProvider;

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
    authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    kycProvider = Provider.of<KYCProvider>(context, listen: false);
    return  PopScope(
      onPopInvoked: (value) => onBackPress(context, value),
      canPop: false,
      child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
            child: Column(
                  children: [
            TedTopWidget(
              leadingIcon: Container(),
              titleText: StringResources.phone_verification,
              rightIconOnTap: () {
              },
              trailing: Container(),
            ),
            20.verticalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.verticalSpace,
                Text(
                  'Type a Code',
                  style: CustomTextStyles.titleSmallGray500

                ),
                30.verticalSpace,
                Row(
                  children: [
                    Expanded(
                        child: CustomTextFormField(
                          hintText: 'Code',
                          radius: 20.r,
                          textInputType: TextInputType.number,
                          //controller: _codeController,
                          onChange: (value) {
                            _inputOTP = value;
                          },
                        )),
                    18.horizontalSpace,
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: AppButton(
                          onPressed: () {
                            resendCode();
                          },
                          text: 'Resend',
                          radius: 20.r,
                          // width: 150,
                        ),
                      ),
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
                        style: CustomTextStyles.bodySmallGray500
                            .copyWith(
                            color: AppColors.tedBlackText),
                      ),
                      TextSpan(
                        text: widget.phoneNumber ?? '+2347032502259',
                        style: const TextStyle(
                            color: AppColors.tedTextBlue2),
                      ),
                    ],
                  ),
                ),
                20.verticalSpace,
                Text(
                  StringResources.code_expires,
                  style: CustomTextStyles.bodySmallGray500
                      .copyWith(color: AppColors.tedBlackText),
                ),
                SizedBox(height: 45.0.h),
                Center(
                  child:  MouseRegion(
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
                        verifyCode(_inputOTP!);
                        // pushToWithRoute(
                        //     context, CustomRoutes.fadeIn(const NINPage()));
                      },
                      text: "Verify OTP",
                      radius: 18.r,
                      height: 52,
                      color: isHovered ? AppColors.primaryColor : AppColors.tedButtonGrey,

                    ),
                  ),
                ),
                45.verticalSpace,

              ],
            )
                  ],
                ),
          )),
    );
  }
  void resendCode() async {
    final email = await SharedPreferenceUtils.getEmail();
    await authenticationProvider.resendOtp(email:email ?? '');
  }
  void verifyCode(String code) async {
   // String phoneNum = await SharedPreferenceUtils.getPhoneNum();
    String trimmedCode = code.trim();
    log("Verifying OTP: $trimmedCode for email: $widget.phoneNumber ");
    bool isVerified = await kycProvider.verifyOTP(
      phone: widget.phoneNumber ?? '',
      code: trimmedCode,
    );

    if (isVerified) {
      pushToWithRoute(
          context, CustomRoutes.fadeIn(const NINPage()));
    } else {
      AlertToast(context: context)
          .showError(authenticationProvider.errorMessage);
    }
  }

  }
