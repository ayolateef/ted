import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tedfinance_mobile/core/auth/login/sign_in.dart';
import 'package:tedfinance_mobile/providers/auth_provider.dart';
import 'package:tedfinance_mobile/shared/util/widgets/messenger.dart';

import '../../../shared/navigations/routes/navigation_service.dart';
import '../../../shared/util/asset_images.dart';
import '../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../shared/util/widgets/custom_pin_code_text_field.dart';
import '../../../theme/custom_text_style.dart';
import '../../env/utils/alert_toast.dart';
import '../../env/utils/colors.dart';
import '../../env/utils/string_resources.dart';
import '../signup/create_username.dart';

class LoginPinScreen extends StatefulWidget {
  final String? username;
  const LoginPinScreen({super.key, this.username});

  @override
  State<LoginPinScreen> createState() => _LoginPinScreenState();
}

class _LoginPinScreenState extends State<LoginPinScreen> {
  final TextEditingController _loginController = TextEditingController();
  String createdPin = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 25.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                30.verticalSpace,
                Center(child: Image.asset(AssetResources.welcomeBackImage)),
                26.verticalSpace,
                Center(
                  child: Text("${StringResources.welcome_back_ted} ${widget.username ?? "Lateef"}! ",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 25.sp))),
                ),
                10.verticalSpace,
                Center(
                  child: Text(
                    StringResources.enter_your_digit,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColors.tedBlackText)),
                  ),
                ),
                30.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: CustomPinCodeTextField(
                    context: context,
                    controller: _loginController,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a PIN';
                      }
                      return null;
                    },
                    readOnly: false,
                  ),
                ),
                15.verticalSpace,
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'SignOut',
                      style: CustomTextStyles.bodySmallGray500
                          .copyWith(color: AppColors.tedPurpleText),
                    ),
                  ),
                ),
                20.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Center(
                    child: AppButton(
                      // onPressed: () async {
                      //   final pin = _loginController.text;
                      //   AuthenticationProvider authenticationProvider =
                      //   Provider.of<AuthenticationProvider>(context, listen: false);
                      //   final isAuthenticated = await authenticationProvider.login(pin);
                      //   if (isAuthenticated) {
                      //     PageNavigator(ctx: context).nextPageOnly(page: const SignInScreen());
                      //   } else {
                      //     NotificationMessager.showError(context,
                      //         message: authenticationProvider.errorMessage);
                      //   }
                      // },
                      radius: 30.r,
                      text: "Continue",
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
