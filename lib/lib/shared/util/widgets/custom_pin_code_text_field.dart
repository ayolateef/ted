import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tedfinance_mobile/core/env/utils/size_utils.dart';
import 'package:tedfinance_mobile/theme/theme_helper.dart';

import '../../../core/env/utils/colors.dart';

class CustomPinCodeTextField extends StatelessWidget {
  CustomPinCodeTextField(
      {Key? key,
      required this.context,
      required this.onChanged,
      this.alignment,
      this.controller,
      this.textStyle,
      this.hintStyle,
      this.validator,
      this.readOnly = false, this.borderRadius})
      : super(
          key: key,
        );

  final Alignment? alignment;

  final BuildContext? context;

  final TextEditingController? controller;

  final TextStyle? textStyle;

  final TextStyle? hintStyle;


  final BorderRadius? borderRadius;

  Function(String) onChanged;
  final bool? readOnly;

  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: pinCodeTextFieldWidget,
          )
        : pinCodeTextFieldWidget;
  }

  Widget get pinCodeTextFieldWidget => PinCodeTextField(
        readOnly: readOnly!,
        appContext: context!,
        controller: controller,
        length: 4,
        keyboardType: TextInputType.number,
        textStyle: textStyle,
        hintStyle: hintStyle,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        enableActiveFill: true,
        pinTheme: PinTheme(
          fieldHeight: 69.h,
          selectedFillColor: AppColors.primaryColor,
          fieldWidth: 72.h,
          shape: PinCodeFieldShape.box,
          borderRadius:  borderRadius == null ? BorderRadius.circular(14.h) : null,

          inactiveFillColor: appTheme.gray200,
          activeFillColor: appTheme.gray200,
          inactiveColor: Colors.transparent,
          activeColor: Colors.transparent,
          selectedColor: Colors.transparent,
        ),
        onChanged: (value) => onChanged(value),
        validator: validator,
      );
}
