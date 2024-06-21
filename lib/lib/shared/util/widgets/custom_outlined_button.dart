import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tedfinance_mobile/core/env/utils/size_utils.dart';
import 'package:tedfinance_mobile/theme/custom_button_style.dart';
import 'package:tedfinance_mobile/theme/custom_text_style.dart';

import 'base_button.dart';

class CustomOutlinedButton extends BaseButton {
  CustomOutlinedButton({
    Key? key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    this.label,
    VoidCallback? onPressed,
    ButtonStyle? buttonStyle,
    TextStyle? buttonTextStyle,
    bool? isDisabled,
    Alignment? alignment,
    double? height,
    double? width,
    EdgeInsets? margin,
    required String text,
  }) : super(
          text: text,
          onPressed: onPressed,
          buttonStyle: buttonStyle,
          isDisabled: isDisabled,
          buttonTextStyle: buttonTextStyle,
          height: height,
          alignment: alignment,
          width: width,
          margin: margin,
        );

  final BoxDecoration? decoration;

  final Widget? leftIcon;

  final Widget? rightIcon;

  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildOutlinedButtonWidget,
          )
        : buildOutlinedButtonWidget;
  }

  Widget get buildOutlinedButtonWidget => Container(
        height: this.height ?? 19.h,
        width: this.width ?? double.maxFinite,
        margin: margin,
        decoration:
            decoration ?? CustomButtonStyles.gradientAmberAToAmberDecoration,
        child: OutlinedButton(
          //  style: buttonStyle,
          onPressed: isDisabled ?? false ? null : onPressed ?? () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leftIcon ?? const SizedBox.shrink(),
              Text(
                text,
                style:
                    buttonTextStyle ?? CustomTextStyles.labelLargeInterBlack900,
              ),
              rightIcon ?? const SizedBox.shrink(),
            ],
          ),
        ),
      );
}
