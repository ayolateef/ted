import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tedfinance_mobile/core/env/utils/colors.dart';
import 'package:tedfinance_mobile/core/env/utils/string_resources.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';

import '../../../../../shared/navigations/routes/navigation_service.dart';
import '../../../../../theme/custom_text_style.dart';
import '../../settings/payment/traansfer.dart';

class ConfirmAccountSheet extends StatelessWidget {
  const ConfirmAccountSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 55.h),
      child: SizedBox(
        height: 550,
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(AssetResources.questionIcon),
                8.horizontalSpace,
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "Please confirm you have\nprovided the correct details.",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.tedDeepPurple),
                      ),
                      TextSpan(
                        text: "\n",
                      ),
                      TextSpan(
                        text:
                            "Providing the wrong information will cause delay\nwith payment.",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppColors.tedDeepPurple),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            30.verticalSpace,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10.r)),
              child: Column(
                children: [
                  Text(
                    StringResources.bankAccountDetails,
                    style: CustomTextStyles.titleMedium18,
                  ),
                  40.verticalSpace,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(AssetResources.stepperIcon2),
                      20.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Account Name'),
                          65.verticalSpace,
                          Text('Bank Name'),
                          18.verticalSpace,
                          Text('Account No'),
                          20.verticalSpace,
                          const Text(
                            'Change Method',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                          )
                        ],
                      ),
                      50.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Abdullateef Ayodele\nSalaudeen',
                              style:
                                  CustomTextStyles.titleSmallBlack400.copyWith(
                                fontWeight: FontWeight.w600,
                              )),
                          43.verticalSpace,
                          Text('Kuda Bank',
                              style:
                                  CustomTextStyles.titleSmallBlack400.copyWith(
                                fontWeight: FontWeight.w600,
                              )),
                          18.verticalSpace,
                          Text(
                            '222222222',
                            style: CustomTextStyles.titleSmallBlack400.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          18.verticalSpace,
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            60.verticalSpace,
            AppButton(
              onPressed: () {
                Navigator.of(context).pop();
                PageNavigator(ctx: context).nextPage(page: const TransferPage());
              },
              text: 'Add Payment Method',
              width: 350.w,
              color: AppColors.primaryColor,
              radius: 30.r,
            )
          ],
        ),
      ),
    );
  }
}
