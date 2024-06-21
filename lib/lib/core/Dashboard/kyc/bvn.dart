import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tedfinance_mobile/core/Dashboard/kyc/phone_verification.dart';
import 'package:tedfinance_mobile/shared/models/kyc_model/bvn_model.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';
import '../../../providers/kyc_provider.dart';
import '../../../shared/navigations/routes/navigation_service.dart';
import '../../../shared/util/widgets/appbar.dart';
import '../../../shared/util/widgets/custom_text_form_field.dart';
import '../../env/utils/alert_toast.dart';
import '../../env/utils/colors.dart';
import '../../env/utils/string_resources.dart';

class BVNPage extends StatefulWidget {
  const BVNPage({super.key});

  @override
  State<BVNPage> createState() => _BVNPageState();
}

class _BVNPageState extends State<BVNPage> {
  bool isHovered = false;
  final TextEditingController _bvnController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late KYCProvider kycProvider;
  bool isBvnVerified = false;
  bool isButtonEnabled = true;
  bool isLoading = false;
  String? phoneNumber;


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
   kycProvider = Provider.of<KYCProvider>(context, listen: false);
    return PopScope(
      onPopInvoked: (value) => onBackPress(context, value),
      canPop: false,
      child: Scaffold(
          body: Stack(
            children: [
              Form(
                    key: _formKey,
                    child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
              child: Column(
                children: [
                  TedTopWidget(
                    titleText: StringResources.BVN,
                    rightIconOnTap: () {},
                    trailing: Container(),
                  ),
                  20.verticalSpace,
                  SvgPicture.asset(AssetResources.blackStepperIcon),
                  80.verticalSpace,
                  CustomTextFormField(
                    hintText: 'Your BVN',
                    headerText: 'Enter Your Bank Verification Number',
                    textInputType: TextInputType.number,
                    controller: _bvnController,
                    textInputFormatters: [
                      LengthLimitingTextInputFormatter(11),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'BVN is required';
                      } else if (value.length != 11) {
                        return 'BVN must be 11 digits';
                      }
                      return null;
                    },
                  ),
                  100.verticalSpace,
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
                      onPressed: isButtonEnabled ? verifyBvn : null,
                      text: 'Next',
                      radius: 15.r,
                      height: 50,
                      color: isHovered
                          ? AppColors.primaryColor
                          : AppColors.tedButtonGrey,
                    ),
                  ),
                ],
              ),
                    ),
                  ),
              if (isLoading)
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
          )),
    );
  }

  verifyBvn() async {
    if ( _formKey.currentState!.validate()) {
      setState(() {
        isBvnVerified = true;
        isLoading = true;
      });

      try {
        Map<String, dynamic>? result = await kycProvider.verifyBVN(_bvnController.text);
        BVNModel bvnModel = result?['bvnModel'] ?? BVNModel();
        String phoneNumber = result?['phoneNumber'] ?? '';
        String otp = result?['otp'] ?? '';
        print("Parsed NINModel: $bvnModel");
        await kycProvider.saveBVN(_bvnController.text);
        pushToWithRoute(
            context, CustomRoutes.fadeIn( PhoneVerification(
          phoneNumber: phoneNumber,
          otp: otp,


        )));
            } catch (e) {
        AlertToast(context: context).showError(e.toString());
      }
      finally {
        setState(() {
          isBvnVerified = false;
          isLoading = false;
        });
      }
    }
  }
}
