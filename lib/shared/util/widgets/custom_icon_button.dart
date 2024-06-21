import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tedfinance_mobile/core/env/utils/size_utils.dart';
import 'package:tedfinance_mobile/theme/theme_helper.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    this.alignment,
    this.height,
    this.width,
    this.padding,
    this.decoration,
    this.child,
    this.onTap,
  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final double? height;

  final double? width;

  final EdgeInsetsGeometry? padding;

  final BoxDecoration? decoration;

  final Widget? child;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: iconButtonWidget,
          )
        : iconButtonWidget;
  }

  Widget get iconButtonWidget => SizedBox(
        height: height ?? 0,
        width: width ?? 0,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Container(
            height: height ?? 0,
            width: width ?? 0,
            padding: padding ?? EdgeInsets.zero,
            decoration: decoration ??
                BoxDecoration(
                  color: appTheme.blue5002,
                  borderRadius: BorderRadius.circular(25.h),
                ),
            child: child,
          ),
          onPressed: onTap,
        ),
      );
}

/// Extension on [CustomIconButton] to facilitate inclusion of all types of border style etc
extension IconButtonStyleHelper on CustomIconButton {
  static BoxDecoration get gradientIndigoAToPrimary => BoxDecoration(
        borderRadius: BorderRadius.circular(40.h),
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: Alignment(0.5, 1),
          colors: [
            appTheme.indigoA20001,
            theme.colorScheme.primary,
          ],
        ),
      );

  static BoxDecoration get fillGrayTL15 => BoxDecoration(
        color: appTheme.gray100,
        borderRadius: BorderRadius.circular(15.h),
      );

  static BoxDecoration get fillRedTL13 => BoxDecoration(
        color: appTheme.red200,
        borderRadius: BorderRadius.circular(13.h),
      );
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray10001,
        borderRadius: BorderRadius.circular(25.h),
      );
  static BoxDecoration get fillRed => BoxDecoration(
        color: appTheme.red5001,
        borderRadius: BorderRadius.circular(25.h),
      );
  static BoxDecoration get fillGrayTL25 => BoxDecoration(
        color: appTheme.gray5003,
        borderRadius: BorderRadius.circular(25.h),
      );
  static BoxDecoration get fillRedTL25 => BoxDecoration(
        color: appTheme.red50,
        borderRadius: BorderRadius.circular(25.h),
      );
  static BoxDecoration get fillGreenA => BoxDecoration(
        color: appTheme.greenA200,
        borderRadius: BorderRadius.circular(6.h),
      );
  static BoxDecoration get fillRedTL6 => BoxDecoration(
        color: appTheme.red200,
        borderRadius: BorderRadius.circular(6.h),
      );
  static BoxDecoration get outlineGray => BoxDecoration(
        borderRadius: BorderRadius.circular(22.h),
        border: Border.all(
          color: appTheme.gray5002,
          width: 1.h,
        ),
      );
  static BoxDecoration get fillGrayTL28 => BoxDecoration(
        color: appTheme.gray100,
        borderRadius: BorderRadius.circular(28.h),
      );
  static BoxDecoration get fillGrayTL16 => BoxDecoration(
        color: appTheme.gray200,
        borderRadius: BorderRadius.circular(16.h),
      );
  static BoxDecoration get fillOnPrimary => BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(20.h),
      );
  static BoxDecoration get fillAmber => BoxDecoration(
        color: appTheme.amber300,
        borderRadius: BorderRadius.circular(20.h),
      );
  static BoxDecoration get fillGreen => BoxDecoration(
        color: appTheme.green800,
        borderRadius: BorderRadius.circular(20.h),
      );
  static BoxDecoration get fillGrayTL251 => BoxDecoration(
        color: appTheme.gray5002,
        borderRadius: BorderRadius.circular(25.h),
      );
  static BoxDecoration get outlinePrimaryContainer => BoxDecoration(
        color: appTheme.gray5002,
        borderRadius: BorderRadius.circular(18.h),
        border: Border.all(
          color: theme.colorScheme.primaryContainer,
          width: 1.h,
        ),
      );
  static BoxDecoration get fillOrange => BoxDecoration(
        color: appTheme.orange50,
        borderRadius: BorderRadius.circular(25.h),
      );
  static BoxDecoration get gradientIndigoAToPrimaryTL14 => BoxDecoration(
        borderRadius: BorderRadius.circular(14.h),
        gradient: LinearGradient(
          begin: Alignment(0.5, 0),
          end: Alignment(0.5, 1),
          colors: [
            appTheme.indigoA20001,
            theme.colorScheme.primary,
          ],
        ),
      );
  static BoxDecoration get fillGrayTL12 => BoxDecoration(
        color: appTheme.gray900,
        borderRadius: BorderRadius.circular(12.h),
      );
}
