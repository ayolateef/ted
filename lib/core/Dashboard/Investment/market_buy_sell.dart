import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tedfinance_mobile/core/Dashboard/drawer/bottom_sheet/root.dart';
import 'package:tedfinance_mobile/core/env/utils/string_resources.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_containers.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_text_form_field.dart';
import 'package:tedfinance_mobile/theme/custom_text_style.dart';

import '../../env/utils/colors.dart';
import 'invest_portfolio.dart';

class MarketBuySellPage extends StatefulWidget {
  final Company company;
  final bool isFromSellButton;
  const MarketBuySellPage({super.key,
    required this.company,this.isFromSellButton = false,});

  @override
  State<MarketBuySellPage> createState() => _MarketBuySellPageState();
}

class _MarketBuySellPageState extends State<MarketBuySellPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 30.0),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: SvgPicture.asset(AssetResources.shortLeftArrow)),
              150.horizontalSpace,
              Text( widget.isFromSellButton
                  ? StringResources.market_sell
                  :StringResources.market_buy,
                  style: CustomTextStyles.titleMedium18.copyWith(
                      color: widget.isFromSellButton
                          ? AppColors.tedRedText
                          : AppColors.tedGreen2,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp))
            ],
          ),
          30.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(widget.company.logo),
              20.horizontalSpace,
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: widget.company.name,
                      style: CustomTextStyles.titleMedium18
                          .copyWith(color: Colors.black),
                    ),
                    TextSpan(
                      text: ' (${widget.company.limitedName})',
                      style: CustomTextStyles.titleMedium18.copyWith(
                        color: AppColors.tedGreyLongText,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          40.verticalSpace,
          Center(
            child: Text(
              '\$${widget.company.stockValue}',
              style:
                  CustomTextStyles.titleLargeGray500.copyWith(fontSize: 52.sp),
            ),
          ),
          Text(widget.company.percentageGrowth.toString(),
              style: CustomTextStyles.titleMediumGray500),
          20.verticalSpace,
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                const Column(
                  children: [
                    BuildCircle(),
                    BuildLine(),
                    BuildCircle(),
                    BuildLine(),
                    BuildCircle(),
                    BuildLine(),
                    BuildCircle(),
                    BuildLine(),
                    BuildCircle(),
                  ],
                ),
                20.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Shares'),
                    26.verticalSpace,
                    const Text('Price per share'),
                    26.verticalSpace,
                    const Text('Buying power'),
                    26.verticalSpace,
                    const Text('Broker fee'),
                    26.verticalSpace,
                    const Text("Exchange fee")
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('0', style: CustomTextStyles.titleMedium18),
                    22.verticalSpace,
                    Text('\$1.10', style: CustomTextStyles.titleMedium18),
                    22.verticalSpace,
                    Text('\$0.00', style: CustomTextStyles.titleMedium18),
                    22.verticalSpace,
                    Text('\$0.00', style: CustomTextStyles.titleMedium18),
                    22.verticalSpace,
                    Text("FREE",
                        style: CustomTextStyles.titleMedium18
                            .copyWith(color: AppColors.tedGreen2))
                  ],
                )
              ],
            ),
          ),
          40.verticalSpace,
          widget.isFromSellButton ? Container()
              : const CustomDropdownFormField(
              headerText: "Source of Funds",
              hintText: "Select Sources of funds",
              currencies: ["USD", "NGN"]),
          40.verticalSpace,
          AppButton(
            onPressed: (){
              enterPinSheet(
                  context: context,
                isFromSellButton: widget.isFromSellButton,

              );
            },
            text: widget.isFromSellButton ? "sell" : 'buy',
            radius: 30.r,

          )
        ],
      ),
    ));
  }
}
