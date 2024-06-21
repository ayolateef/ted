import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tedfinance_mobile/core/env/utils/colors.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';

import 'custom_elevated_button.dart';

class UploadCard extends StatelessWidget {
  final String? text;
  final String? buttonText;
  final VoidCallback onTap;
  final double? cardHeight;
  final Widget? cardWidget;

  const UploadCard({super.key,
     this.text,
    this.buttonText,
    this.cardHeight,
    this.cardWidget,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: cardHeight ?? 170.h,
        child: Card(
          elevation: 2,
          color: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side:  const BorderSide(color: AppColors.background)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text ?? '',
                textAlign: TextAlign.center,
                style:  TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.tedCardText
                ),
              ),
              const SizedBox(height: 20),


              cardWidget ?? AppButton(
                onPressed: onTap,
                text: buttonText ?? 'Upload +',
                textStyle: TextStyle(color: AppColors.black),
                color: Colors.transparent,
                borderColor: AppColors.tedGradientColor2,
                width: 160.w,
                height: 48.h,
                radius: 30.r,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// primary: Color(0xFFE071DF),
// onPrimary: Color(0xFF02E4