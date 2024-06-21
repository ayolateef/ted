import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../providers/auth_provider.dart';
import '../../../shared/navigations/routes/navigation_service.dart';
import '../../../shared/util/asset_images.dart';
import '../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../shared/util/widgets/custom_pin_code_text_field.dart';
import '../../../shared/util/widgets/messenger.dart';
import '../../../theme/custom_text_style.dart';
import '../../env/utils/alert_toast.dart';
import '../../env/utils/colors.dart';
import '../../env/utils/string_resources.dart';
import '../onboarding/onboarding_screen.dart';
import 'bottomsheet/bottomsheet.dart';
import 'create_username.dart';

class CreatePinScreen extends StatefulWidget {
  const CreatePinScreen({super.key});

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {

  bool isCreatePin = false;
  bool isHovered = false;
  String createdPin = '';
  late bool _isLoading = false;
  final TextEditingController _pinController = TextEditingController();
  final storage = const FlutterSecureStorage();
  @override
  void dispose() {

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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            30.verticalSpace,
                            Center(child: Image.asset(AssetResources.lockIcon)),
                            26.verticalSpace,
                            Center(
                              child: Text(
                                isCreatePin == true ?  StringResources.confirm_pin
                                    :StringResources.create_ted_pin,
                                style: CustomTextStyles.headlineSmallOnPrimary25
                                    .copyWith(
                                    color: AppColors.primaryColor)
                              ),
                            ),

                            10.verticalSpace,
                            Center(
                              child: Text(
                               isCreatePin == true ?StringResources.enter_4_digit_code_again
                                :StringResources.enter_4_digit_code,
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.bodySmallGray500
                                    .copyWith(
                                    color: AppColors.tedBlackText),
                              ),
                            ),
                            SizedBox(height: 25.0.h),
                          CustomPinCodeTextField(
                            context: context,
                            controller: _pinController,
                            onChanged: (value) {
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a PIN';
                              }
                              return null;
                            },
                            readOnly: false,
                          ),
                            50.verticalSpace,
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
                                    if(!isCreatePin){
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      createPin();
                                    }else{
                                        confirmPin(_pinController.text);
                                        setState(() {
                                          _isLoading = true;
                                        });
                                    }

                                  },
                                  text: isCreatePin == true ? "Confirm"  :"Proceed",
                                  color: isHovered ? AppColors.primaryColor : AppColors.tedButtonGrey,
                                  radius: 15.r,
                                ),
                              ),
                            ),
                          ],
                        )

                    ),
                  ),
                  if (_isLoading)
                    Visibility(
                      visible: isCreatePin,
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
    );
  }

  void createPin() async {
    createdPin = _pinController.text;
    setState(() {
      isCreatePin = true;
      _isLoading = false;
    });
    _pinController.clear();

    const storage = FlutterSecureStorage();
    await storage.write(key: 'pin', value: createdPin);
  }

  void confirmPin(String code) async {
    const storage = FlutterSecureStorage();
    final storedPin = await storage.read(key: 'pin');
    if (code == storedPin) {
      AuthenticationProvider authenticationProvider =
      Provider.of<AuthenticationProvider>(context, listen: false);
     // bool isConfirmed = await authenticationProvider.createPin(_pinController.text);
      bool isConfirmed = await authenticationProvider.createPin(int.parse(_pinController.text).toString());
      if (isConfirmed) {

        Navigator.of(context).pop();
        pinSuccessSheet(context: context);

      } else {
        AlertToast(context: context)
            .showError(authenticationProvider.errorMessage);
      }
    } else {
      AlertToast(context: context)
          .showError("PIN does not match");
    }
  }
}
