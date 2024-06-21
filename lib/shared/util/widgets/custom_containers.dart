
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/env/utils/colors.dart';
import '../../../core/env/utils/string_resources.dart';
import '../../../theme/custom_text_style.dart';
import '../asset_images.dart';


class PaymentContainer extends StatelessWidget {
  final IconData? icon;
  final String? titleText;
  final String? subTitleText;
  final String? imagePath;
  final bool isSvg;
  final Function()? onTap;
  final double? scale;
  final Color? circleColor;

  const PaymentContainer({super.key,
    this.icon,
    this.titleText,
    this.subTitleText,
    this.imagePath,
    required this.isSvg,
    this.onTap,
    this.scale, this.circleColor,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipPath(
        clipper: MyClipper(),
        child: Container(
          height: 150.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow:   [
              BoxShadow(
                color: AppColors.tedGrey.withOpacity(0.6),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(2, 0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    CircleAvatarImage(
                      imagePath: imagePath  ?? '',
                      isSvg: isSvg,
                      scale: scale ?? 1.1,
                      circleColor: circleColor ,

                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(titleText ?? '' ,
                            overflow: TextOverflow.fade,

                            style: CustomTextStyles.titleLargeBlack ),
                        Text(subTitleText ?? ' ', style: CustomTextStyles.titleSmallGray500  ),
                      ],
                    ),
                    const Spacer(),
                    Icon(  icon, size: 20, color: AppColors.tedDeepPurple,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GeneralContainer extends StatelessWidget {
  final Widget widget;
  final double? horizontal;

  final double? height;


  final double? vertical;
  const GeneralContainer({super.key, required this.widget, this.horizontal, this.vertical, this.height});


  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        height: height ,
          padding: EdgeInsets.symmetric(horizontal: horizontal ?? 18.w, vertical: vertical ?? 20.h),
          decoration: BoxDecoration(
              boxShadow:   [
                BoxShadow(
                  color: AppColors.tedGrey.withOpacity(0.6),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(2, 0),
                ),
              ],
              borderRadius: BorderRadius.circular(2.r),
              color: AppColors.white2),
          child:widget ),
    );
  }
}



class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var smallLineLength = size.width / 20;
    const  smallLineHeight = 10;
    var path = Path();

    path.lineTo(0, size.height);
    for (int i = 1; i <= 25; i++) {
      if (i % 2 == 0) {
        path.lineTo(smallLineLength * i, size.height);
      } else {
        path.lineTo(smallLineLength * i, size.height - smallLineHeight);

      }
    }
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper old) => false;
}

class MyTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var smallLineLength = size.width / 20.0;
    const smallLineHeight = 10.0;
    var path = Path();

    // Move to the top left corner
    path.moveTo(0, 0);

    // Zigzag path on the top
    for (int i = 1; i <= 25; i++) {
      if (i % 2 == 0) {
        path.lineTo(smallLineLength * i, 0);
      } else {
        path.lineTo(smallLineLength * i, smallLineHeight);
      }
    }

    // Connect to the bottom right corner
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper old) => false;
}





class ReportsContainer extends StatelessWidget {

  final String? titleText;
  final String? subTitleText;
  final String? imagePath;
  final bool isSvg;
  final Function()? onTap;
  final String? trailingText;
  final String? subTrailingText;
  final Color? circleColor;
  const ReportsContainer({
    super.key,
    this.titleText,
    this.subTitleText,
    this.imagePath,
    required this.isSvg,
    this.onTap,
    this.trailingText,
    this.subTrailingText, this.circleColor
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  CircleAvatarImage(
                    imagePath: imagePath  ?? '',
                    isSvg: isSvg,
                    circleRadius: 39 * .5,
                    circleColor: circleColor,

                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(titleText ?? '' ,style: CustomTextStyles.titleLargeBlack.copyWith(
                        fontSize:15.sp
                      ) ),
                      Text(subTitleText ?? ' ', style: CustomTextStyles.titleSmallGray500
                              .copyWith(color: AppColors.primaryColor, fontSize:11.sp)
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Text(trailingText ?? '' ,style: CustomTextStyles.titleLargeBlack.copyWith(
                          fontSize:13.sp,
                        color: AppColors.primaryColor,
                      ) ),
                      Text(subTrailingText ?? '' ,style: CustomTextStyles.titleSmallGray500.copyWith(
                          fontSize:10.sp
                      )),


                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CircleAvatarImage extends StatelessWidget {
  final String imagePath;
  final double? circleRadius;
  final bool isSvg;
  final double scale;
  final Color? circleColor;
  final double elevation;

  const CircleAvatarImage({
    Key? key,
    required this.imagePath,
    required this.isSvg,
    this.scale = 1.1,
    this.circleRadius,
    this.circleColor,
    this.elevation = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = 69;
    double height = 69;
    double radius = 0.5 * (width < height ? width : height);
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: elevation > 0.0 ? 0.7 : 0.0,
            blurRadius: elevation,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: circleRadius ?? radius,
        backgroundColor: circleColor ?? AppColors.white2,
        child: isSvg
            ? Transform.scale(
          scale: scale,
          child: SvgPicture.asset(imagePath),
        )
            : Image.asset(imagePath),
      ),
    );
  }
}



class CircularContainer extends StatelessWidget {
  final double size;
  final Color color;
  final Widget child;
  final Function()? onTap;

  const CircularContainer({
    super.key,
    required this.size,
    required this.color,
    required this.child,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}

class EmeraldTextIcon extends StatelessWidget {
  String? firstText;
  String? secondText;
  final Function()? onTap;
  EmeraldTextIcon({super.key, this.firstText, this.secondText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                firstText ?? '',
                style: CustomTextStyles.titleLargeBlack,
              ),
              Text(
                secondText ?? '',
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
          120.horizontalSpace,
          SvgPicture.asset(AssetResources.shortRightArrow)
        ],
      ),
    );
  }
}

class CirclesAndLinesScreen extends StatelessWidget {
  const CirclesAndLinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleWithLine(),
            const CircleWithLine(isGreen: true),
            CircleWithLine(
                isRed: true,
                onPressed: () {
                  // Add code to pop up a bottom sheet here
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 200,
                        color: Colors.white,
                        child: const Center(
                          child: Text('This is a bottom sheet'),
                        ),
                      );
                    },
                  );
                }),
            const CircleWithLine(),
          ],
        ),
      ),
    );
  }
}

