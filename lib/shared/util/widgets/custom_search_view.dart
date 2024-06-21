import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tedfinance_mobile/core/env/utils/size_utils.dart';
import 'package:tedfinance_mobile/theme/custom_text_style.dart';
import 'package:tedfinance_mobile/theme/theme_helper.dart';

import 'custom_image_view.dart';

class CustomSearchView extends StatelessWidget {
  CustomSearchView({
    Key? key,
    this.alignment,
    this.width,
    this.scrollPadding,
    this.controller,
    this.focusNode,
    this.autofocus = true,
    this.textStyle,
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
    this.filled = true,
    this.validator,
    this.onChanged,
  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final double? width;

  final TextEditingController? scrollPadding;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;

  final TextInputType? textInputType;

  final int? maxLines;

  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final FormFieldValidator<String>? validator;

  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: searchViewWidget(context),
          )
        : searchViewWidget(context);
  }

  Widget searchViewWidget(BuildContext context) => SizedBox(
        width: width ?? double.maxFinite,
        child: TextFormField(
          scrollPadding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          controller: controller,
          focusNode: focusNode ?? FocusNode(),
          autofocus: autofocus!,
          style: textStyle ?? CustomTextStyles.labelLargeGray500,
          keyboardType: textInputType,
          maxLines: maxLines ?? 1,
          decoration: decoration,
          validator: validator,
          onChanged: (String value) {
            onChanged!.call(value);
          },
        ),
      );
  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "",
        hintStyle: hintStyle ?? CustomTextStyles.labelLargeGray500,
        prefixIcon: prefix ??
            Container(
              margin: EdgeInsets.fromLTRB(20.h, 11.h, 10.h, 11.h),
              child: CustomImageView(
                //imagePath: ImageConstant.imgContrast,
                height: 18.h,
                width: 18.h,
              ),
            ),
        prefixIconConstraints: prefixConstraints ??
            BoxConstraints(
              maxHeight: 40.h,
            ),
        suffixIcon: suffix ??
            Padding(
              padding: EdgeInsets.only(
                right: 15.h,
              ),
              child: IconButton(
                onPressed: () => controller!.clear(),
                icon: Icon(
                  Icons.clear,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
        suffixIconConstraints: suffixConstraints ??
            BoxConstraints(
              maxHeight: 40.h,
            ),
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.only(
              top: 10.h,
              right: 10.h,
              bottom: 10.h,
            ),
        fillColor: fillColor ?? appTheme.gray100,
        filled: filled,
        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.h),
              borderSide: BorderSide.none,
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.h),
              borderSide: BorderSide.none,
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.h),
              borderSide: BorderSide.none,
            ),
      );
}
