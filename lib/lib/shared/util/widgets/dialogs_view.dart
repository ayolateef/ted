// import 'package:flutter/material.dart';
// class DialogsView{

//   static signOutDialog(BuildContext context,
//       {bool? enabled,
//       bool? loading,
//       String? title,
//       String? msg,
//       Function? onAction,
//       String? btn1Text,
//       String? btn2Text}) {
//     return Center(
//       child: Container(
//           height: scaledHeight(context).h / 2.5.h,
//           width: scaledWidth(context).w - 40.w,
//           decoration: BoxDecoration(
//               color: AppColors.white,
//               borderRadius: BorderRadius.circular(Sizes.dimen_20.r)),
//           child: SizedBox.expand(
//             child: Padding(
//               padding: EdgeInsets.all(Sizes.dimen_10.r),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   VerticalSpacing(20.h),
//                   Styles.medium(
//                     title ?? TextLiterals.signOut,
//                     fontSize: scaledFontSize(15.sp, context),
//                     fontWeight: FWt.bold,
//                   ),
//                   VerticalSpacing(40.h),
//                   Styles.medium(msg ?? TextLiterals.wantToSignOut),
//                   VerticalSpacing(50.h),
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: [
//                         AppButton(
//                           text: btn1Text ?? TextLiterals.cancel,
//                           width: scaledWidth(context).w / 2.5.w,
//                           enabled: true,
//                           backgroundColor: AppColors.primaryYellow,
//                           height: Sizes.dimen_50.h,
//                           fontSize: scaledFontSize(16.sp, context),
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                         ),
//                         HorizontalSpacing(10.sp),
//                         AppButton(
//                           text: btn2Text ?? TextLiterals.signOut,
//                           width: scaledWidth(context).w / 2.5.w,
//                           fontColor: AppColors.primaryRed,
//                           enabled: enabled ?? true,
//                           isLoading: loading ?? false,
//                           backgroundColor: AppColors.greyD5.withOpacity(.2),
//                           height: Sizes.dimen_50.h,
//                           fontSize: scaledFontSize(16.sp, context),
//                           onPressed: onAction != null
//                               ? () => onAction()
//                               : () async {
//                                   final prefs =
//                                       await SharedPreferences.getInstance();
//                                   prefs.clear();
//                                   Provider.of<BookRideProvider>(context,
//                                           listen: false)
//                                       .isDriverFound = false;
//                                   Provider.of<BookRideProvider>(context,
//                                           listen: false)
//                                       .isReservedTrip = false;
//                                   SharedPreferenceService.setActiveOrderId("");
//                                   Navigator.pushNamedAndRemoveUntil(
//                                       context,
//                                       RouteLiterals.phoneNumberLogin,
//                                       (Route<dynamic> route) => false);
//                                 },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )),
//     );
//   }

// }