import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tedfinance_mobile/core/env/utils/string_resources.dart';
import 'package:tedfinance_mobile/shared/navigations/routes/navigation_service.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';
import 'package:tedfinance_mobile/theme/custom_text_style.dart';

import '../../../../../shared/util/widgets/custom_containers.dart';
import '../../../../env/utils/colors.dart';
import '../../../Investment/invest_portfolio.dart';

class ExchangeSuccessfulSheet extends StatelessWidget {
  const ExchangeSuccessfulSheet({super.key});

  @override
  Widget build(BuildContext context) {
    const gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xffDA5ED8), Color(0xffB854B7), Colors.black],
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 25.h),
      child:  Container(
        color: AppColors.white2,
        height: 450,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            40.verticalSpace,
            SvgPicture.asset(AssetResources.exchangeSuccessful2),
            20.verticalSpace,

            ShaderMask(
              shaderCallback: (Rect bounds) {
                return gradient.createShader(bounds);
              },
              blendMode: BlendMode.srcIn,
              child: const Text(
                StringResources.exchange_successful,
                 style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            ),
          20.verticalSpace,
        RichText(
          text: const TextSpan(
            style: TextStyle(
              color: Colors.black, // Default text color
            ),
            children: [
              TextSpan(
                text: 'You have exchanged ',
              ),
              TextSpan(
                text: '\$100',
                style: TextStyle(
                  color: Colors.purple, // Purple color for $100
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: ' to ',
              ),
              TextSpan(
                text: 'N120,000',
                style: TextStyle(
                  color: Colors.purple, // Purple color for N120,000
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: ' successfully.',
              ),
            ],
          ),
        ),
            40.verticalSpace,
            AppButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              text: 'Back Dashboard',
              radius: 20.r,
            )
          ],
        ),
      ),
    );
  }
}



class BuySuccessfulSheet extends StatelessWidget {
  final bool? isFromSellButton;
  const BuySuccessfulSheet({super.key, this.isFromSellButton ,});

  @override
  Widget build(BuildContext context) {
    const gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xffDA5ED8), Color(0xffB854B7), Colors.black],
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 25.h),
      child:  ClipPath(
        clipper: MyTopClipper(),
        child: Container(
          color: AppColors.white2,
          height: 550,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              40.verticalSpace,
              Image.asset(AssetResources.buyImage2),
              20.verticalSpace,

              isFromSellButton == true
                  ? Text(
                StringResources.sell_successfull,
                style: CustomTextStyles.titleMedium18.copyWith(
                  color: AppColors.tedRedText,
                  fontWeight: FontWeight.w600,
                  fontSize: 25.sp,
                ),
              )
                  : ShaderMask(
                shaderCallback: (Rect bounds) {
                  return gradient.createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
                child: Text(
                  StringResources.market_buy,
                  style: CustomTextStyles.titleMedium18.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              20.verticalSpace,
              RichText(
                textAlign: TextAlign.center,
                text:  TextSpan(
                  style:  TextStyle(
                    color: Colors.black,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w400
                  ),
                  children: [
                    const TextSpan(
                      text: 'you have successfully bought a share\n',
                    ),
                    const TextSpan(
                      text: 'of ',
                    ),
                     TextSpan(
                      text: '\$100 ',
                      style: TextStyle(
                        color:isFromSellButton == true
                        ? AppColors.tedRedText
                        : AppColors.tedPurpleText,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const TextSpan(
                      text: 'from ',
                    ),
                    TextSpan(
                      text: 'SPORTIFY',
                      style: TextStyle(
                        color:isFromSellButton == true
                      ? AppColors.tedRedText
                          : AppColors.tedPurpleText, // Purple color for N120,000

                      ),
                    ),
                  ],
                ),
              ),
              40.verticalSpace,
              AppButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  PageNavigator(ctx: context).nextPage(page: const InvestmentPortfolio());
                },
                text: 'Done',
                radius: 20.r,
                color: isFromSellButton== true ? AppColors.tedRed : AppColors.primaryColor
              )
            ],
          ),
        ),
      ),
    );
  }
}