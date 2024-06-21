import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/env/utils/colors.dart';
import '../asset_images.dart';
import 'custom_containers.dart';

class CustomListTile extends StatelessWidget {
  final Function() onTap;
  final Widget? leadingWidget;
  final String? title;
  final String? text;
  final String? subtitle;
  final String? trailingIcon;
  final Widget? trailingWidget;
  final bool showDivider;
  final String? svgIcon;
  final double? spaceTile;
  final double? horizontalPadding;

  const CustomListTile(
      {super.key,
      required this.onTap,
      this.leadingWidget,
      this.title,
      this.text,
      this.subtitle,
      this.trailingIcon,
      this.trailingWidget,
      this.showDivider = true,
      this.svgIcon,
      this.spaceTile,
      this.horizontalPadding});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 30.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircularContainer(
              color: AppColors.tedVeryLightPurple,
              size: 40,
              child: SvgPicture.asset(svgIcon ?? ''),
            ),
            20.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                5.verticalSpace,
                Text(
                  subtitle ?? '',
                  textScaler: const TextScaler.linear(1.1),
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: "Nexa",
                      fontSize: 12.sp),
                ),
              ],
            ),
            const Spacer(),
            trailingWidget ??
                SvgPicture.asset(
                    trailingIcon ?? AssetResources.shortRightArrow),
          ],
        ),
      ),
    );
  }
}
