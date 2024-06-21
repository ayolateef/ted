import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tedfinance_mobile/core/Dashboard/Investment/reason_for_investment.dart';
import 'package:tedfinance_mobile/shared/navigations/routes/navigation_service.dart';

import '../../../shared/util/asset_images.dart';
import '../../../shared/util/widgets/custom_elevated_button.dart';
import '../../env/utils/colors.dart';

class InvestmentPage extends StatefulWidget {
  const InvestmentPage({super.key});

  @override
  State<InvestmentPage> createState() => _InvestmentPageState();
}

class _InvestmentPageState extends State<InvestmentPage> {
  int currentPage = 0;
  final PageController _pageController = PageController();

  void _setUpPageController() {
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!.round();
      });
    });
  }

  final List<InvestmentPageContent> _pages = [
    const InvestmentPageContent(
      image: AssetImage(AssetResources.investmentImage1),
      icons: [

        AssetResources.pumaIcon,
        AssetResources.adidasIcon,
        AssetResources.thirdIcon,
        AssetResources.forthIcon
      ],
      bigText: "",
      subText:
          "The best platform to invest in  international\nstocks effortlessly",
      buttonText: "Get Started",
    ),
    const InvestmentPageContent(
      image: AssetImage(AssetResources.investmentImage2),
      icons: [
        AssetResources.pumaIcon,
        AssetResources.adidasIcon,
        AssetResources.thirdIcon,
        AssetResources.forthIcon
      ],
      bigText: "Get Better Returns",
      buttonText: "Get Started",
      subText:
          'Invest in the word’s top leading brands &\nunlock amazing returns of investment',
    ),
    const InvestmentPageContent(
      image: AssetImage(
          AssetResources.investmentImage3),
      icons: [
        // List of horizontal icons for page 3
        AssetResources.pumaIcon,
        AssetResources.adidasIcon,
        AssetResources.thirdIcon,
        AssetResources.forthIcon
      ],
      bigText: "No Spreads",
      subText:
          'No spreads, all your trades execute at the\ninternational best bid & offer.',
      buttonText: "Get Started",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _setUpPageController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          children: _pages.map((pageContent) => _buildPageContent(pageContent)).toList()
          // onPageChanged: (index) => setState(() => currentPage = index),
          // itemCount: _pages.length,
          // itemBuilder: (context, index) {
          //   final pageContent = _pages[index];
          //   return _buildPageContent(pageContent);
          // },
        ),
      ),
    );
  }

  Widget _buildPageContent(InvestmentPageContent pageContent) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Large Image
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Image(
              image: pageContent.image,
                      ),
          ),

          // Horizontal Icon List
          SizedBox(
            height: 100.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: pageContent.icons.length,
              separatorBuilder: (context, index) => SizedBox(width: 10.h),
              itemBuilder: (context, index) {
                final iconAsset = pageContent.icons[index];
                return SvgPicture.asset(iconAsset,
                    height: 50.h);
              },
            ),
          ),

          // Big Text
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                currentPage == 0
                    ? RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Welcome to ',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 36.sp,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            TextSpan(
                              text: 'Ted Stock',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 36.sp,
                                    color: AppColors.tedGradientColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      )
                    : Text(pageContent.bigText,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(fontSize: 36.sp),
                        )),
                Text(pageContent.subText,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: 16.sp),
                    )),
              ],
            ),
          ),

          // Get Started Button
          Center(
            child: AppButton(
              onPressed: () {

                if(_pageController.page?.round() == _pages.length -1 ){
                  PageNavigator(ctx: context).nextPage(page: const ReasonForInvestment());
                }
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );

              },
              text: pageContent.buttonText,
            ),
          ),
          20.verticalSpace,
        ],
      ),
    );
  }
}

class InvestmentPageContent {
  final AssetImage image;
  final List<String> icons;
  final String bigText;
  final String subText;
  final String buttonText;

  const InvestmentPageContent({
    required this.image,
    required this.icons,
    required this.bigText,
    required this.buttonText,
    required this.subText,
  });
}
