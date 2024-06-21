import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/env/utils/colors.dart';
import '../../../theme/custom_text_style.dart';
import '../asset_images.dart';
import 'custom_elevated_button.dart';

class NotificationMessager {
  static showError(BuildContext context, {required String message}) {
    _showMessage(context, message: message, isError: true);
  }

  static showSuccess(BuildContext context, {required String message}) {
    _showMessage(context, message: message, isError: false);
  }

  static Future _showMessage(BuildContext context,
      {required String message, required bool isError}) async {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 100.h,
        right: 0.0,
        child: _Messenger(
          message: message,
          isErrorMessage: isError,
        ),
      ),
    );
    overlayState.insert(overlayEntry);
    await Future.delayed(const Duration(seconds: 2));
    overlayEntry.remove();
  }

  static successDialog(
      {context, text, VoidCallback? onClose, String? btnText}) {
    appSuccessDialog(
        height: 330.h,
        content: Material(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 35.h),
              SvgPicture.asset(AssetResources.successIcon),
              SizedBox(height: 15.h),

              // Your personal details has been successfully updated
              Text("Successful",
                  style: CustomTextStyles.headlineSmallOnPrimary25
                      .copyWith(
                  color: AppColors.primaryColor),
              ),
                  SizedBox(height: 10.h),

              Text(text,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.bodySmallGray500
                      .copyWith(
                      color: AppColors.tedBlackText),
              ),
              SizedBox(height: 35.h),
              AppButton(
                text: btnText ?? "Close",
                onPressed: onClose,
              ),
            ],
          ),
        ),
        context: context);
  }



  static comingSoonDialog(context) {
    appSuccessDialog(
        height: 300.h,
        content: Material(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 35.h,
              ),
              Icon(
                Icons.info_outline,
                size: 65.sp,
                color: AppColors.darkBlue,
              ),

              SizedBox(height: 15.h),
              Text("Feature coming soon",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700)),
              SizedBox(height: 10.h),
              Text("Please check back later",
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400)),
              SizedBox(height: 35.h),
              AppButton(
                text: 'Okay',
                onPressed: () {
                  Navigator.of (context).pop();
                },
              ),
              // modalButton(
              //   buttonText: 'Okay',
              //   buttonType: ModalButtonType.solid,
              //   onPressed: () {
              //     locator<NavigationService>().pop();
              //   },
              // ),
            ],
          ),
        ),
        context: context);
  }

  // static error(
  //   context,
  // ) {
  //   appSuccessDialog(
  //       height: 330.h,
  //       content: Material(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             SizedBox(height: 35.h),
  //             SvgPicture.asset(AssetResources.ERROR_ICON,
  //                 width: 100.w, height: 100.h),
  //             SizedBox(height: 15.h),
  //             Text("Opps",
  //                 style: AppStyles.largeText
  //                     .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w900)),
  //             SizedBox(height: 10.h),
  //             Text("Your trip has ended",
  //                 textAlign: TextAlign.center,
  //                 style: AppStyles.smallText.copyWith(
  //                   fontSize: 12.sp,
  //                   // fontWeight: FontWeight.w400
  //                 )),
  //             SizedBox(height: 35.h),
  //             AppButton(
  //               text: "Close",
  //               onPressed: () {
  //                 getIt<NavigationService>().back();
  //                 getIt<NavigationService>()
  //                     .clearAllTo(routeName: RootRoutes.home);
  //               },
  //             ),
  //           ],
  //         ),
  //       ),
  //       context: context);
  // }
  //
  // static successPaymentDialog(context, VoidCallback onTap, String amount) {
  //   appSuccessDialog(
  //       height: 330.h,
  //       content: Material(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             SizedBox(height: 35.h),
  //             SvgPicture.asset(AssetResources.SUCCESS),
  //             SizedBox(height: 15.h),
  //
  //             // Your personal details has been successfully updated
  //             Text("Success",
  //                 style: AppStyles.largeText
  //                     .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w900)),
  //             SizedBox(height: 10.h),
  //             Text("Delivery initiated successfully",
  //                 textAlign: TextAlign.center,
  //                 style: AppStyles.smallText.copyWith(
  //                   fontSize: 12.sp,
  //                   // fontWeight: FontWeight.w400
  //                 )),
  //             SizedBox(height: 10.h),
  //             Text("$amount",
  //                 style: AppStyles.largeText
  //                     .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w900,fontFamily: '' )),
  //             SizedBox(height: 35.h),
  //
  //             AppButton(text: "Close", onPressed: onTap),
  //           ],
  //         ),
  //       ),
  //       context: context);
  // }

  static confirmPopUp({
    required String text,
    required String subtext,
    required VoidCallback? onClose,
    required BuildContext context,
   // required String leftText,
    required String rightText,
    required VoidCallback? onNo,
    String? svgImage,
  }) =>
      showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: 'pp',
        pageBuilder: (_, __, ___) => Material(
          type: MaterialType.transparency,
          child: Align(
            child: Container(
               width: 400.w,
               height: 516.h,
              padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 24,
                    spreadRadius: -6,
                    offset: const Offset(0, 8),
                    color: Colors.black.withOpacity(.07),
                  )
                ],
              ),
              child: Column(
                children: [
                  10.verticalSpace,
                  SvgPicture.asset( svgImage ?? AssetResources.successIcon, height: 150,),
                  // Image.asset("assets/images/check_warning_icon.png",
                  //     width: 104.w, height: 104.w, color: Colors.amber),
                  SizedBox(height: 16.h),
                  Text(
                    text,
                    style: TextStyle(
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryColor),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Text(
                      subtext,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.3,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.tedGrey
                      ),
                    ),
                  ),
                  SizedBox(height: 46.h),
                  SizedBox(
                    // height: 38.h,
                    child: AppButton(text: rightText, onPressed: onClose, color: AppColors.tedButtonGrey),
                  ),
                  SizedBox(height: 16.h),
                  // SizedBox(
                  //   // height: 38.h,
                  //   child: AppButton(
                  //     text: leftText,
                  //     buttonType: ButtonType.tertiary,
                  //     onPressed: onNo ??
                  //         () {
                  //           Navigator.pop(context);
                  //         },
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      );
}

