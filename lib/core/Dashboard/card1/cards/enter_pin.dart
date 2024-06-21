import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tedfinance_mobile/core/Dashboard/drawer/bottom_sheet/root.dart';
import 'package:tedfinance_mobile/core/env/utils/string_resources.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';
import 'package:tedfinance_mobile/theme/custom_text_style.dart';

import '../../../../../shared/util/widgets/custom_pin_code_text_field.dart';
import '../../../env/utils/colors.dart';


class EnterPinVirtualSheet extends StatefulWidget {
  const EnterPinVirtualSheet({super.key});

  @override
  State<EnterPinVirtualSheet> createState() => _EnterPinVirtualSheetState();
}

class _EnterPinVirtualSheetState extends State<EnterPinVirtualSheet> {
  final TextEditingController _enterPinController = TextEditingController();

  @override
  void dispose() {
    _enterPinController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          30.verticalSpace,
          Padding(
            padding:  EdgeInsets.only(left: 20.w, top: 20.0),
            child: InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Image.asset(AssetResources.closeIcon)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              40.verticalSpace,
              Container(
                color: Colors.transparent,
                child: Image.asset(
                  AssetResources.enterPinImage,
                ),
              ),
              30.verticalSpace,
              Text(
                StringResources.enterPin,
                style: CustomTextStyles.headlineSmallOnPrimary
                    .copyWith(color: (AppColors.tedBigTextPurpleColor)),
              ),
              30.verticalSpace,
              Text(
                  StringResources.enter_your_digit,
                  style: CustomTextStyles.bodySmallGray500
              ),
              30.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: CustomPinCodeTextField(
                  context: context,
                  controller: _enterPinController,
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a PIN';
                    }
                    return null;
                  },
                  readOnly: false,
                  borderRadius: BorderRadius.circular(1.1),
                ),
              ),
              40.verticalSpace,
              AppButton(
                onPressed: () {
                  Navigator.of(context).pop;
                  //paymentSuccessSheet(context: context);
                 // virtualCardActivatedSheet(context:  context);
                   fundAddedSuccessSheet(context:  context);
                  //successfulWithdrawSheet(context:  context);
                  //frozenSuccessSheet(context: context);
                 // deleteSuccessSheet(context: context);
                },
                text: 'Continue',
                width: 350.w,
                color: AppColors.primaryColor,
                radius: 30.r,
              )
            ],
          ),
        ],
      ),
    );
  }
}
