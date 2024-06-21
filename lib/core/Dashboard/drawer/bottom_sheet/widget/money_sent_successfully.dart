import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tedfinance_mobile/core/env/utils/string_resources.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';

import '../../../../../shared/util/widgets/custom_containers.dart';
import '../../../../env/utils/colors.dart';

class MoneySentSuccessSheet extends StatelessWidget {
  const MoneySentSuccessSheet({super.key});

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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 35.h),
      child: ClipPath(
        clipper: MyTopClipper(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.4,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(AssetResources.moneySent),
                20.verticalSpace,
                ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return gradient.createShader(bounds);
                    },
                    blendMode: BlendMode.srcIn,
                    child: const Text(
                      StringResources.money_sent_successfully,
                      textScaler: TextScaler.linear(1.1),
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                10.verticalSpace,
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'You have Sent ',
                      ),
                      TextSpan(
                        text: '\$4,500.97',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight:
                              FontWeight.w500, // Adjust font weight as needed
                        ),
                      ),
                      TextSpan(
                        text: ' to ',
                      ),
                      TextSpan(
                        text: 'Temitayo',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: ' successfully.',
                      ),
                    ],
                  ),
                ),
                50.verticalSpace,
                AppButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  text: 'Done',
                  radius: 30.r,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
