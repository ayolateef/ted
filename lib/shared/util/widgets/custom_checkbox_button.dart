import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/env/utils/colors.dart';
import '../../../theme/custom_text_style.dart';


class CustomCheckboxButton extends StatelessWidget {
  CustomCheckboxButton({
    Key? key,
    required this.onChange,
    this.decoration,
    this.alignment,
    this.isRightCheck,
    this.iconSize,
    this.value,
    this.text,
    this.width,
    this.padding,
    this.textStyle,
    this.textAlignment,
    this.isExpandedText = false,
    this.widget,
    this.fontSize,
  }) : super(
          key: key,
        );

  final BoxDecoration? decoration;

  final Alignment? alignment;

  final bool? isRightCheck;

  final double? iconSize;

  bool? value;

  final Function(bool) onChange;

  final String? text;
  final Widget? widget;

  final double? width;
  final double? fontSize;

  final EdgeInsetsGeometry? padding;

  final TextStyle? textStyle;

  final TextAlign? textAlignment;

  final bool isExpandedText;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
      alignment: alignment ?? Alignment.topCenter,
      child: buildCheckBoxWidget(),
    )
        : buildCheckBoxWidget();
  }

  Widget buildCheckBoxWidget() {
    return InkWell(
      onTap: () {
        value = !(value!);
        onChange(value!);
      },
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(),
            height: 26,
            width: 26,
            decoration: BoxDecoration(
              color: value == true ? AppColors.primaryColor : Colors.transparent,

              borderRadius: BorderRadius.circular(5.r),
              border: value == true
                  ? Border.all(color: AppColors.primaryColor, width: 2)
                  : null,
            ),
            // padding: const EdgeInsets.only(bottom: 100, right: 10),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Icon(
                  value == true ? Icons.check : Icons.check_box_outline_blank,
                  color: value == true ? Colors.white : AppColors.primaryColor,
                  size: iconSize,
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          textWidget,
        ],
      ),
    );
  }

  Widget get leftSideCheckbox => Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: checkboxWidget,
          ),
          isExpandedText ? Expanded(child: textWidget) : textWidget,
        ],
      );
  Widget get rightSideCheckbox => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isExpandedText ? Expanded(child: textWidget) : textWidget,
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: checkboxWidget,
          ),
        ],
      );
  Widget get textWidget => widget ?? Text(
        text ?? "",
        textAlign: textAlignment ?? TextAlign.left,
        style: textStyle ?? CustomTextStyles.titleSmallMedium.copyWith(fontSize: fontSize),
      );
  Widget get checkboxWidget => Icon(
    value == true ? Icons.check : Icons.check_box_outline_blank, // Icon when checked or unchecked
    color: value == true? Colors.purple : Colors.transparent, // Icon color when checked or unchecked
    size: iconSize, // Icon size remains constant
  );
}
