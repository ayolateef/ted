import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../shared/navigations/routes/navigation_service.dart';
import '../../../../../shared/util/asset_images.dart';
import '../../../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../../../shared/util/widgets/point.dart';
import '../../../../../theme/custom_text_style.dart';
import '../../../../env/utils/colors.dart';
import '../../../../env/utils/string_resources.dart';

class RubyLimitSheet extends StatelessWidget {
  const RubyLimitSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 8.h),
      child: SizedBox(
        height: 327,
        child: Column(
          children: [
            Text(StringResources.ruby_limit, style: CustomTextStyles.titleLargeBlack),
            30.verticalSpace,
            Container(
              padding:  EdgeInsets.symmetric(horizontal: 18.w, vertical: 20),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10.r)),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       SvgPicture.asset(AssetResources.stepperIcon2),
                      20.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          90.verticalSpace,
                          Text('Receive (per transaction)'),
                          20.verticalSpace,
                          Text('Sending (per transaction)'),
                          18.verticalSpace,
                          Text('Balance Limit'),
                        ],
                      ),
                      50.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          90.verticalSpace,
                          Text('Balance Limit',
                              style:
                              CustomTextStyles.titleSmallBlack400.copyWith(
                                fontWeight: FontWeight.w600,
                              )),
                          20.verticalSpace,
                          Text('USD 2,000',
                              style:
                              CustomTextStyles.titleSmallBlack400.copyWith(
                                fontWeight: FontWeight.w600,
                              )),
                          18.verticalSpace,
                          Text(
                            'USD 50,000',
                            style: CustomTextStyles.titleSmallBlack400.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          18.verticalSpace,
                        ],
                      )
                    ],
                  ),
                  10.verticalSpace,
                  AppButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // PageNavigator(ctx: context).nextPage(page: const TransferPage());
                    },
                    text: 'Upgrade to Emerald',
                    width: 350.w,
                    color: AppColors.primaryColor,
                    radius: 30.r,
                  )
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
