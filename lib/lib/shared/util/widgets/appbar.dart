import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';

import '../../../core/env/utils/colors.dart';
import '../../../theme/custom_text_style.dart';
import '../../navigations/routes/navigation_service.dart';

class TedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leadingIcon;
  final String? titleText;
  final Widget? titleWidget;
  final Widget? trailing;
  final Color? backgroundColor;
  final bool centerTitle;
  final double? elevation;
  final Color? shadowColor;
  final double? appHeight;
  final double? leadingWidth;
  final bool showUnderline;

  const TedAppBar(
      {Key? key,
      this.leadingIcon,
      this.titleText,
      this.titleWidget,
      this.trailing,
      this.centerTitle = true,
      this.elevation = 0,
      this.shadowColor = Colors.white,
      this.backgroundColor,
      this.leadingWidth = 56.0,
      this.appHeight = 56,
      this.showUnderline = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      shadowColor: shadowColor,
      backgroundColor: backgroundColor ?? AppColors.white,
      leadingWidth: leadingWidth,
      toolbarHeight: 74.h,
      centerTitle: centerTitle,
      // bottom: PreferredSize(
      //   preferredSize: Size(1.sw, 1.h),
      //   child: showUnderline
      //       ? Divider(
      //           height: 1.h,
      //           color: AppColors.tedGrey,
      //         )
      //       : const SizedBox(),
      // ),
      title: titleWidget ??
          Text(
            titleText ?? "",
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600
              )
            )
          ),
      leading: leadingIcon ??
          IconButton(
              onPressed: () {
                pop(context);
             //Navigator.of(context).pop();
            },
            icon: SvgPicture.asset(AssetResources.shortLeftArrow,)
          ),
      actions: [Padding(
        padding:  EdgeInsets.symmetric(horizontal:28.h),
        child: trailing ??  SvgPicture.asset(AssetResources.shortRightArrow),
      )],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appHeight!);
}


class TedTopWidget extends StatelessWidget {
  final Widget? leadingIcon;
  final String? titleText;
  final Widget? titleWidget;
  final Widget? trailing;
  final Color? backgroundColor;
  final bool centerTitle;
  final double? elevation;
  final Color? shadowColor;
  final double? appHeight;
  final double? leadingWidth;
  final bool showUnderline;
  final Function()? rightIconOnTap;

  const TedTopWidget(
      {Key? key,
        this.leadingIcon,
        this.titleText,
        this.titleWidget,
        this.trailing,
        this.centerTitle = true,
        this.elevation = 0,
        this.shadowColor = Colors.white,
        this.backgroundColor,
        this.leadingWidth = 56.0,
        this.appHeight = 56,
        this.showUnderline = false,
        this.rightIconOnTap
        
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: appHeight,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
            border: Border(
              bottom: BorderSide(
                color: showUnderline ? Colors.grey : Colors.transparent,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              leadingIcon ??
                  GestureDetector(
                    onTap: () {
                      pop(context);
                    },
                    child: SvgPicture.asset(AssetResources.shortLeftArrow),
                  ),
              titleWidget ??
                  Text(
                    titleText ?? "",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                          )
                      )
                  ),
              GestureDetector(
                onTap: rightIconOnTap,
                child: trailing ??
                    SvgPicture.asset(AssetResources.shortRightArrow),
              ),
            ],
          ),
        ),
      ],
    );
  }
}