import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tedfinance_mobile/core/Dashboard/drawer/bottom_sheet/widget/success_payment.dart';
import 'package:tedfinance_mobile/shared/navigations/routes/navigation_service.dart';

import '../../../../../shared/util/asset_images.dart';
import '../../../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../../../theme/custom_text_style.dart';
import '../../../../env/utils/colors.dart';
import '../../../../env/utils/string_resources.dart';
import '../../../card1/report/exchange_currency.dart';
import '../root.dart';

class WithdrawSuccessSheet extends StatelessWidget {
  const WithdrawSuccessSheet({super.key});

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
                          StringResources.withdraw_success,
                          style: CustomTextStyles.titleMedium18,
                        ),
                        10.verticalSpace,
                        Text(
                          StringResources.withdraw_successfully_done,
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

                  PageNavigator(ctx: context).nextPage(page: const ExchangeCurrency());

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