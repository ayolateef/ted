import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tedfinance_mobile/core/Dashboard/card1/send/card_details.dart';
import 'package:tedfinance_mobile/shared/navigations/routes/navigation_service.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';

import '../../../../shared/util/asset_images.dart';
import '../../../../shared/util/widgets/appbar.dart';
import '../../../../shared/util/widgets/custom_containers.dart';
import '../../../../shared/util/widgets/custom_text_form_field.dart';
import '../../../../theme/custom_text_style.dart';
import '../../../env/utils/colors.dart';
import '../../../env/utils/string_resources.dart';

class Review extends StatefulWidget {
  const Review({super.key});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  bool isReview = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TedAppBar(
            elevation: 0,
            titleText: isReview
                ? StringResources.review
                : StringResources.payment_method,
            trailing: Container()),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
            child: Column(
              children: [
                isReview
                    ? Column(
                        children: [
                          CustomTextFormField(
                            headerText: "Reason for sending",
                            hintText: "Choose reason for sending",
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
                          20.verticalSpace,
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 20),
                            color: AppColors.white2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    GreyCirclesWithLines(
                                      circleRadius: 7.0,
                                      lineWidth: 2.5,
                                      circleColor: AppColors.grey[65]!,
                                      lineColor: AppColors.grey[65]!,
                                    ),
                                    20.horizontalSpace,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('You’re Sending'),
                                        20.verticalSpace,
                                        const Text('Recipient gets'),
                                        20.verticalSpace,
                                        const Text('Exchange rate'),
                                        20.verticalSpace,
                                        const Text('Transaction Fee'),
                                        20.verticalSpace,
                                        const Text('Total to pay'),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '\$=N 4200.00',
                                          style: CustomTextStyles
                                              .titleMediumBlack600
                                              .copyWith(),
                                        ),
                                        20.verticalSpace,
                                        Text(
                                          '8,500,000.73',
                                          style: CustomTextStyles
                                              .titleMediumBlack600
                                              .copyWith(),
                                        ),
                                        20.verticalSpace,
                                        Text(
                                          '\$1=N 1420.92',
                                          style: CustomTextStyles
                                              .titleMediumBlack600
                                              .copyWith(),
                                        ),
                                        20.verticalSpace,
                                        Text('FREE',
                                            style: CustomTextStyles
                                                .titleMediumBlack600
                                                .copyWith(
                                                    color:
                                                        AppColors.tedGreen2)),
                                        20.verticalSpace,
                                        Text(
                                          '\$4,500.00',
                                          style: CustomTextStyles
                                              .titleMediumBlack600
                                              .copyWith(),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                30.verticalSpace,
                                Center(
                                  child: AppButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    text: "Edit Amount",
                                    radius: 20.r,
                                    width: 300.w,
                                  ),
                                ),
                                20.verticalSpace,
                              ],
                            ),
                          ),
                          40.verticalSpace,
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 20),
                            color: AppColors.white2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        AssetResources.stepperIcon2),
                                    20.horizontalSpace,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('Recipient'),
                                        15.verticalSpace,
                                        const Text(''),
                                        20.verticalSpace,
                                        const Text('Delivery Method'),
                                        20.verticalSpace,
                                        const Text('Date & Time'),
                                        20.verticalSpace,
                                        const Text(
                                          'Change Recipient',
                                          style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.w500,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Temitayo Michael \nBabatunde',
                                          textDirection: TextDirection.ltr,
                                          textAlign: TextAlign.right,
                                          style: CustomTextStyles
                                              .titleMediumBlack600
                                              .copyWith(),
                                        ),
                                        53.verticalSpace,
                                        Text(
                                          'Bank Account NG',
                                          style: CustomTextStyles
                                              .titleMediumBlack600
                                              .copyWith(),
                                        ),
                                        28.verticalSpace,
                                        Text(
                                          '03-07-24 | 6:57PM',
                                          style: CustomTextStyles
                                              .titleMediumBlack600
                                              .copyWith(),
                                        ),
                                        55.verticalSpace
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          100.verticalSpace,
                          AppButton(
                            onPressed: () {
                              setState(() {
                                isReview = false;
                              });
                            },
                            text: "Confirm",
                            radius: 20.r,
                            width: 300.w,
                          ),
                        ],
                      )
                    : PaymentContainer(
                        onTap: () {
                          // addPaymentMethodSheet(context: context);
                          setState(() {
                            isReview = false;
                          });
                          PageNavigator(ctx: context)
                              .nextPage(page: const CardDetails());
                        },
                        imagePath: AssetResources.creditCard,
                        titleText: StringResources.debit_card,
                        subTitleText: StringResources.you_can_send_up_to,
                        icon: Icons.arrow_forward_ios,
                        isSvg: true,
                        scale: 1.7,
                      )
              ],
            ),
          ),
        ));
  }
}
