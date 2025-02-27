import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/navigations/routes/navigation_service.dart';
import '../../../../shared/util/asset_images.dart';
import '../../../../shared/util/widgets/appbar.dart';
import '../../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../env/utils/colors.dart';
import '../../../env/utils/string_resources.dart';
import 'enter_pin.dart';

class DeleteCard extends StatelessWidget {
  const DeleteCard({super.key});

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
    return Scaffold(
        appBar: const TedAppBar(
          elevation: 0,
          titleText: StringResources.delete_card,
          trailing: SizedBox(),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AssetResources.deleteCardImage2),
              30.verticalSpace,
              Text(
                'You’re about to Delete\nyour card',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle:  TextStyle(
                    fontSize: 25.sp,
                    color: AppColors.tedRedColor2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              20.verticalSpace,
              const Text(
                "Your card **** **** **** 3098 will be deleted,\n"
                "request for a replacement to continue\n"
                "making payments.",
                textAlign: TextAlign.center,
              ),
              60.verticalSpace,
              AppButton(
                onPressed: () {
                  PageNavigator(ctx: context)
                      .nextPage(page: const EnterPinVirtualSheet());
                },
                text: 'Continue',
                radius: 30.r,
              )
            ],
          ),
        ));
  }
}
