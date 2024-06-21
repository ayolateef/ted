import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tedfinance_mobile/core/auth/login/login_pin.dart';
import 'package:tedfinance_mobile/core/auth/signup/bottomsheet/bottomsheet.dart';
import '../../../providers/auth_provider.dart';
import '../../../shared/navigations/routes/navigation_service.dart';
import '../../../shared/util/asset_images.dart';
import '../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../shared/util/widgets/custom_text_form_field.dart';
import '../../../shared/util/widgets/messenger.dart';
import '../../../theme/custom_text_style.dart';
import '../../env/utils/colors.dart';
import '../../env/utils/string_resources.dart';
import '../onboarding/onboarding_screen.dart';
import 'create_pin.dart';

class CreateUsername extends StatefulWidget {
  const CreateUsername({super.key});

  @override
  State<CreateUsername> createState() => _CreateUsernameState();
}

class _CreateUsernameState extends State<CreateUsername> {
  bool isHovered = false;
  final TextEditingController _usernameController = TextEditingController(text: "");
  late AuthenticationProvider authenticationProvider;
  @override
  Widget build(BuildContext context) {

    authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 90),
                    height: MediaQuery.of(context).size.height / 1.5.h,
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
                            20.verticalSpace,
                            Center(
                                child:
                                    Image.asset(AssetResources.usernameImage)),
                            16.verticalSpace,
                            Center(
                              child: Text(
                                StringResources.create_ted_username,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryColor
                                      )
                                ),
                              ),
                            ),
                            10.verticalSpace,
                            Center(
                              child: Text(
                                  StringResources.create_ted_username_choice,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.tedGreyText
                                  )
                              )
                              ),
                            ),
                            SizedBox(height: 25.0.h),
                            CustomTextFormField(
                              hintText: 'username',
                              focusNode: FocusNode(),
                              controller: _usernameController,
                              textStyle: TextStyle(fontSize: 20.sp),
                              // textInputFormatters: [
                              //   FilteringTextInputFormatter(
                              //     RegExp(r'^[a-zA-Z0-9@]*$'),
                              //     allow: true,
                              //   )
                              // ],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return StringResources.enter_username;
                                } else if (value.length < 2) {
                                  return "Enter at least two letters for the first name";
                                }
                                return null;
                              },
                            ),
                            150.verticalSpace,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
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
                                     createUsername();
                                    //welcomeSheet(context: context);
                                  },
                                  text: "Create Username",
                                  color: isHovered
                                      ? AppColors.primaryColor
                                      : AppColors.tedButtonGrey,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createUsername() async {
    final username = _usernameController.text.trim();
    if (username.isNotEmpty) {
      try {
        bool success = await authenticationProvider.createUsername(username: username);
        if (success) {
          welcomeSheet(context: context);

        }
      } catch (e) {
        NotificationMessager.showError(context,
            message: 'Failed to create username');
      }
    }
  }
}
