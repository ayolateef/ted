import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../shared/util/asset_images.dart';
import '../../../../../shared/util/widgets/appbar.dart';
import '../../../../../shared/util/widgets/custom_containers.dart';
import '../../../../env/utils/colors.dart';
import '../../../../env/utils/string_resources.dart';
import '../../bottom_sheet/root.dart';
import '../../bottom_sheet/widget/emeralds_sheet.dart';

class AccountTier extends StatefulWidget {
  const AccountTier({super.key});

  @override
  State<AccountTier> createState() => _AccountTierState();
}

class _AccountTierState extends State<AccountTier> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: const TedAppBar(
          elevation: 0,
          titleText: StringResources.account_tiers,
          trailing: SizedBox(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 15.w, vertical: 40.h),
            child: Column(
                  children: [
            PaymentContainer(
              onTap: () {
                rubyLimitSheet(context: context);
              },
              imagePath: AssetResources.tier1,
              titleText: StringResources.ruby,
              subTitleText: StringResources.you_send_2000,
              icon: Icons.arrow_forward_ios,
              isSvg: false,
            ),
            30.verticalSpace,
            PaymentContainer(
              onTap: () {
                emeraldSheet(context: context);
              },
              imagePath: AssetResources.tier2,
              titleText: StringResources.emerald,
              subTitleText: StringResources.send_upto_usd,
              icon: Icons.arrow_forward_ios,
              isSvg: false,
            ),

                  ],
                ),
          ),
        ));
  }
}












class CircleWidget extends StatelessWidget {
  final Color color;
  final IconData? icon;
  final VoidCallback? onTap;

  const CircleWidget({
    Key? key,
    required this.color,
    this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(
            color: AppColors.white,
            style: BorderStyle.none,
          ),
        ),
        child: CustomPaint(
          painter: ZigzagPainter(
            strokeWidth: 1,
            strokeColor: AppColors.white,
          ),
          child: icon != null
              ? Icon(
            icon,
            color: Colors.white,
            size: 15,
          )
              : null,
        ),
      )
    );
  }
}



class GreyLineWidget extends StatelessWidget {
  final double height;

  const GreyLineWidget({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      height: height,
      color: AppColors.grey[65],
    );
  }

}
class ZigzagPainter extends CustomPainter {
  final double strokeWidth;
  final Color strokeColor;

  ZigzagPainter({
    required this.strokeWidth,
    required this.strokeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path();
    final double radius = size.width / 2;

    for (double i = 0; i < 360; i += 10) {
      final double x1 = radius + radius * cos(i * pi / 180);
      final double y1 = radius + radius * sin(i * pi / 180);
      final double x2 = radius + radius * cos((i + 10) * pi / 180);
      final double y2 = radius + radius * sin((i + 10) * pi / 180);

      if (i % 20 == 0) {
        path.moveTo(x1, y1);
      } else {
        path.lineTo(x1, y1);
      }

      if (i % 20 == 10) {
        path.lineTo(x2, y2);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant ZigzagPainter oldDelegate) {
    return false;
  }
}
