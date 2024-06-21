import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tedfinance_mobile/core/Dashboard/Investment/stock_details.dart';
import 'package:tedfinance_mobile/core/env/utils/string_resources.dart';
import 'package:tedfinance_mobile/shared/util/widgets/appbar.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_drop_down.dart';
import '../../../shared/navigations/routes/navigation_service.dart';
import '../../../shared/util/asset_images.dart';
import '../../../shared/util/widgets/custom_containers.dart';
import '../../../theme/custom_text_style.dart';
import '../../env/utils/colors.dart';
import '../card1/add_fund/add_fund_to_wallet.dart';

class InvestmentPortfolio extends StatefulWidget {
  const InvestmentPortfolio({super.key});

  @override
  State<InvestmentPortfolio> createState() => _InvestmentPortfolioState();
}

class _InvestmentPortfolioState extends State<InvestmentPortfolio> {
  List<Company> watchlistCompanies = [
    Company(
      logo: AssetResources.portAppleIcon2,
      name: 'Apple',
      limitedName: 'Apple Inc.',
      stockValue: 100.0,
      percentageGrowth: 5.0,
      stockData: [10.0, 20.0, 30.0, 40.0, 50.0],
    ),
    Company(
      logo: AssetResources.portAppleIcon2,
      name: 'Netflix',
      limitedName: 'Netflix Ent.',
      stockValue: 200.0,
      percentageGrowth: -2.0,
      stockData: [10.0, 20.0, 30.0, 40.0, 50.0],
    ),
    Company(
      logo: AssetResources.portAppleIcon2,
      name: 'SPOT',
      limitedName: 'Microsoft Corp.',
      stockValue: 200.0,
      percentageGrowth: -2.0,
      stockData: [10.0, 20.0, 30.0, 40.0, 50.0],
    ),
    Company(
      logo: AssetResources.portAppleIcon2,
      name: 'MSFT',
      limitedName: 'Microsoft Corp.',
      stockValue: 200.0,
      percentageGrowth: -2.0,
      stockData: [10.0, 20.0, 30.0, 40.0, 50.0],
    ),
    Company(
      logo: AssetResources.portAppleIcon2,
      name: 'GOOGLE',
      limitedName: 'Alphabet Inc.',
      stockValue: 200.0,
      percentageGrowth: -2.0,
      stockData: [10.0, 20.0, 30.0, 40.0, 50.0],
    ),
    Company(
      logo: AssetResources.portAppleIcon2,
      name: 'META',
      limitedName: 'Meta Inc.',
      stockValue: 200.0,
      percentageGrowth: -2.0,
      stockData: [10.0, 20.0, 30.0, 40.0, 50.0],
    ),
    Company(
      logo: AssetResources.portAppleIcon2,
      name: 'Amazon',
      limitedName: 'Amazon Inc.',
      stockValue: 200.0,
      percentageGrowth: -2.0,
      stockData: [10.0, 20.0, 30.0, 40.0, 50.0],
    ),
    Company(
      logo: AssetResources.portAppleIcon2,
      name: 'Tesla',
      limitedName: 'Tesla Inc.',
      stockValue: 200.0,
      percentageGrowth: -2.0,
      stockData: [10.0, 20.0, 30.0, 40.0, 50.0],
    ),
    Company(
      logo: AssetResources.portAppleIcon2,
      name: 'Tesla',
      limitedName: 'Tesla Inc.',
      stockValue: 200.0,
      percentageGrowth: -2.0,
      stockData: [10.0, 20.0, 30.0, 40.0, 50.0],
    ),
    Company(
      logo: AssetResources.portAppleIcon2,
      name: 'Disney',
      limitedName: 'Disney Inc.',
      stockValue: 200.0,
      percentageGrowth: -2.0,
      stockData: [10.0, 20.0, 30.0, 40.0, 50.0],
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TedAppBar(
          leadingIcon: Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: Image.asset(AssetResources.welcomeBackImage),
          ),
          titleWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello Lateef,',
                style: CustomTextStyles.titleSmallBlack400
                    .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400),
              ),
              2.verticalSpace,
              Text('Welcome to TedFinance!',
                  style: CustomTextStyles.titleSmallBlack400),
            ],
          ),
          centerTitle: false,
          trailing: Container(
              padding: EdgeInsets.symmetric(vertical: 3.h),
              width: 49.w,
              height: 29.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.tedLightGrey)),
              child: SvgPicture.asset(AssetResources.notificationIcon)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
                  decoration: BoxDecoration(
                      color: AppColors.lightPinkColor,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(StringResources.stock_gains,
                              style: CustomTextStyles.titleSmallBlack400
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.grey[11])),
                          Spacer(),
                          Container(
                            width: 150.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: CustomDropDown(
                              //width: 200,
                              items: const [
                                "This week",
                                "Next week",
                                "This month",
                                "Next month"
                              ],
                              initialValue: "This week",
                              onChanged: (value) {},
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              fillColor: Colors.transparent,
                            ),
                          )
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 22.sp,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600)),
                          children: [
                            const TextSpan(
                              text: '\$25,901.0.',
                            ),
                            TextSpan(
                                text: '41',
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 16.sp,
                                        color: AppColors.black.withOpacity(0.5),
                                        fontWeight: FontWeight.w600))),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          SvgPicture.asset(AssetResources.waveIcon),
                          Positioned(
                            top: 5,
                            left: 20,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  AssetResources.threeDotIcon,
                                  height: 15,
                                  width: 10,
                                ),
                                15.horizontalSpace,
                                AddFundContainer(
                                  onTap: () {
                                    PageNavigator(ctx: context).nextPage(
                                        page: const AddFundToWallet());
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                20.verticalSpace,
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Text(
                        'Portfolio',
                        style: CustomTextStyles.titleMedium18
                            .copyWith(fontSize: 16.sp),
                      ),
                      8.horizontalSpace,
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.black,
                        size: 18.sp,
                      )
                    ],
                  ),
                ),
                30.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: PortfolioContainer(
                        portColor: AppColors.tedLightPink,
                        logoImage: AssetResources.portAppleIcon2,
                        firstText: "APPL",
                        secondText: "Apple Inc.",
                        thirdText: "198.24",
                        lastText: "2.5%",
                      ),
                    ),
                    20.horizontalSpace,
                    const Expanded(
                      child: PortfolioContainer(
                        portColor: AppColors.tedVeryLightGreen,
                        logoImage: AssetResources.lyftIcon,
                        firstText: "LYFT",
                        secondText: "lyft Inc.",
                        thirdText: "418.04",
                        lastText: "2.5%",
                      ),
                    )
                  ],
                ),
                10.verticalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Watchlist Title
                    Row(
                      children: [
                        Text(
                          'Watchlist',
                          style: CustomTextStyles.titleMedium18
                              .copyWith(fontSize: 16.sp),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColors.black,
                          size: 18.sp,
                        )
                      ],
                    ),
                    10.verticalSpace,
                    SizedBox(
                      height: 300,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: watchlistCompanies.length,
                        itemBuilder: (context, index) {
                          final company = watchlistCompanies[index];
                          return GestureDetector(
                            onTap: () {
                              PageNavigator(ctx: context).nextPage(
                                  page: StockDetailPage(company: company));
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  company.logo,
                                  width: 40.sp,
                                  height: 40.sp,
                                ),
                                20.horizontalSpace,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      company.name,
                                      style: CustomTextStyles.titleMedium18,
                                    ),
                                    Text(
                                      company.limitedName,
                                      style: CustomTextStyles.bodySmallGray800,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 100
                                      .sp, // Adjust the width according to your needs
                                  height: 50.sp,
                                  child: Sparkline(
                                    data: company.stockData ?? [],
                                    lineColor: company.percentageGrowth > 0
                                        ? Colors.green
                                        : Colors.red,
                                    lineWidth: 2,
                                    pointSize: 0,
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        '\$${company.stockValue}',
                                        style: CustomTextStyles.titleMedium18,
                                      ),
                                      SizedBox(width: 8.sp),
                                      company.percentageGrowth > 0
                                          ? const Icon(
                                              Icons.arrow_upward,
                                              color: Colors.green,
                                            )
                                          : const Icon(
                                              Icons.arrow_downward,
                                              color: Colors.red,
                                            ),
                                      Text(
                                        '${company.percentageGrowth}%',
                                        style: company.percentageGrowth > 0
                                            ? CustomTextStyles.bodySmallGray800
                                                .copyWith(color: Colors.green)
                                            : CustomTextStyles.bodySmallGray800
                                                .copyWith(color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16.sp),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return 15.verticalSpace;
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class Company {
  final String logo;
  final String name;
  final String limitedName;
  final double stockValue;
  final double percentageGrowth;
  final List<double> stockData;

  Company({
    required this.logo,
    required this.name,
    required this.limitedName,
    required this.stockValue,
    required this.percentageGrowth,
    required this.stockData,
  });
}

class PortfolioContainer extends StatelessWidget {
  final Color? portColor;
  final String? logoImage;
  final String? firstText;
  final String? secondText;
  final String? thirdText;
  final String? lastText;

  const PortfolioContainer({
    super.key,
    this.portColor,
    this.logoImage,
    this.firstText,
    this.secondText,
    this.lastText,
    this.thirdText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      decoration: BoxDecoration(
          color: portColor ?? AppColors.tedLightPink,
          borderRadius: BorderRadius.circular(10.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(logoImage ?? ""),
              10.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    firstText ?? "",
                    style: CustomTextStyles.titleMedium18,
                  ),
                  // 10.verticalSpace,
                  Text(
                    secondText ?? "",
                    style: CustomTextStyles.bodySmallGray500,
                  ),
                ],
              )
            ],
          ),
          8.verticalSpace,
          Row(
            children: [
              Text(
                thirdText ?? "",
                style: CustomTextStyles.titleMedium18,
              ),
              Spacer(),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      color: AppColors.tedLightGreen2,
                      size: 15.sp,
                    ),
                    Text(
                      lastText ?? '',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: AppColors.tedLightGreen2,
                        fontSize: 12.sp,
                      )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
