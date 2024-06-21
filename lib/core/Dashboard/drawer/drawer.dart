import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tedfinance_mobile/core/Dashboard/drawer/pay_bills/pay_bills.dart';
import 'package:tedfinance_mobile/core/Dashboard/drawer/settings/settings_page.dart';
import 'package:tedfinance_mobile/core/Dashboard/kyc_identity.dart';
import 'package:tedfinance_mobile/shared/navigations/routes/navigation_service.dart';
import '../../../shared/util/asset_images.dart';
import '../../../theme/custom_text_style.dart';
import '../../env/utils/colors.dart';

Widget buildDrawer(BuildContext context) {
  return Drawer(
    width: 235.w,
    backgroundColor: AppColors.primaryColor,
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
            margin: EdgeInsets.only(top: 60.h, bottom: 25.h),
            child: SvgPicture.asset(AssetResources.tedLogo)),
        const DrawerWhiteContainer(
          svgIcon: AssetResources.dashboardIcon,
          drawerText: 'Dashboard',
        ),
         DrawerWhiteContainer(
          onTap: (){
            PageNavigator(ctx: context).nextPage(page: const KYCIdentity());
          },
          svgIcon: AssetResources.kycDashboardIcon,
          drawerText: 'KYC Verification',
        ),
        const DrawerWhiteContainer(
          svgIcon: AssetResources.transferIcon,
          drawerText: 'Transfer',
        ),
        const DrawerWhiteContainer(
          svgIcon: AssetResources.sendIcon,
          drawerText: 'Send Money',
        ),
         DrawerWhiteContainer(
          onTap: (){
            PageNavigator(ctx: context).nextPage(page: const PayBills());
          },
          svgIcon: AssetResources.payBillsIcon,
          drawerText: 'Pay Bills',
        ),
        const DrawerWhiteContainer(
          svgIcon: AssetResources.exchangeIcon,
          drawerText: 'Exchange',
        ),
        const DrawerWhiteContainer(
          svgIcon: AssetResources.requestIcon,
          drawerText: 'Request Payment',
        ),
        const DrawerWhiteContainer(
          svgIcon: AssetResources.virtualIcon,
          drawerText: 'Virtual Cards',
        ),
        const DrawerWhiteContainer(
          svgIcon: AssetResources.transReportIcon,
          drawerText: 'Transaction Reports',
        ),
        const DrawerWhiteContainer(
          svgIcon: AssetResources.exchangeIcon,
          drawerText: 'Exchange',
        ),
         DrawerWhiteContainer(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsProfilePage())

            );
            //Navigator.pop(context);
          },
          svgIcon: AssetResources.settingsIcon,
          drawerText: 'Settings',
        ),
        const DrawerWhiteContainer(
          svgIcon: AssetResources.chatTedDashIcon,
          drawerText: 'Chat Ted',
        ),
        30.verticalSpace,
        DrawerWhiteContainer(
          drawerContainerColor: Colors.transparent,
          svgIcon: AssetResources.signOutIcon,
          drawerText: 'Sign Out',
          drawerTextColor: AppColors.white,
        ),
      ],
    ),
  );
}

class DrawerWhiteContainer extends StatelessWidget {
  final String svgIcon;
  final String drawerText;
  final Color? drawerTextColor;
  final Color? drawerContainerColor;
  final Function()? onTap;
  const DrawerWhiteContainer({
    super.key,
    required this.svgIcon,
    required this.drawerText,
    this.drawerTextColor,
    this.drawerContainerColor, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 65.h,
        padding: EdgeInsets.only(left: 20.h),
        margin: EdgeInsets.only(bottom: 20.h, right: 10.w),
        decoration: BoxDecoration(
            color: drawerContainerColor ?? AppColors.white,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            )),
        child: Row(
          children: [
            SvgPicture.asset(svgIcon),
            5.horizontalSpace,
            Text(drawerText,
                style: CustomTextStyles.titleMediumGray90002.copyWith(
                    color: drawerTextColor ?? AppColors.tedDrawerPurpleText)),
          ],
        ),
      ),
    );
  }
}