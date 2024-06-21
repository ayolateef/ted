import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:google_fonts/google_fonts.dart';
import '../asset_images.dart';
import 'messenger.dart';

class CopyButton extends StatelessWidget {
  final String? text;
  const CopyButton({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: text ?? ""));
        NotificationMessager.showSuccess(context,
            message: "Copied to clipboard");
      },
      child: Container(
        height: 32.h,
        width: 82.w,
        // decoration: BoxDecoration(
        //     color: AppColors.primaryColor,
        //     borderRadius: BorderRadius.circular(38.r)),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Copy",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600)),
          2.horizontalSpace,
          SvgPicture.asset(AssetResources.copyIcon)
        ]),
      ),
    );
  }
}
