import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/env/utils/colors.dart';
import '../../../theme/custom_text_style.dart';

class StepperContainer extends StatefulWidget {
  final String svgIcon;
  final String rowText;
  final BoxDecoration? boxDecoration;
  final double padding;
  final int currentStep;
  final int totalSteps;
  final String? longText;
  final VoidCallback? onNextStep;

  const StepperContainer({super.key,
    required this.svgIcon,
    required this.rowText,
    this.boxDecoration,
    this.padding = 8.0,
    required this.currentStep,
    required this.totalSteps,
    this.longText,
    this.onNextStep,
  });

  @override
  _StepperContainerState createState() => _StepperContainerState();
}

class _StepperContainerState extends State<StepperContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onNextStep,
      child: Container(
        height: 150.h,
        decoration: BoxDecoration(
          color: AppColors.grey[65]?.withOpacity(0.2),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Stepper(
          steps: [
            Step(
              title:  Column(
                children: [

                  const SizedBox(width: 5.0),
                  Row(
                    children: [
                      Container(
                        height: 60.h,
                        width: 68.w,
                        padding: EdgeInsets.all(widget.padding),
                        decoration: widget.boxDecoration,
                        child: SvgPicture.asset(widget.svgIcon),
                      ),
                      const SizedBox(width: 20.0), // Fixed horizontal space
                      Text(
                        widget.rowText,
                        style: CustomTextStyles.titleMedium18,
                      ),
                    ],
                  ),
                  Text(
                    widget.longText ?? '',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              content: Text(' '),


            )
          ],
          // children: [
          //
          //   const SizedBox(width: 20.0), // Fixed vertical space
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     for (int i = 0; i < widget.totalSteps; i++) // Dynamic circle generation
            //       _buildStepCircle(i),
            //     const SizedBox(width: 5.0), // Spacing after circles
            //   ],
            // ),
          //   const SizedBox(height: 5.0), // Spacing after circles
          //   Expanded( // Use Expanded for remaining space
          //     child: Text(
          //       widget.longText ?? '',
          //       style: GoogleFonts.poppins(
          //         textStyle: TextStyle(
          //           fontSize: 12.sp,
          //           fontWeight: FontWeight.w400,
          //         ),
          //       ),
          //     ),
          //   ),
          // ],
        ),
      ),
    );
  }

  Widget _buildStepCircle(int stepIndex) {
    final isActive = stepIndex <= widget.currentStep;
    final color = isActive ? Colors.black : Colors.grey;
    return Container(
      width: 30.0,
      height: 30.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Center(
        child: Text(
          '${stepIndex + 1}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
}