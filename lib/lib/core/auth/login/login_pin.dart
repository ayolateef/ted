import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tedfinance_mobile/core/Dashboard/dashboard.dart';
import 'package:tedfinance_mobile/core/auth/login/sign_in.dart';
import 'package:tedfinance_mobile/core/env/utils/alert_toast.dart';
import '../../../providers/auth_provider.dart';
import '../../../shared/models/auth_models/user.dart';
import '../../../shared/navigations/routes/navigation_service.dart';
import '../../../shared/util/asset_images.dart';
import '../../../shared/util/share_preference_util.dart';
import '../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../shared/util/widgets/custom_pin_code_text_field.dart';
import '../../../shared/util/widgets/messenger.dart';
import '../../../theme/custom_text_style.dart';
import '../../env/utils/colors.dart';
import '../../env/utils/string_resources.dart';

class LoginPinScreen extends StatefulWidget {
  final String username;
  const LoginPinScreen({super.key, required this.username});

  @override
  State<LoginPinScreen> createState() => _LoginPinScreenState();
}

class _LoginPinScreenState extends State<LoginPinScreen> {
  final TextEditingController _loginController = TextEditingController();
  String createdPin = '';
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AuthenticationProvider authenticationProvider ;
  TextEditingController? usernameController;

  // final authService = AuthService();

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
    authenticationProvider  = Provider.of<AuthenticationProvider>(
        context,
        listen: false);
    return  PopScope(
      canPop: false,
      onPopInvoked: (value) => onBackPress(context, value),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 25.h),
                child: Stack(
                  children: [
                    Column(
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
                            onPressed: () async{
                              // await SharedPreferenceUtils.deletePin();
                              // SharedPreferences prefs = await SharedPreferences.getInstance();
                              // prefs.clear();

                              // Navigate to the login screen
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) =>  const SignInScreen()),
                              );
                            },
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
                              onPressed: () async {
                                //final savedPin = await SharedPreferenceUtils.getPin();
                                final pin = _loginController.text;
                                final savedPin = await SharedPreferenceUtils.getPin();
                                if (savedPin == null) {
                                  AlertToast(context: context).showError("No PIN found. Please create a PIN first.");
                                  return;
                                }

                                if (pin == savedPin) {
                                  pushToAndClearStack(context, const DashboardScreen());
                                 // PageNavigator(ctx: context).nextPageOnly(page: const DashboardScreen());
                                } else {
                                  AlertToast(context: context).showError("Invalid PIN. Please try again.");
                                }
                              },
                              radius: 30.r,
                              text: "Continue",
                            )

                          ),
                        ),
                      ],
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
              ),
            ),
          ),
        ),
      ),
    );
  }

}
// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Future signOut(BuildContext context) async {
//     try {
//       await _auth.signOut();
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginPinScreen()),
//       );
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }