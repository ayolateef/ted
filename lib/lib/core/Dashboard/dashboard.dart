import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tedfinance_mobile/core/env/utils/colors.dart';
import 'package:tedfinance_mobile/providers/auth_provider.dart';
import 'package:tedfinance_mobile/providers/dashboard_provider.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/appbar.dart';
import 'package:tedfinance_mobile/theme/custom_text_style.dart';

import '../../shared/models/auth_models/user.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  int _selectedIndex = 1;
  bool isDrawerOpen = false;
  late DashboardProvider dashboardProvider;
  late AuthenticationProvider authenticationProvider;
  late PageController _pageController;
  User? user;

  void _onNavItemTapped(int index) {
    if (index == 0) {
      _openDrawer();
    } else {
      _pageController.jumpToPage(index - 1);
      // .animateToPage(index   ,
      //     duration: const Duration(milliseconds: 100), curve: Curves.bounceIn);
      setState(() {
        _selectedIndex = index - 1;
      });
    }
  }
  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex );
    // Future.microtask(() async {
    //   Provider.of<AuthenticationProvider>(context, listen: false)
    //       .fetchUser()
    //       .then((value) {
    //     setState(() {
    //       user = value;
    //     });
    //   });
    // });
  }
  Future<bool> onBackPress(context, bool value) {
    return showDialog <bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Do you wish to exit?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => {Navigator.pop(context, false)},
            ),
            TextButton(
                onPressed: () => {Navigator.pop(context, true)},
                child: Text('Exit'))
          ],
        )
    ) as Future<bool> ;
  }
  @override
  Widget build(BuildContext context) {
    authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);

    user = authenticationProvider.user;
    bool showAppBar = _selectedIndex == 1;

    return  PopScope(
      onPopInvoked: (value) => onBackPress(context, value),
      canPop: false,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: showAppBar
            ? TedAppBar(
                leadingIcon: Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: Image.asset(AssetResources.welcomeBackImage),
                ),
                titleWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello ${user?.name?.substring(0, user?.name?.indexOf(' '))}',
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
              )
            : null,
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex + 1,
          onItemSelected: _onNavItemTapped,
        ),
        drawer: const TedDrawer(),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children:  const [
            // TedDrawer(),
            MultiAccountPage(),
            DashboardBody(),
            SendMoney(),
            InvestmentPage(),
          ],
        ),
      ),
    );
  }
}

// Widget build(BuildContext context) {
//
//   return Scaffold(
//       appBar: TedAppBar(
//         leadingIcon: Container(
//           margin: const EdgeInsets.only(left: 10.0),
//           child: Image.asset(AssetResources.welcomeBackImage),
//         ),
//         titleWidget: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Hello ${user?.name?.substring(0, user?.name?.indexOf(' '))}',
//               style: CustomTextStyles.titleSmallBlack400
//                   .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400),
//             ),
//             2.verticalSpace,
//             Text('Welcome to TedFinance!',
//                 style: CustomTextStyles.titleSmallBlack400),
//           ],
//         ),
//         centerTitle: false,
//         trailing: Container(
//             padding: EdgeInsets.symmetric(vertical: 3.h),
//             width: 49.w,
//             height: 29.h,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12.r),
//                 border: Border.all(color: AppColors.tedLightGrey)),
//             child: SvgPicture.asset(AssetResources.notificationIcon)),
//       ),
//       bottomNavigationBar: CustomBottomNavigationBar(
//         selectedIndex: _selectedIndex,
//         onItemSelected: _onNavItemTapped,
//       ),
//       drawer: buildDrawer(context),
//       body: PageView(
//           controller: _pageController,
//           children: const [
//             DashboardBody(),
//             MultiAccountPage(),
//             //DashboardScreen(),
//
//             SendMoney(),
//             InvestmentPage(),
//
//           ]
//       ));
// }
