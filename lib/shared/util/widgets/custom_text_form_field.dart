import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tedfinance_mobile/core/env/utils/size_utils.dart';
import 'package:tedfinance_mobile/theme/custom_text_style.dart';
import 'package:tedfinance_mobile/theme/theme_helper.dart';

import '../../../core/env/utils/colors.dart';
import '../asset_images.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.headerText,
    this.headerTextFontWeight,
    this.radius,
    this.alignment,
    this.width,
    this.scrollPadding,
    this.controller,
    this.focusNode,
    this.autofocus = true,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = false,
    this.enabled = true,
    this.validator,
    this.onChange,
    this.focusDecoration,
    this.maxLength,
    this.headerTextColor,
    this.textFontSize,
    this.textInputFormatters,
    this.initialValue,
  }) : super(
          key: key,
        );

  final Color? headerTextColor;
  final String? headerText;

  final double? radius;

  final Alignment? alignment;

  final double? width;

  final TextEditingController? scrollPadding;

  final TextEditingController? controller;

  final FocusNode? focusNode;
  final int? maxLength;

  final bool? autofocus;
  final bool? enabled;

  final TextStyle? textStyle;

  final bool? obscureText;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;

  final String? hintText;
  final String? initialValue;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;
  final List<TextInputFormatter>? textInputFormatters;

  final InputBorder? borderDecoration;
  final InputBorder? focusDecoration;

  final Color? fillColor;

  final bool? filled;
  final double? textFontSize;
  final FontWeight? headerTextFontWeight;

  final FormFieldValidator<String>? validator;
  final Function(String val)? onChange;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormFieldWidget(context),
          )
        : textFormFieldWidget(context);
  }

  Widget textFormFieldWidget(BuildContext context) => SizedBox(
      width: width ?? double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (headerText != null)
            Column(
              children: [
                Text(headerText ?? '',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: textFontSize ?? 15.sp,
                          fontWeight: FontWeight.w600,
                          color: headerTextColor ?? AppColors.black),
                    )),
              ],
            ),
          10.verticalSpace,
          TextFormField(
            maxLength: maxLength,
            onChanged: onChange ?? (f) => f,
            enabled: enabled,
            scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            controller: controller,
            focusNode: focusNode ?? FocusNode(),
            autofocus: autofocus!,
            style: textStyle ?? theme.textTheme.titleSmall,
            obscureText: obscureText!,
            textInputAction: textInputAction,
            keyboardType: textInputType,
            maxLines: maxLines ?? 1,
            decoration: decoration,
            validator: validator,
            inputFormatters: textInputFormatters,
          ),
        ],
      ));
  InputDecoration get decoration => InputDecoration(
        counterText: "",
        hintText: hintText ?? "",
        hintStyle: hintStyle ?? CustomTextStyles.titleSmallBluegray300,
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.only(
              top: 19.h,
              right: 19.h,
              bottom: 19.h,
              left: 19.h,
            ),
        fillColor: fillColor,
        filled: filled,
        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 15.r),
              borderSide: BorderSide(
                color: appTheme.gray200,
                width: 1,
              ),
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.h),
              borderSide: BorderSide(
                color: appTheme.gray200,
                width: 1,
              ),
            ),
        focusedBorder: focusDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 2,
              ),
            ),
      );
}

/// Extension on [CustomTextFormField] to facilitate inclusion of all types of border style etc
extension TextFormFieldStyleHelper on CustomTextFormField {
  static OutlineInputBorder get fillGrayTL6 => OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.h),
        borderSide: BorderSide.none,
      );
  static OutlineInputBorder get fillGray => OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.h),
        borderSide: BorderSide.none,
      );
  static OutlineInputBorder get outlineIndigoTL10 => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.h),
        borderSide: BorderSide(
          color: appTheme.indigo100,
          width: 1,
        ),
      );
  static OutlineInputBorder get fillGrayTL8 => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.h),
        borderSide: BorderSide.none,
      );
  static OutlineInputBorder get fillBlue => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.h),
        borderSide: BorderSide.none,
      );
  static OutlineInputBorder get fillGrayTL14 => OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.h),
        borderSide: BorderSide.none,
      );
}




class CustomDropdownFormField extends StatefulWidget {
  final String headerText;
  final String hintText;
  final double? textFontSize;
  final Color? headerTextColor;
  final List<String> currencies;
  final ValueChanged<String>? onChanged;

  const CustomDropdownFormField({
    Key? key,
    required this.headerText,
    required this.hintText,
    required this.currencies,
    this.onChanged,
    this.textFontSize,
    this.headerTextColor,
  }) : super(key: key);

  @override
  _CustomDropdownFormFieldState createState() =>
      _CustomDropdownFormFieldState();
}

class _CustomDropdownFormFieldState extends State<CustomDropdownFormField> {
  String? _selectedCurrency;



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(widget.headerText,  style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: widget.textFontSize ?? 15.sp,
                fontWeight: FontWeight.w600,
                color: widget.headerTextColor ?? AppColors.black),
          )),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: InputBorder.none, // Dropdown icon
            ),
            value: _selectedCurrency,
            onChanged: (value) {
              setState(() {
                _selectedCurrency = value;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(value!);
              }
            },
            items: widget.currencies
                .map((currency) => DropdownMenuItem(
              value: currency,
              child: Text(currency),
            ))
                .toList(),
            icon: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: SvgPicture.asset(AssetResources.dropdownIcon),
            ),
            iconDisabledColor: null,
          ),
        ),
      ],
    );
  }
}

