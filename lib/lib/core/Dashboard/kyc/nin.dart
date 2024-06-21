
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tedfinance_mobile/core/Dashboard/kyc/personal_bio.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';

import '../../../providers/kyc_provider.dart';
import '../../../shared/models/kyc_model/nin_model.dart';
import '../../../shared/navigations/routes/navigation_service.dart';
import '../../../shared/util/widgets/appbar.dart';
import '../../../shared/util/widgets/custom_text_form_field.dart';
import '../../env/utils/alert_toast.dart';
import '../../env/utils/colors.dart';
import '../../env/utils/string_resources.dart';

class NINPage extends StatefulWidget {
  const NINPage({super.key});

  @override
  State<NINPage> createState() => _NINPageState();
}

class _NINPageState extends State<NINPage> {
  bool isHovered = false;
  final TextEditingController _ninController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
    kycProvider = Provider.of<KYCProvider>(context, listen: false);
    return  PopScope(
      onPopInvoked: (value) => onBackPress(context, value),
      canPop: false,
      child: Scaffold(
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
              child: Column(
                children: [
                  TedTopWidget(
                    titleText: StringResources.NIN,
                    rightIconOnTap: () {},
                    trailing: Container(),
                  ),
                  20.verticalSpace,
                  Image.asset(AssetResources.step2),
                  80.verticalSpace,
                  CustomTextFormField(
                    hintText: 'Your NIN',
                    headerText: 'Enter Your NIN 11 Digit Number',
                    textInputType: TextInputType.number,
                    controller: _ninController,
                    textInputFormatters: [
                      LengthLimitingTextInputFormatter(11),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'NIN is required';
                      } else if (value.length != 11) {
                        return 'NIN must be 11 digits';
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
                      onPressed: () {
                        verifyNIN();
                      },
                      text: 'Verify NIN',
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
          )),
    );
  }

  verifyNIN() async {
    if ( _formKey.currentState!.validate())  {
      try {

        NINModel? nin = await kycProvider.verifyNIN(_ninController.text);
        await kycProvider.saveNIN(_ninController.text);
        print("Parsed NINModel: $nin");
        if (nin != null) {
          pushToWithRoute(
              context, CustomRoutes.fadeIn(

              PersonalBio(
              ninModel: nin

          )
          ));
        } else {
          AlertToast(context: context).showError(kycProvider.errorMessage);
        }
      } catch (e) {
        AlertToast(context: context).showError(e.toString());
      }
    }
  }
}
