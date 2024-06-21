import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';

import '../../../../../shared/util/asset_images.dart';
import '../../../../../shared/util/widgets/appbar.dart';
import '../../../../../shared/util/widgets/custom_containers.dart';
import '../../../../../shared/util/widgets/custom_text_form_field.dart';
import '../../../../../theme/custom_text_style.dart';
import '../../../../env/utils/colors.dart';
import '../../../../env/utils/string_resources.dart';
import '../../bottom_sheet/root.dart';


class SendWithUsername extends StatefulWidget {
  const SendWithUsername({super.key});

  @override
  State<SendWithUsername> createState() => _SendWithUsernameState();
}

class _SendWithUsernameState extends State<SendWithUsername> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TedAppBar(
          elevation: 0,
          titleText: StringResources.transfer,
          trailing: SizedBox(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(StringResources.transfer_from_wallet,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.titleSmallBlack900_1.copyWith(
                        fontSize: 14.sp, fontWeight: FontWeight.w400)),
                20.verticalSpace,
                CustomTextFormField(
                  headerText: "Source of funds",
                  hintText: "Select Sources of funds",
                  suffix: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                    ),
                    child: SvgPicture.asset(
                      AssetResources.dropdownIcon,
                      height: 12,
                    ),
                  ),
                ),
                30.verticalSpace,
                const CustomTextFormField(
                  headerText: "Amount",
                  hintText: "Enter amount",
                ),
                30.verticalSpace,
                CustomTextFormField(
                    headerText: "Receiver’s Username",
                    hintText: "@username",
                    hintStyle: TextStyle(
                        color: AppColors.white, fontWeight: FontWeight.w500),
                    fillColor: AppColors.primaryColor,
                    filled: true,
                    borderDecoration: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    )),
                30.verticalSpace,
                PaymentContainer(
                  onTap: () {
                    //confirmWithdrawSheet(context: context);
                  },
                  imagePath: AssetResources.picNig,
                  titleText: StringResources.ayoLateef,
                  subTitleText: StringResources.offical_teo,
                  isSvg: false,
                ),
                30.verticalSpace,
                Text('Choose beneficiary',
                    style: CustomTextStyles.bodySmallGray500
                        .copyWith(color: AppColors.primaryColor)),
                40.verticalSpace,
                Center(
                  child: AppButton(
                    onPressed: () {
                      withdrawWithUsernameSheet(context: context);
                    },
                    text: 'Confirm',
                    radius: 30.r,
                    width: 300.w,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
