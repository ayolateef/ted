import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tedfinance_mobile/core/auth/signup/bottomsheet/widget/pin_success_sheet.dart';

import '../../../env/utils/colors.dart';

var _roundedRectangleBorder = const RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(25),
    topLeft: Radius.circular(25),
  ),
);

void pinSuccessSheet({
  BuildContext? context,
}) {
  showModalBottomSheet(
    context: context!,
    barrierColor: AppColors.primaryColor.withOpacity(0.2),
    shape: _roundedRectangleBorder,
    isScrollControlled: true,
    builder: (context) {
      return const PinSuccessSheet();
    },
  );
}
void welcomeSheet({
  BuildContext? context,
}) {
  showModalBottomSheet(
    context: context!,
    barrierColor: AppColors.primaryColor.withOpacity(0.2),
    shape: _roundedRectangleBorder,
    isScrollControlled: true,
    builder: (context) {
      return const WelcomeSheet();
    },
  );
}