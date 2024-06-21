import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tedfinance_mobile/core/Dashboard/card1/report/exchange_currency.dart';
import 'package:tedfinance_mobile/shared/navigations/routes/navigation_service.dart';

import '../../shared/util/asset_images.dart';
import '../../shared/util/cards.dart';
import '../../shared/util/widgets/custom_containers.dart';
import '../../theme/custom_text_style.dart';
import '../env/utils/colors.dart';
import 'card1/add_fund/add_fund_to_wallet.dart';
import 'card1/cards/virtual_cards.dart';
import 'card1/report/report_page.dart';
import 'card1/send/send_money.dart';

SingleChildScrollView buildBody(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: PurpleCardWithIcons(
                widget: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            AssetResources.walletBalIcon,
                          ),
                          10.horizontalSpace,
                          Text('Your wallet Balance',
                              style: CustomTextStyles.titleSmallffffffff),
                          const Spacer(),
                          SvgPicture.asset(
                            AssetResources.$Icon,
                            height: 30.h,
                          ),
                        ],
                      ),
                      15.verticalSpace,
                      Row(
                        children: [
                          SvgPicture.asset(AssetResources.usFlagIcon),
                          SvgPicture.asset(AssetResources.scrollIcon),
                          10.horizontalSpace,
                          Text( "\$ 0.00",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 35.sp,
                                color: AppColors.white
                              )
                            )

                          ),
                          10.horizontalSpace,
                          SvgPicture.asset(AssetResources.eyeIcon),
                          SvgPicture.asset(AssetResources.threeDotIcon),
                          15.horizontalSpace,
                           AddFundContainer(
                            onTap: (){
                              PageNavigator(ctx: context).nextPage(page: const AddFundToWallet());
                            },
                          ),
                        ],
                      ),
                      35.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           WhiteCircularIcons(
                            onTap: (){
                              PageNavigator(ctx: context).nextPage(page: const VirtualCards());
                            },
                            circleSvgIcon: AssetResources.creditCard,
                            circleText: 'Card',
                          ),
                          10.horizontalSpace,
                           WhiteCircularIcons(
                            onTap: (){
                              PageNavigator(ctx: context).nextPage(page: const ExchangeCurrency());
                            },
                            circleSvgIcon: AssetResources.currencyIcon,
                            circleText: 'Exchange',
                          ),
                          10.horizontalSpace,
                           WhiteCircularIcons(
                            onTap: (){
                              PageNavigator(ctx: context).nextPage(page: const SendMoney());
                            },
                            circleSvgIcon: AssetResources.sendIcon,
                            circleText: 'Send',
                          ),
                          10.horizontalSpace,
                          const WhiteCircularIcons(
                            circleSvgIcon: AssetResources.questionIcon,
                            circleText: 'Request',
                          ),
                          10.horizontalSpace,
                          const WhiteCircularIcons(
                            circleSvgIcon: AssetResources.transferIcon,
                            circleText: 'Transfer',
                          ),
                          10.horizontalSpace,
                           WhiteCircularIcons(
                            onTap: (){
                              PageNavigator(ctx: context).nextPage(page: const ReportPage());
                            },
                            padding: 0.0,
                            circleSvgIcon: AssetResources.reportIcon2,
                            circleText: 'Report',
                             scale: 1.0,
                                                     ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: -MediaQuery.of(context).size.width / 4,
              top: -5,
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width / 2.8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryButtonColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        10.verticalSpace,
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 8.0),
          child: PurpleCardWithIcons(
            cardColor: AppColors.white,
            widget: Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Other Services',
                    style: CustomTextStyles.bodySmallBlack900
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  20.verticalSpace,
                  SizedBox(
                    height: 70.0.h, // Provide a fixed height here
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
                        const RectangularIcons(
                          circleSvgIcon: AssetResources.balanceIcon,
                          circleText: 'Balance',
                        ),
                        SizedBox(width: 18.w),
                        RectangularIcons(
                          circleColor:
                          AppColors.tedLightPink.withOpacity(0.7),
                          circleSvgIcon: AssetResources.virtualCardIcon,
                          circleText: 'Virtual Card',
                        ),
                        SizedBox(width: 18.w),
                        const RectangularIcons(
                          circleSvgIcon: AssetResources.physicalCardIcon,
                          circleText: 'Physical Card',
                        ),
                        SizedBox(width: 18.w),
                        RectangularIcons(
                          circleColor:
                          AppColors.tedLightPink.withOpacity(0.7),
                          circleSvgIcon: AssetResources.cryptoIcon,
                          circleText: 'Crypto',
                        ),
                        SizedBox(width: 18.w),
                        const RectangularIcons(
                          circleSvgIcon: AssetResources.currencyIcon,
                          circleText: 'Exchange',
                        ),
                      ],
                    ),
                  ),
                  35.verticalSpace,
                  SizedBox(
                    height: 70.0.h, // Provide a fixed height here
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
                        RectangularIcons(
                          circleColor:
                          AppColors.tedLightPink.withOpacity(0.7),
                          circleSvgIcon: AssetResources.settingsIcon,
                          circleText: 'Settings',
                        ),
                        SizedBox(width: 18.w),
                        const RectangularIcons(
                          circleSvgIcon: AssetResources.accountIcon,
                          circleText: 'Account Details',
                        ),
                        SizedBox(width: 18.w),
                        RectangularIcons(
                          circleColor:
                          AppColors.tedLightPink.withOpacity(0.7),
                          circleSvgIcon: AssetResources.investmentIcon,
                          circleText: 'Investment',
                        ),
                        SizedBox(width: 18.w),
                        const RectangularIcons(
                          circleSvgIcon: AssetResources.kycIcon,
                          circleText: 'KYC',
                        ),
                        SizedBox(width: 18.w),
                        RectangularIcons(
                          circleColor:
                          AppColors.tedLightPink.withOpacity(0.7),
                          circleSvgIcon: AssetResources.chatTedIcon,
                          circleText: 'Chat Ted',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recent Activities',
                style: CustomTextStyles.bodySmallBlack900
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              10.verticalSpace,
              SizedBox(
                height: 300.h,
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const CustomCard(
                      image: AssetResources
                          .listTileImage2, // Assuming listTileImage is a function that returns the asset path
                      title: 'You Converted',
                      subtitle: '500 USD to 800,000 NGN',
                      trailingText: '800,000.00',
                      trailingSubtitle: '25-01-2024 6:00pm',
                    );
                  },
                ),
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ],
    ),
  );
}