class _Messenger extends StatelessWidget {
  final String message;
  final bool isErrorMessage;
  const _Messenger({required this.message, required this.isErrorMessage});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        height: 49.h,
        width: 300.w,
        decoration: BoxDecoration(
          color: Color(isErrorMessage ? 0xFFFFF5F4 : 0xFFFFFFFF),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.w, left: 10.h),
                child: Text(
                  message,
                  maxLines: 3,
                  style: TextStyle(

                      fontWeight: FontWeight.w800,
                      fontSize: 14.sp,
                      color: Color(isErrorMessage ? 0xffEA4336 : 0xFF2FC55B)),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 20.w, right: 18.w),
                child: SvgPicture.asset(isErrorMessage
                    ? AssetResources.ERROR_ICON
                    : AssetResources.successIcon)),
          ],
        ),
      ),
    );
  }
}

appSuccessDialog({
  required BuildContext context,
  required double height,
  Color? color,
  // required String title,
  // required String subtitle,
  double? width,
  bool hasClip = false,
  bool barrierDismissible = false,
  required Widget content,

}) {
  showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible:barrierDismissible,
    barrierColor: Colors.black.withOpacity(0.2),
    transitionDuration: const Duration(milliseconds: 300),
    context: context,
    pageBuilder: (_, __, ___) {
      return Align(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 25.w),
          height: height,
          // width: width ?? 415.w,
          padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 15.h),
          decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Material(
            color: Colors.white,
            child: Column(
              children: [
                content,
              ],
            ),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
            .animate(anim),
        child: child,
      );
    },
  );
}