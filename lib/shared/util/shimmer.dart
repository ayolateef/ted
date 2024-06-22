import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/env/utils/colors.dart';

class ShimmerTextWidget extends StatelessWidget {
  final String text;
  final TextStyle style;

  const ShimmerTextWidget({

    this.text = '#.##',
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: style.color ?? AppColors.tedDeepPurple,
        highlightColor: const Color(0xffEEEFF2).withOpacity(0.4),
        child: Text(text, maxLines: 1, style: style));
  }
}