// import 'package:flutter/material.dart';
// import 'package:tedfinance_mobile/core/env/utils/size_utils.dart';
// import 'package:tedfinance_mobile/theme/app_decoration.dart';
// import 'package:tedfinance_mobile/theme/custom_text_style.dart';
// import 'package:tedfinance_mobile/theme/theme_helper.dart';
// import 'package:tedfinance_mobile/widgets/custom_image_view.dart';

// class CustomBottomBar extends StatefulWidget {
//   CustomBottomBar({this.onChanged});

//   Function(BottomBarEnum)? onChanged;

//   @override
//   CustomBottomBarState createState() => CustomBottomBarState();
// }

// class CustomBottomBarState extends State<CustomBottomBar> {
//   int selectedIndex = 0;

//   List<BottomMenuModel> bottomMenuList = [
//     BottomMenuModel(
//       icon: ImageConstant.imgNavWallet24x24,
//       activeIcon: ImageConstant.imgNavWallet24x24,
//       title: "Wallet",
//       type: BottomBarEnum.Wallet,
//     ),
//     BottomMenuModel(
//       icon: ImageConstant.imgNavBantsGray500,
//       activeIcon: ImageConstant.imgNavBantsGray500,
//       title: "Bants",
//       type: BottomBarEnum.Bants,
//     ),
//     BottomMenuModel(
//       icon: ImageConstant.imgNavCauses,
//       activeIcon: ImageConstant.imgNavCauses,
//       title: "Causes",
//       type: BottomBarEnum.Causes,
//     ),
//     BottomMenuModel(
//       icon: ImageConstant.imgNavEvents,
//       activeIcon: ImageConstant.imgNavEvents,
//       title: "Events",
//       type: BottomBarEnum.Events,
//     ),
//     BottomMenuModel(
//       icon: ImageConstant.imgNavMore,
//       activeIcon: ImageConstant.imgNavMore,
//       title: "More",
//       type: BottomBarEnum.More,
//     )
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100.h,
//       decoration: BoxDecoration(
//         border: Border(
//           top: BorderSide(
//             color: appTheme.gray100,
//             width: 1.h,
//           ),
//         ),
//       ),
//       child: BottomNavigationBar(
//         backgroundColor: Colors.transparent,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         selectedFontSize: 0,
//         elevation: 0,
//         currentIndex: selectedIndex,
//         type: BottomNavigationBarType.fixed,
//         items: List.generate(bottomMenuList.length, (index) {
//           return BottomNavigationBarItem(
//             icon: Container(
//               decoration: AppDecoration.fillGray50,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CustomImageView(
//                     imagePath: bottomMenuList[index].icon,
//                     height: 24..h,
//                     width: 24..h,
//                     color: appTheme.gray500,
//                     margin: EdgeInsets.only(top: 25.h),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                       top: 3.h,
//                       bottom: 27.h,
//                     ),
//                     child: Text(
//                       bottomMenuList[index].title ?? "",
//                       style: CustomTextStyles.labelLargeGray500.copyWith(
//                         color: appTheme.gray500,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             activeIcon: Container(
//               decoration: AppDecoration.fillGray50,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   CustomImageView(
//                     imagePath: bottomMenuList[index].activeIcon,
//                     height: 24..h,
//                     width: 24..h,
//                     margin: EdgeInsets.only(top: 24.h),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 3.h),
//                     child: Text(
//                       bottomMenuList[index].title ?? "",
//                       style:
//                           CustomTextStyles.labelLargeIndigoA20001Bold.copyWith(
//                         color: appTheme.indigoA20001,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     height: 6..h,
//                     width: 6..h,
//                     margin: EdgeInsets.only(
//                       top: 5.h,
//                       bottom: 17.h,
//                     ),
//                     decoration: BoxDecoration(
//                       color: appTheme.blue200,
//                       borderRadius: BorderRadius.circular(
//                         3.h,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             label: '',
//           );
//         }),
//         onTap: (index) {
//           selectedIndex = index;
//           widget.onChanged?.call(bottomMenuList[index].type);
//           setState(() {});
//         },
//       ),
//     );
//   }
// }

// enum BottomBarEnum {
//   Wallet,
//   Bants,
//   Causes,
//   Events,
//   More,
// }

// class BottomMenuModel {
//   BottomMenuModel({
//     required this.icon,
//     required this.activeIcon,
//     this.title,
//     required this.type,
//   });

//   String icon;

//   String activeIcon;

//   String? title;

//   BottomBarEnum type;
// }

// class DefaultWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       padding: EdgeInsets.all(10),
//       child: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Please replace the respective Widget here',
//               style: TextStyle(
//                 fontSize: 18,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
