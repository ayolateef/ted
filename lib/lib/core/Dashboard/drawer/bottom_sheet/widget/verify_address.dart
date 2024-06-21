import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_text_form_field.dart';

import '../../../../../theme/custom_text_style.dart';
import '../../../../env/utils/string_resources.dart';

class VerifyAddressSheet extends StatefulWidget {
  final Function(bool) onUpdateAddressVerification;
  const VerifyAddressSheet({super.key, required this.onUpdateAddressVerification});

  @override
  State<VerifyAddressSheet> createState() => _VerifyAddressSheetState();
}

class _VerifyAddressSheetState extends State<VerifyAddressSheet> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 28.h),
      child: SizedBox(
        height: 460.h,
        child: Column(
          children: [
            Text(StringResources.address_verification,
                style: CustomTextStyles.titleLargeBlack),
            10.verticalSpace,
            const CustomTextFormField(
              headerText: 'Address',
              hintText:' Enter your full address ',
            ),
            80.verticalSpace,
            AppButton(
              onPressed: (){
Navigator.of(context).pop();
              },
              text: 'Verify',

              radius: 20.r,
              width: 350.w,
              height: 68.h,

            )

          ],
        ),
      ),
    );
  }
}
