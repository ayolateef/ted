import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tedfinance_mobile/core/env/utils/colors.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/appbar.dart';
import 'package:tedfinance_mobile/theme/custom_text_style.dart';

import 'Investment/invest.dart';
import 'MultiAccount/multi_account.dart';
import 'body_dashboard.dart';
import 'bottomNav/bottom_navbar.dart';
import 'card1/send/send_money.dart';
import 'drawer/drawer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 2;
  bool isDrawerOpen = false;

  void _onNavItemTapped(int index) {
      switch (index) {
        case 0:
          isDrawerOpen = index == 0 ? !isDrawerOpen : false;
          break;
        case 1:
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MultiAccountPage()));
          break;
        case 2:
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DashboardScreen())); // Assuming the third icon is for the home page
          break;
        case 3:
          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const SendMoney()));
          break;
        case 4:
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const InvestmentPage()));
          break;
        default:
          setState(() {
            _selectedIndex = index;
          });
      }


    // setState(() {
    //   _selectedIndex = index;
    //   // Toggle drawer state when Overview icon is selected

    // });
  }

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
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemSelected: _onNavItemTapped,
        ),
        drawer: buildDrawer(context),
        body: buildBody(context));
  }

}


