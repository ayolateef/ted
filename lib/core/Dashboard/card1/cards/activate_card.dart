import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tedfinance_mobile/core/Dashboard/kyc_verification.dart';
import 'package:tedfinance_mobile/shared/navigations/routes/navigation_service.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_containers.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_text_form_field.dart';

import '../../../../shared/util/asset_images.dart';
import '../../../../theme/custom_text_style.dart';
import '../../../env/utils/colors.dart';
import '../../../env/utils/string_resources.dart';
import 'enter_pin.dart';

class ActivateCard extends StatefulWidget {
  const ActivateCard({super.key});

  @override
  State<ActivateCard> createState() => _ActivateCardState();
}

class _ActivateCardState extends State<ActivateCard> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 20.0,),
          child: GeneralContainer(
            height: 550,
            vertical: 10.0,
            horizontal: 0.0,
            widget: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: SvgPicture.asset(AssetResources.shortLeftArrow,)
                    ),

                    30.horizontalSpace,
                    Text(
                      StringResources.activite_card,
                      style: CustomTextStyles.titleMedium18,
                    ),
                  ],
                ),
               10.verticalSpace,
               const BigPinkContainer(
                 text: StringResources.by_proceeding
               ),
                10.verticalSpace,
                CustomDropdownFormField(
                  headerText: "Source of funds",
                  hintText: "Select Source of funds",
                  currencies: const ["USD", "NGN"],
                  onChanged: (currency) {
                    // Do something with the selected currency
                  },
                ),
                20.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
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
                          const Text(''),
                          20.verticalSpace,
                          const Text('Rate'),
                          20.verticalSpace,
                          const Text('Fee'),
                          20.verticalSpace,
                          const Text('Amount in NGN'),
                          20.verticalSpace,
                          const Text(''),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            '',
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
                          Text(
                            '3 USD',
                            style: CustomTextStyles
                                .titleMediumBlack600
                                .copyWith(color:
                            AppColors.tedGreen2),
                          ),
                          20.verticalSpace,
                          Text('N 4,500.00',
                              style: CustomTextStyles
                                  .titleMediumBlack600
                                  .copyWith(
                                  )),
                          20.verticalSpace,
                          Text(
                            '',
                            style: CustomTextStyles
                                .titleMediumBlack600
                                .copyWith(),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                30.verticalSpace,
                AppButton(
                  onPressed: (){
                    PageNavigator(ctx: context).nextPage(page: const EnterPinVirtualSheet());
                  },
                  text: 'Continue',
                    radius: 30.r,
                  width: 350.w,
                )

              ],
            ),
          ),
        ));
  }
}
