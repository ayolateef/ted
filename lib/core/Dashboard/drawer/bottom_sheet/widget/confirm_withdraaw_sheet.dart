import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tedfinance_mobile/shared/navigations/routes/navigation_service.dart';

import '../../../../../shared/util/asset_images.dart';
import '../../../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../../../theme/custom_text_style.dart';
import '../../../../env/utils/colors.dart';
import '../../../../env/utils/string_resources.dart';
import '../root.dart';
import 'enter_pin.dart';

class ConfirmWithdrawSheet extends StatelessWidget {
  const ConfirmWithdrawSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 55.h),
      child: SizedBox(
        height: 580,
        child: SingleChildScrollView(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
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
                                style: CustomTextStyles.titleSmallBlack400
                                    .copyWith(
                                  fontWeight: FontWeight.w600,
                                )),
                            43.verticalSpace,
                            Text('Kuda Bank',
                                style: CustomTextStyles.titleSmallBlack400
                                    .copyWith(
                                  fontWeight: FontWeight.w600,
                                )),
                            18.verticalSpace,
                            Text(
                              '222222222',
                              style:
                                  CustomTextStyles.titleSmallBlack400.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            18.verticalSpace,
                          ],
                        )
                      ],
                    ),
                    10.verticalSpace,
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 20),
                        decoration: BoxDecoration(
                            color: AppColors.white2,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  StringResources.amountWithdraw,
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                8.verticalSpace,
                                Text(
                                  "N 0.00 ",
                                  style: CustomTextStyles.titleMedium18
                                      .copyWith(fontSize: 34.sp),
                                )
                              ],
                            ),
                            Container(
                                width: 85,
                                decoration: BoxDecoration(
                                    color: AppColors.grey[65],
                                    borderRadius: BorderRadius.circular(30.r)),
                                child: Row(

                                  children: [
                                    SvgPicture.asset(
                                        AssetResources.circularNigFlag, height: 10,width: 10, ) ,
                                    Text('NGN',
                                        style:
                                            CustomTextStyles.titleSmallBlack400)
                                  ],
                                ))
                          ],
                        ))
                  ],
                ),
              ),
              60.verticalSpace,
              AppButton(
                onPressed: () {
                  enterPinSheet(
                      context: context,
                      isFromSellButton: false

                  );
                 // PageNavigator(ctx: context).nextPage(page: EnterPinPage());
                },
                text: 'Withdraw',
                width: 350.w,
                color: AppColors.primaryColor,
                radius: 30.r,
              )
            ],
          ),
        ),
      ),
    );
  }
}
