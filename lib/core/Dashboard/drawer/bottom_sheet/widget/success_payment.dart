import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tedfinance_mobile/theme/custom_text_style.dart';

import '../../../../../shared/util/asset_images.dart';
import '../../../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../../env/utils/colors.dart';
import '../../../../env/utils/string_resources.dart';
import '../root.dart';

class PaymentSuccessSheet extends StatelessWidget {
  const PaymentSuccessSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 35.h),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Image.asset(AssetResources.closeIcon)),
                  InkWell(
                      onTap: () {},
                      child: SvgPicture.asset(AssetResources.shareIcon2)),
                ],
              ),
              30.verticalSpace,
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 20),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Column(
                      children: [
                        20.verticalSpace,
                        Text(
                          StringResources.payment_success,
                          style: CustomTextStyles.titleMedium18,
                        ),
                        10.verticalSpace,
                        Text(
                          StringResources.payment_successfully_done,
                          style: CustomTextStyles.titleSmallGray500
                              .copyWith(fontSize: 14.0),
                        ),
                        20.verticalSpace,
                        Divider(
                          color: AppColors.tedDividerColor.withOpacity(.2),
                        ),
                        20.verticalSpace,
                        Text(
                          StringResources.total_payment,
                          style: CustomTextStyles.titleSmallBlack400,
                        ),
                        10.verticalSpace,
                        Text('\$\4,500.00 USD',
                            style: CustomTextStyles.titleLargeBlack),
                        15.verticalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            20.verticalSpace,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const PaymentContainerSheet(
                                  titleText: 'Ref Number',
                                  subTitle: '000085752257',
                                ),
                                20.horizontalSpace,
                                const PaymentContainerSheet(
                                  titleText: 'Payment Time',
                                  subTitle: '25 Feb 2023, 13:22',
                                )
                              ],
                            ),
                            20.verticalSpace,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const PaymentContainerSheet(
                                  titleText: StringResources.payment_method,
                                  subTitle: 'Card Transfer',
                                ),
                                20.horizontalSpace,
                                const PaymentContainerSheet(
                                  titleText: 'Sender Name',
                                  subTitle: 'Bukayo Saka',
                                )
                              ],
                            ),
                            30.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(AssetResources.importIcon),
                                10.horizontalSpace,
                                const Text(
                                  StringResources.get_pdf,
                                ),
                                30.verticalSpace,
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      top: -30,
                      right: 0,
                      left: 0,
                      child: Container(
                          height: 56,
                          width: 56,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: AppColors.white, shape: BoxShape.circle),
                          child: SvgPicture.asset(AssetResources.tickIcon))),
                ],
              ),
              100.verticalSpace,
              AppButton(
                onPressed: () {
                  enterPinSheet(
                      context: context,
                      isFromSellButton: false

                  );

                },
                text: 'Done',
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

class PaymentContainerSheet extends StatelessWidget {
  final String? titleText;
  final String? subTitle;
  const PaymentContainerSheet({
    super.key,
    this.titleText,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.r),
          border: Border.all(color: AppColors.tedBorderColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(titleText ?? '',
              style:
                  CustomTextStyles.bodySmallGray500.copyWith(fontSize: 12.sp)),
          5.verticalSpace,
          Text(
            subTitle ?? '',
            style: CustomTextStyles.bodySmallBlack900.copyWith(fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
