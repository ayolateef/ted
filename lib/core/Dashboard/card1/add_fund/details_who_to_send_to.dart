import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tedfinance_mobile/shared/util/widgets/copy_button.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_text_form_field.dart';

import '../../../../shared/util/widgets/appbar.dart';
import '../../../../theme/custom_text_style.dart';
import '../../../env/utils/colors.dart';
import '../../../env/utils/string_resources.dart';
import 'add_fund_to_wallet.dart';

class DetailsFundAccount extends StatefulWidget {
  final SmallContainer selectedItem;
  const DetailsFundAccount({super.key, required this.selectedItem});

  @override
  State<DetailsFundAccount> createState() => _DetailsFundAccountState();
}

class _DetailsFundAccountState extends State<DetailsFundAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TedAppBar(
          elevation: 0, titleWidget: _buildTitleWidget(widget.selectedItem)),
      body: Stack(
        children: [

          Positioned(
            right: -120,
            top: 0,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.purple, // Change color to purple
                borderRadius:BorderRadius.circular(100.r)
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 15.h),
                  decoration: BoxDecoration(
                    color: AppColors.white2,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        headerText: "Account Name",
                        hintText: "Account Name",
                        textFontSize: 12.sp,
                        headerTextColor: AppColors.primaryColor,
                        borderDecoration: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        focusDecoration: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                      ),
                      20.verticalSpace,
                      CustomTextFormField(
                        headerText: "Account Number",
                        hintText: "2001399421",
                        textFontSize: 12.sp,
                        headerTextColor: AppColors.primaryColor,
                        borderDecoration: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        focusDecoration: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                      ),
                      20.verticalSpace,
                      CustomTextFormField(
                        headerText: "Bank Name",
                        hintText: "GTB",
                        textFontSize: 12.sp,
                        headerTextColor: AppColors.primaryColor,
                        borderDecoration: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        focusDecoration: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                      ),
                      80.verticalSpace,
                      AppButton(
                        onPressed: () {},
                        radius: 30.r,
                        height: 64.h,
                        child: const CopyButton(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

Widget _buildTitleWidget(SmallContainer selectedItem) {
  return Row(
    children: [
      Image.asset(selectedItem.assetImage ?? ""),
      const SizedBox(width: 8),
      Text(
        selectedItem.text ?? "",
        style: CustomTextStyles.titleLargeBlack.copyWith(fontSize: 14.sp),
      ),
    ],
  );
}