class CircleWithLine extends StatelessWidget {
  final bool isGreen;
  final bool isRed;
  final VoidCallback? onPressed;

  const CircleWithLine({
    Key? key,
    this.isGreen = false,
    this.isRed = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor:
          isRed ? Colors.red : (isGreen ? Colors.green : Colors.grey),
          child: isRed
              ? const Icon(
            Icons.close,
            color: Colors.white,
          )
              : (isGreen
              ? const Icon(
            Icons.check,
            color: Colors.white,
          )
              : null),
        ),
        const SizedBox(height: 10),
        Container(
          height: 20,
          width: 2,
          color: Colors.grey,
        ),
      ],
    );
  }
}





class GreyCirclesWithLines extends StatelessWidget {
  final double circleRadius;
  final double lineWidth;
  final Color circleColor;
  final Color lineColor;

  const GreyCirclesWithLines({
    Key? key,
    this.circleRadius = 6.0,
    this.lineWidth = 2.8,
    this.circleColor = Colors.grey,
    this.lineColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildCircle(),
        _buildLine(),
        _buildCircle(),
        _buildLine(),
        _buildCircle(),
        _buildLine(),
        _buildCircle(),
        _buildLine(),
        _buildCircle(),
      ],
    );
  }

  Widget  _buildCircle() {
    return Container(
      width: circleRadius * 2,
      height: circleRadius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: circleColor,
      ),
    );
  }

  Widget  _buildLine() {
    return Container(
      width: lineWidth,
      height: 20,
      color: lineColor,
    );
  }
}
 class BuildLine extends StatelessWidget {
   final double lineWidth;
   final Color? lineColor;
   const BuildLine({super.key,
     this.lineWidth = 3.8,
     this.lineColor,
   });

   @override
   Widget build(BuildContext context) {
     return Container(
       width: lineWidth,
       height: 20,
       color: lineColor ?? AppColors.grey[65]!,
     );
   }
 }

class BuildCircle extends StatelessWidget {
  final double circleRadius;
  final Color lineColor;
  final Color? circleColor;
  const BuildCircle({super.key,
    this.circleRadius = 10.0,
    this.lineColor = Colors.grey,
    this.circleColor

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: circleRadius * 2,
      height: circleRadius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: circleColor ?? AppColors.grey[65]!,
      ),
    );
  }
}





class AddFundContainer extends StatelessWidget {
  final String? svgIcon;
  final String? text;
  final Color? containerColor;
  final Function()? onTap;
  final double? heightContainer;
  final double? widthContainer;
  const AddFundContainer({
    super.key, this.svgIcon, this.text, this.containerColor, this.onTap, this.heightContainer, this.widthContainer,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: heightContainer ?? 30.h,
          width: widthContainer ??  98.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color: containerColor ??  AppColors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(svgIcon ?? AssetResources.plusIcon),
              5.horizontalSpace,
              Text(
                text ?? StringResources.add_funds,
                style: CustomTextStyles
                    .titleMediumPurple16
                    .copyWith(
                    fontSize: 13.sp,
                    color: AppColors.tedPurpleText,
                    fontWeight: FontWeight.w600),
              ),
            ],
          )),
    );
  }
}


class AnalysisContainer extends StatelessWidget {
  String text;
  bool isSelected;
  final Function()? onTap;
   AnalysisContainer({super.key, required this.text, required this.isSelected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.black2 : AppColors.grey[95],
          borderRadius: BorderRadius.circular(12.0.r),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.0.sp,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
