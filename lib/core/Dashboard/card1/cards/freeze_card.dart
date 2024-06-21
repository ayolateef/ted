import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';

import '../../../../shared/navigations/routes/navigation_service.dart';
import '../../../../shared/util/widgets/appbar.dart';
import '../../../env/utils/colors.dart';
import '../../../env/utils/string_resources.dart';
import 'enter_pin.dart';

class FreezeCard extends StatelessWidget {
  const FreezeCard({super.key});

  @override
  Widget build(BuildContext context) {
    var gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xffDA5ED8),
        const Color(0xffB854B7),
        AppColors.black
      ],
    );
    return  Scaffold(
        appBar: const TedAppBar(
          elevation: 0,
          titleText: StringResources.freeze_card,
          trailing: SizedBox(),
        ),
        body: Column(
      children: [
        Image.asset(AssetResources.freezeCardImage),
        0.verticalSpace,
        Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 28.sp,
            ),
            children:  [
              const TextSpan(
                text: ' You’re about to freeze\n',
                style: TextStyle(
                  color: AppColors.tedGradientColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: 'your card',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  foreground: Paint()
                    ..shader = gradient.createShader(
                      Rect.fromLTRB(10, 1000, 10, 350)
                    )
                    ),
                ),
            ],
          ),
        ),
        const Text("You wont be able to make or receive payments\n"
          "on **** **** **** 3098\n"
          "until your card is unfrozen or, request for a\n"
          "replacement to continue making payments.",
        textAlign: TextAlign.center,
        ),
20.verticalSpace,
        AppButton(
          onPressed: (){
            PageNavigator(ctx: context).nextPage(page: const EnterPinVirtualSheet());

          },
          text: 'Continue',
          radius: 30.r,
        )

      ],
    ));
  }
}
