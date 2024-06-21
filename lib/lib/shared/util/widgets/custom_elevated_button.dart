import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tedfinance_mobile/core/env/utils/size_utils.dart';
import 'package:tedfinance_mobile/theme/custom_button_style.dart';
import 'package:tedfinance_mobile/theme/theme_helper.dart';

import '../../../core/env/utils/colors.dart';
import 'base_button.dart';

enum ButtonType { primary, tertiary, red }

class CustomElevatedButton extends BaseButton {
  CustomElevatedButton({
    Key? key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    EdgeInsets? margin,
    VoidCallback? onPressed,
    Alignment? alignment,
    TextStyle? buttonTextStyle,
    bool? isDisabled,
    this.loading = false,
    double? height,
    double? width,
    double? sizedBoxHeight,
    double? sizedBoxWidth,
    required String text,
  }) : super(
            text: text,
            onPressed: onPressed,
            isDisabled: isDisabled,
            buttonTextStyle: buttonTextStyle,
            height: height,
            width: width,
            alignment: alignment,
            margin: margin,
            sizedBoxHeight: sizedBoxHeight);

  final BoxDecoration? decoration;

  final Widget? leftIcon;

  final Widget? rightIcon;
  final bool? loading;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildElevatedButtonWidget,
          )
        : buildElevatedButtonWidget;
  }

  Widget get buildElevatedButtonWidget => Container(
        height: height ?? 60.h,
        width: width ?? double.maxFinite,
        margin: margin,
        decoration:
            decoration ?? CustomButtonStyles.gradientIndigoAToPrimaryDecoration,
        child: ElevatedButton(
          style: buttonStyle,
          onPressed: isDisabled ?? false ? null : onPressed ?? () {},
          child: loading!
              ? SizedBox(
                  width: 30.h,
                  height: 30.h,
                  child: CircularProgressIndicator(
                      color: theme.colorScheme.onPrimary),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    leftIcon ?? const SizedBox.shrink(),
                    Text(
                      text,
                      style: buttonTextStyle ?? theme.textTheme.titleLarge,
                    ),
                    SizedBox(
                      width: sizedBoxWidth ?? 10,
                    ),
                    rightIcon ?? const SizedBox.shrink(),
                  ],
                ),
        ),
      );
}

class AppButton extends StatefulWidget {
  final Widget? child;
  final String? text;
  final String? icon;
  final ButtonType buttonType;
  final VoidCallback? onPressed;
  final bool? isLoading;
  final Color? color;
  final Color? iconColor;
  final Color? borderColor;
  final double? verticalPadding;
  final TextStyle? textStyle;
  final double? radius;
  final double? width;
  final double? height;
  final Color? hoverColor;
  final bool isHovered;
  const AppButton(
      {Key? key,
      this.child,
      this.radius,
      this.color,
      this.text,
      this.icon,
      this.borderColor,
      this.buttonType = ButtonType.primary,
      this.onPressed,
      this.isLoading,
      this.verticalPadding,
      this.textStyle,
      this.iconColor,
      this.width,
      this.height,
      this.hoverColor,
      this.isHovered = false})
      : assert(text != null || child != null),
        super(key: key);

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 55.h,
      width: widget.width ?? 395.w,
      child: MouseRegion(
        onHover: (value){
          setState(() {
            isHovered = true;
          });
        },
        onEnter: (event) {
          setState(() {
            isHovered = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHovered = false;
          });
        },
        child: ElevatedButton(
          onPressed: () {
            if (widget.onPressed != null) {
              FocusScope.of(context).unfocus();
              widget.onPressed!();
            }
          },
          style: ButtonStyle(
            elevation: MaterialStateProperty.resolveWith<double>((states) => 0),
            padding: MaterialStateProperty.resolveWith<EdgeInsets>(
              (states) => EdgeInsets.symmetric(
                  vertical: widget.verticalPadding ?? 12.h),
            ),
            fixedSize: MaterialStateProperty.resolveWith<Size>(
              (states) => Size(334.w, 48.h),
            ),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
              (states) => RoundedRectangleBorder(
                side: BorderSide(
                  color: widget.onPressed == null
                      ? Colors.transparent
                      : widget.borderColor ??
                          widget.color ??
                          widget.buttonType.borderColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(widget.radius ?? 8.r),
              ),
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {

              if (states.contains(MaterialState.hovered) && (widget.isHovered ?? false)) {
                return widget.hoverColor ?? AppColors.primaryButtonColor;
              }
              if (states.contains(MaterialState.disabled) ||
                  widget.onPressed == null) {
                return widget.buttonType.disabledColor;
              }
              return widget.color ??
                  widget.buttonType.buttonColor;
            }),

          ),
          child: (widget.isLoading ?? false)
              ? _loadingWidget()
              : (widget.text != null && widget.icon == null)
                  ? Text(
                      widget.text!,
                      style: widget.textStyle ??
                          GoogleFonts.poppins(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            height: 1,
                            // fontFamily: text!.contains('₦') ? '' : 'Avenir',
                            color: widget.buttonType.textColor,
                          ),
                    )
                  : (widget.text != null && widget.icon != null)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Visibility(
                                visible: widget.icon != null,
                                replacement: const SizedBox.shrink(),
                                child: SvgPicture.asset(widget.icon!)),
                            SizedBox(width: 7.w),
                            Text(
                              widget.text!,
                              style: widget.textStyle ??
                                  GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    height: 1,
                                    color: widget.buttonType.textColor,
                                  ),
                            ),
                          ],
                        )
                      : widget.child,
        ),
      ),
    );
  }
}

Widget _loadingWidget() => const Center(
      child: CircularProgressIndicator(
        color: Color(0xffCE2ACD),
      ),
    );

extension ButtonTypeExt on ButtonType {
  Color get buttonColor {
    switch (this) {
      case ButtonType.primary:
        return AppColors.primaryColor;
      case ButtonType.tertiary:
        return Colors.transparent;
      case ButtonType.red:
        return Colors.transparent;
    }
  }

  Color get disabledColor {
    switch (this) {
      case ButtonType.primary:
        return AppColors.primaryColor.withOpacity(0.5);
      case ButtonType.tertiary:
        return Colors.transparent.withOpacity(0.5);

      case ButtonType.red:
        return Colors.transparent.withOpacity(0.5);
    }
  }

  Color get borderColor {
    switch (this) {
      case ButtonType.primary:
        return Colors.transparent;
      case ButtonType.tertiary:
        return AppColors.darkBlue;
      case ButtonType.red:
        return Colors.red;
    }
  }

  Color get textColor {
    switch (this) {
      case ButtonType.primary:
        return Colors.white;
      case ButtonType.tertiary:
        return AppColors.darkBlue;
      case ButtonType.red:
        return Colors.red;
    }
  }
}


class HoverButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final Color? color;
  final Color? hoverColor;
  final double radius;
  final double height;

  const HoverButton({
    Key? key,
    this.onPressed,
    this.child,
    this.color,
    this.hoverColor,
    this.radius = 8.0,
    this.height = 48.0,
  }) : super(key: key);

  @override
  _HoverButtonState createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.hovered)) {
              return widget.hoverColor ?? Colors.transparent;
            }
            return widget.color ?? Colors.transparent;
          }),
          shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                (_) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.radius),
            ),
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
