import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tedfinance_mobile/shared/models/dashboard_models/card_transactions_model.dart';
import 'package:intl/intl.dart';
import '../../core/env/utils/colors.dart';
import '../../core/utililies.dart';
import '../../theme/custom_text_style.dart';
import 'asset_images.dart';

class WhiteCircularIcons extends StatelessWidget {
  final String? circleText;
  final String? circleSvgIcon;
  final BoxShape? boxShape;
  final Color? circleColor;
  final Color? textColor;
  final double? circleHeight;
  final double? padding;
  final Function()? onTap;
  final double scale;
  const WhiteCircularIcons({
    super.key,
    this.circleText,
    this.circleSvgIcon,
    this.boxShape,
    this.circleColor,
    this.textColor,
    this.circleHeight,
    this.padding,
    this.onTap,
    this.scale = 0.6,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: circleHeight ?? 50.0.h,
            width: 50.0.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: circleColor ?? AppColors.white),
            child: Transform.scale(
                scale: scale,
                child: SvgPicture.asset(circleSvgIcon ?? '',  )),
          ),
          Text(circleText ?? '',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: textColor ?? AppColors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500),
              ))
        ],
      ),
    );
  }
}

class RectangularIcons extends StatelessWidget {
  final String? circleText;
  final String? circleSvgIcon;
  final BoxShape? boxShape;
  final Color? circleColor;
  final Color? textColor;
  const RectangularIcons({
    super.key,
    this.circleText,
    this.circleSvgIcon,
    this.boxShape,
    this.circleColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 46.0.h,
            width: 48.0.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color:
                circleColor ?? AppColors.tedGradientColor2.withOpacity(0.49)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Transform.scale(
                  scale: 1.5,
                  child: SvgPicture.asset(circleSvgIcon ?? '')),
            ),
          ),
          5.verticalSpace,
          Text(circleText ?? '',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: AppColors.black,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500),
              ))
        ],
      ),
    );
  }
}

class PurpleCardWithIcons extends StatelessWidget {
  final Color? cardColor;
  final Widget? widget;

  const PurpleCardWithIcons({super.key, this.cardColor, this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(

      width: 410.w,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.grey[10]!.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(1, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(25.r)

      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(25.r),
          child:
          Card(color: cardColor ?? AppColors.primaryColor, child: widget)),
    );
  }
}

class CustomCard extends StatelessWidget {
  final TransactionsModel transactionsModel;
  // final String image;
  // final String title;
  // final String subtitle;
  // final String trailingText;
  // final String trailingSubtitle;

  const CustomCard({
    Key? key,
    // required this.image,
    // required this.title,
    // required this.subtitle,
    // required this.trailingText,
    // required this.trailingSubtitle,
    required this.transactionsModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(AssetResources.nigWhiteFlag2),

        //SvgPicture.asset(transactionsModel.currency.toString()),
        title: Text(
            transactionsModel.transactionType.toString(),
            style:CustomTextStyles.titleMedium18
        ),
        subtitle: Text(
          transactionsModel.transactionStatus.toString(),
          style: TextStyle(color: AppColors.primaryButtonColor, fontWeight: FontWeight.w400, fontSize: 12.sp),
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '\$${transactionsModel.amount.toString()}',
              style: CustomTextStyles.titleMedium18.copyWith(
                color: AppColors.primaryButtonColor,
              ),
            ),

            Text(
              Utilities.dayMonthFormat(date: transactionsModel.createdAt.toString()),
              style: CustomTextStyles.bodySmallGray500.copyWith(fontSize: 13.sp),
            )

          ],
        ),
      ),
    );
  }
}

class CardSettings extends StatelessWidget {
  final String? svgIcon;
  final dynamic textCard;
  final Function()? onTap;
  const CardSettings({
    super.key,
    this.svgIcon,
    this.textCard,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(svgIcon ?? ''),
          7.verticalSpace,
          textCard is String
              ? Text(
            textCard,
            style: CustomTextStyles.bodySmallBlack900
                .copyWith(fontWeight: FontWeight.w600, fontSize: 10.sp),
          )
              : textCard, // Assuming textCard is a Widget
        ],
      ),
    );
  }
}