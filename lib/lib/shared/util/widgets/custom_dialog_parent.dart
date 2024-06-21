import 'package:flutter/material.dart';
import 'package:tedfinance_mobile/theme/theme_helper.dart';

class CustomDialogParent extends StatelessWidget {
  final Widget child;

  const CustomDialogParent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1.0,
      color: appTheme.gray100.withOpacity(.5),
      type: MaterialType.canvas,
      child: GestureDetector(
          onTap: () {
            // Navigator.of(context).pop();
          },
          child: child),
    );
  }
}
