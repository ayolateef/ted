import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tedfinance_mobile/providers/kyc_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../shared/navigations/routes/navigation_service.dart';
import '../../../shared/util/asset_images.dart';
import '../../../shared/util/share_preference_util.dart';
import '../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../shared/util/widgets/custom_text_form_field.dart';
import '../../../theme/custom_text_style.dart';
import '../../env/utils/alert_toast.dart';
import '../../env/utils/colors.dart';
import '../../env/utils/string_resources.dart';
import 'changed_password.dart';

class ForgotPassword extends StatefulWidget {
  final String? email;
  final String? name;
  const ForgotPassword({super.key, required this.email, this.name});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool isSendCode = false;
  bool isChangedPassword = false;
  final FocusNode focusNode = FocusNode();
  bool _passwordVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  late AuthenticationProvider authenticationProvider;
  late KYCProvider kycProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  bool _isLoading = false;
  late bool isVerified;
  @override
  void dispose() {
     focusNode.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    isVerified = false;
    _isLoading = false;
  }
  @override
  Widget build(BuildContext context) {
    authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    kycProvider = Provider.of<KYCProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16.0),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: (){
                              pop(context);
                            },
                            child: SvgPicture.asset(AssetResources.shortLeftArrowWhite)),
                        35.horizontalSpace,
                        Text(
                          isChangedPassword == true
                          ? StringResources.change_password

                               :StringResources.forgot_password
                                 ,
                          style: CustomTextStyles.titleMediumBoldWhite,
                        )
                      ],
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height/1.12,
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
                        child: Stack(
                          children: [
                            if(isChangedPassword)
                              Container(
                                height: 400.h,
                                padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 18.h),
                                decoration:  BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20.r)
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1), // Shadow color
                                      spreadRadius: 1, // Spread radius
                                      blurRadius: 5, // Blur radius
                                      offset: const Offset(0, 3), // Offset
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    10.verticalSpace,
                                    Text(
                                      "Type your new password ",
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.tedGreyText)),
                                    ),
                                    25.verticalSpace,
                                    CustomTextFormField(
                                      hintText: 'Password',
                                      obscureText: !_passwordVisible,
                                      controller: _newPasswordController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Passowrd is required";
                                        }
                                      },
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
                                    15.verticalSpace,
                                    Text(
                                      "Confirm password ",
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.tedGreyText)),
                                    ),
                                    SizedBox(height: 16.0.h),
                                    CustomTextFormField(
                                      hintText: 'Password',
                                      obscureText: !_passwordVisible,
                                      controller: _confirmNewPasswordController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Passowrd is required";
                                        }
                                      },
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
                                    35.verticalSpace,
                                    Center(
                                      child: AppButton(
                                        radius: 20.r,
                                        onPressed: (){
                                          _updatePassword();
                                        },
                                        text: StringResources.change_password ,
                                      ),
                                    )

                                  ],
                                ),
                              )
                           else if (isSendCode)
                                Container(
                               height: 500.h,
                              padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 18.h),
                              decoration:  BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.r)
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1), // Shadow color
                                    spreadRadius: 1, // Spread radius
                                    blurRadius: 5, // Blur radius
                                    offset: const Offset(0, 3), // Offset
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  10.verticalSpace,
                                  Text(
                                    "Type a code ",
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.tedGreyText)),
                                  ),
                                  15.verticalSpace,
                                  const SizedBox(height: 24.0),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextFormField(
                                          hintText: 'code',
                                          focusNode: focusNode,
                                          controller: _codeController,
                                        ),
                                      ),
                                      25.horizontalSpace,
                                      AppButton(
                                        onPressed: (){
                                          resendCode();
                                        },
                                        text: 'Resend',
                                        color: AppColors.tedPurpleText,
                                        //ButtonType.tertiary.disabledColor,
                                        radius: 20.r,
                                        width: 120.w,
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 26.0.h),
                                   Text(
                                      "We texted you a code to verify your\n"
                                          "email  ${widget.email}\n",
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(fontWeight: FontWeight.w400,
                                            color: AppColors.tedGreyLongText)),
                                  ),
                                  35.horizontalSpace,

                                  Text(
                                    StringResources.code_expires_10Minutes,
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(fontWeight: FontWeight.w400,
                                            color: AppColors.tedGreyLongText)),
                                  ),
                                  SizedBox(height: 26.0.h),
                                  Center(
                                    child: AppButton(
                                      radius: 20.r,
                                      onPressed: (){
                                        verifyCode(_codeController.text);
                                        // setState(() {
                                        //   isChangedPassword = true;
                                        // });
                                      },
                                      text: StringResources.change_password ,
                                    ),
                                  )

                                ],
                              ),
                            )

                            else Container(
                             height: 380.h,
                             padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 18.h),
                             decoration:  BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.all(
                                   Radius.circular(20.r)
                               ),
                               boxShadow: [
                                 BoxShadow(
                                   color: Colors.black.withOpacity(0.1), // Shadow color
                                   spreadRadius: 1, // Spread radius
                                   blurRadius: 5, // Blur radius
                                   offset: Offset(0, 3), // Offset
                                 ),
                               ],
                             ),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 10.verticalSpace,
                                 Text(
                                   "Type your email",
                                   style: GoogleFonts.poppins(
                                       textStyle: TextStyle(
                                           fontWeight: FontWeight.w400,
                                           color: AppColors.tedGreyText)),
                                 ),
                                 15.verticalSpace,
                                 const SizedBox(height: 24.0),
                                 CustomTextFormField(
                                   hintText: 'Email',
                                   focusNode: focusNode,
                                   controller: _emailController,
                                   validator: (v) {
                                     if (v!.trim().isEmpty) {
                                       return "Email is required";
                                     } else if (!EmailValidator.validate(
                                         v.replaceAll(" ", "").trim())) {
                                       return "Email is invalid";
                                     }
                                     return null;
                                   },
                                 ),
                                 SizedBox(height: 26.0.h),
                                 Text(
                                   'We texted you a code to verify your email',
                                   style: GoogleFonts.poppins(
                                       textStyle: TextStyle(fontWeight: FontWeight.w400,
                                           color: AppColors.tedBlackText)),
                                 ),
                                 SizedBox(height: 26.0.h),
                                 Center(
                                   child: AppButton(
                                     radius: 20.r,
                                     onPressed: (){
                                        _forgotPassword();
                                       setState(() {
                                         isSendCode = true;
                                       });
                                     },
                                     text: 'Send',
                                   ),
                                 )

                               ],
                             ),
                           ),

                              if (!isSendCode && isChangedPassword)
                                 Align(
                              alignment: Alignment.bottomCenter,
                              child: TextButton(
                                  onPressed: () {  },
                                  child: Text(
                                      'Change your phone number',
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: AppColors.tedPurpleText,
                                              fontSize: 12.sp
                                          )
                                      )
                                  )
                              ),
                            )
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

  void _forgotPassword() async {
    if (_formKey.currentState!.validate()) {
      try{
        bool success = await authenticationProvider.forgotPassword(email: _emailController.text);
        if (success) {
          setState(() {
            isSendCode = true;
          });
        } else {
          AlertToast(context: context)
              .showError(authenticationProvider.errorMessage);
        }
      }
      catch (e) {
        AlertToast(context: context).showError(e.toString());
      }

    }
  }
  void resendCode() async {
    final email = await SharedPreferenceUtils.getEmail();
    await authenticationProvider.resendOtp(email:email ?? '');
  }
  void verifyCode(String code) async {
    setState(() {
      _isLoading = true;
    });


    final email = await SharedPreferenceUtils.getEmail();

    bool isVerified = await kycProvider.verifyOTP(phone: email, code: code);

    if (isVerified) {
      setState(() {
        this.isVerified = isVerified;
        _isLoading = false;
        isChangedPassword = true;
      });
    } else {
      AlertToast(context: context)
          .showError(authenticationProvider.errorMessage);
    }

  }
  void _updatePassword() async {
    try{
      if (_newPasswordController.text != _confirmNewPasswordController.text) {
        AlertToast(context: context).showError("Passwords do not match");

      } else {

        //final email = _emailController.text;
        bool result =  await authenticationProvider.updatePassword(_newPasswordController.text);
        if (result) {
         pushToWithRoute(context, CustomRoutes.fadeIn(const ChangedPassword()) );
        } else {
          AlertToast(context: context)
              .showError(authenticationProvider.errorMessage);
        }
      }
    }catch (e) {
      AlertToast(context: context).showError(e.toString());
    }

  }


}
