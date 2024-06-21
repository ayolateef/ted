import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tedfinance_mobile/core/env/utils/string_resources.dart';
import 'package:tedfinance_mobile/shared/navigations/routes/navigation_service.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_containers.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';

import '../../../theme/custom_text_style.dart';
import '../../env/utils/colors.dart';
import 'invest_portfolio.dart';
import 'market_buy_sell.dart';

class StockDetailPage extends StatefulWidget {
  final Company company;

  const StockDetailPage({
    super.key,
    required this.company,

  });

  @override
  State<StockDetailPage> createState() => _StockDetailPageState();
}

class _StockDetailPageState extends State<StockDetailPage> {
  List<bool> isSelectedList = List.generate(5, (i) => false);

  @override
  void initState() {
    super.initState();
    isSelectedList = List.generate(5, (index) => index == 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },

                  child: SvgPicture.asset(AssetResources.longLeftArrow)),
              70.horizontalSpace,
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
              const Spacer(),
              SvgPicture.asset(AssetResources.blackSettingsIcon),
            ],
          ),
          Center(
            child: Text(
              '\$${widget.company.stockValue}',
              style: CustomTextStyles.titleLargeBlack.copyWith(fontSize: 32.sp),
            ),
          ),
          100.verticalSpace,
          SizedBox(
              height: 56.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return AnalysisContainer(
                    text: _getButtonText(index),
                    isSelected: isSelectedList[index],
                    onTap: () {
                      setState(() {
                        isSelectedList = List.generate(5, (i) => i == index);
                      });
                    },
                  );
                },
              )),
          10.verticalSpace,
          Text(
            'Company Profile',
            style: CustomTextStyles.titleLargeBlack.copyWith(fontSize: 22.sp),
          ),
          30.verticalSpace,
          Text(
            'About Company',
            style: CustomTextStyles.titleLargeBlack.copyWith(fontSize: 17.sp),
          ),
          20.verticalSpace,
          Text(
            StringResources.pt_bank,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 14.sp, height: 1.7),
          ),
          20.verticalSpace,
          Text(
            'Board of Directors',
            style: CustomTextStyles.titleLargeBlack.copyWith(fontSize: 17.sp),
          ),
          20.verticalSpace,
          Row(
            children: [
              Expanded(
                child: AppButton(
                  onPressed: () {
                    PageNavigator(ctx: context).nextPage(
                        page: MarketBuySellPage(
                          company: widget.company,
                        isFromSellButton: false,
                        ));
                  },
                  text: "Buy",
                  color: AppColors.tedGreen2,
                  height: 47,
                ),
              ),
              20.horizontalSpace,
              Expanded(
                child: AppButton(
                  onPressed: () {
                    PageNavigator(ctx: context).nextPage(
                        page: MarketBuySellPage(
                            company: widget.company,
                          isFromSellButton: true,

                        ));
                  },
                  text: "Sell",
                  color: AppColors.tedRedColor2,
                  height: 47,
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}

String _getButtonText(int index) {
  switch (index) {
    case 0:
      return 'Analysis';
    case 1:
      return 'News';
    case 2:
      return 'Orderbook';
    case 3:
      return 'Key Statistics';
    case 4:
      return 'Company Profile';
    default:
      return '';
  }
}
