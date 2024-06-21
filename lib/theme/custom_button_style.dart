import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tedfinance_mobile/core/env/utils/size_utils.dart';
import 'package:tedfinance_mobile/theme/theme_helper.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // Filled button style
  static ButtonStyle get fillBlack => ElevatedButton.styleFrom(
        backgroundColor: appTheme.black900.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.h),
        ),
      );
  static ButtonStyle get fillBlue => ElevatedButton.styleFrom(
        backgroundColor: appTheme.blue50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.h),
        ),
      );

  static ButtonStyle get fillGrayTL10 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.gray100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.h),
        ),
      );
  static ButtonStyle get fillBlueTL14 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.blue5002,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.h),
        ),
      );
  static ButtonStyle get fillGray => ElevatedButton.styleFrom(
        backgroundColor: appTheme.gray10001,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.h),
        ),
      );
  static ButtonStyle get fillGrayTL14 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.gray90002,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.h),
        ),
      );
  static ButtonStyle get fillGrayTL141 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.gray5002,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.h),
        ),
      );
  static ButtonStyle get fillGrayTL142 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.gray200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.h),
        ),
      );
  static ButtonStyle get fillGrayTL6 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.gray5002,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.h),
        ),
      );
  static ButtonStyle get fillGreen => ElevatedButton.styleFrom(
        backgroundColor: appTheme.green70001,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.h),
        ),
      );
  static ButtonStyle get fillIndigo => ElevatedButton.styleFrom(
        backgroundColor: appTheme.indigo40001,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.h),
        ),
      );
  static ButtonStyle get fillPrimaryContainer => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.h),
        ),
      );

  // Gradient button style
  static BoxDecoration get gradientAmberAToAmberDecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(5.h),
        border: Border.all(
          color: appTheme.amberA700,
          width: 1.h,
        ),
        gradient: LinearGradient(
          begin: Alignment(0.5, 0),
          end: Alignment(0.5, 1),
          colors: [
            appTheme.amberA700,
            appTheme.amber30001,
          ],
        ),
      );

  static BoxDecoration get whiteGreyDecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(5.h),
        color: appTheme.gray5002,

        // border: Border.all(
        //   color: appTheme.gray5002,
        //   width: 1.h,
        // ),
        // gradient: LinearGradient(
        //   begin: Alignment(0.5, 0),
        //   end: Alignment(0.5, 1),
        //   colors: [
        //     appTheme.amberA700,
        //     appTheme.amber30001,
        //   ],
        // ),
      );

  static BoxDecoration get tier0Decoration => BoxDecoration(
      borderRadius: BorderRadius.circular(5.h),
      border: Border.all(
        color: theme.colorScheme.onPrimary,
        width: 1.h,
      ),
      color: Colors.transparent
      // gradient: LinearGradient(
      //   begin: Alignment(0.5, 0),
      //   end: Alignment(0.5, 1),
      //   colors: [
      //     appTheme.amberA700,
      //     appTheme.amber30001,
      //   ],
      // ),
      );
  static BoxDecoration get gradientIndigoAToPrimaryDecoration => BoxDecoration(
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

  static BoxDecoration get lightBlueDecoration => BoxDecoration(
        color: appTheme.blue50,
        borderRadius: BorderRadius.circular(14.h),
        // border: Border.all(width: 1, color: appTheme.gray200)
      );

  static BoxDecoration get gray2001Decoration => BoxDecoration(
        color: appTheme.gray20001,
        borderRadius: BorderRadius.circular(14.h),
        // border: Border.all(width: 1, color: appTheme.gray200)
      );

  static BoxDecoration get texInputDefaultDecotation => BoxDecoration(
      color: appTheme.gray100,
      borderRadius: BorderRadius.circular(14.h),
      border: Border.all(width: 1, color: appTheme.gray200));
  static BoxDecoration get gradientRedToRedDecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(14.h),
        gradient: LinearGradient(
          begin: Alignment(0.5, 0),
          end: Alignment(0.5, 1),
          colors: [
            appTheme.red300,
            appTheme.red400,
          ],
        ),
      );

  // static BoxDecoration get defaultInputBox => BoxDecoration(
  //     borderRadius: BorderRadius.circular(
  //       14.h,
  //     ),
  //     border: Border.all(width: 1, color: appTheme.gray200));
  static BoxBorder get defaultInputBox => Border.all();
  // Outline button style
  static ButtonStyle get outlineGray => OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        side: BorderSide(
          color: appTheme.gray5002,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.h),
        ),
      );

  static ButtonStyle get filledWhiteGray => OutlinedButton.styleFrom(
        backgroundColor: appTheme.indigoA20001,
        side: BorderSide(
          color: appTheme.gray5002,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.h),
        ),
      );
  // text button style
  static ButtonStyle get none => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0),
      );
}
