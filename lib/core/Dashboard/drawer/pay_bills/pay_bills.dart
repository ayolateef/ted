import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tedfinance_mobile/core/env/utils/colors.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/appbar.dart';

import '../../../../shared/util/widgets/custom_containers.dart';
import '../../../../theme/custom_text_style.dart';
import '../../../env/utils/string_resources.dart';
import '../bottom_sheet/root.dart';

class PayBills extends StatelessWidget {
  const PayBills({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar:  TedAppBar(
          elevation: 0,
          titleWidget: Column(
            children: [
              Text(StringResources.pay_bills,
                style: CustomTextStyles.titleMedium18,
              ),
              Text(StringResources.utilities_bills,
                style: CustomTextStyles.bodySmallGray500,
              )
            ],
          ),
          trailing: const SizedBox(),
        ),

        body:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              PaymentContainer(
                onTap: (){
                  airtimeDataSheet(context: context);
                },
                imagePath: AssetResources.airtimeIcon,
                circleColor: AppColors.white,
                isSvg: true,
                titleText: StringResources.buy_airtime,
                subTitleText: StringResources.buy_airtime_data,
                icon: Icons.arrow_forward_ios_rounded,
              ),
              30.verticalSpace,
              PaymentContainer(
                onTap: (){
                  utilitiesSheet(context: context);
                },
                imagePath: AssetResources.utilitiesIcon,
                circleColor: AppColors.white2,
                isSvg: true,
                titleText: StringResources.utilities,
                subTitleText: StringResources.pay_electricity,
                icon: Icons.arrow_forward_ios_rounded,
              )
            ],
          ),
        ));
  }
}
