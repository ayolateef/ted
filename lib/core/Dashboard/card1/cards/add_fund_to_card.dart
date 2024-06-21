

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';

import '../../../../shared/navigations/routes/navigation_service.dart';
import '../../../../shared/util/widgets/appbar.dart';
import '../../../../shared/util/widgets/custom_containers.dart';
import '../../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../../shared/util/widgets/custom_text_form_field.dart';
import '../../../../theme/custom_text_style.dart';
import '../../../env/utils/colors.dart';
import '../../../env/utils/string_resources.dart';
import 'enter_pin.dart';

class AddFundToCard extends StatefulWidget {
  const AddFundToCard({super.key});

  @override
  State<AddFundToCard> createState() => _AddFundToCardState();
}

class _AddFundToCardState extends State<AddFundToCard> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  TedAppBar(
        elevation: 0,
        titleWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text( StringResources.add_funds_to_card, style: CustomTextStyles.titleMedium18,),
            5.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text("USD 00.00", style: CustomTextStyles.bodySmallBlack900 ),
                5.horizontalSpace,
                SvgPicture.asset(AssetResources.dropdownIcon, height: 10.h, width: 10.w,)
              ],
            )
          ],
        ),
      ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 20.0,),
            child: Column(
              children: [
                10.verticalSpace,
                10.verticalSpace,
                CustomDropdownFormField(
                  headerText: "Source of funds",
                  hintText: "Select Cable",
                  currencies: const ["USD", "NGN"],
                  onChanged: (currency) {
                    // Do something with the selected currency
                  },
                ),
                20.verticalSpace,
                const CustomTextFormField(
                  headerText: "Amount",
                  hintText: "USD 0.00",
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
                            'FREE',
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
        ),

    );
  }
}
