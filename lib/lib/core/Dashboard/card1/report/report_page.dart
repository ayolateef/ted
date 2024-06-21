import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tedfinance_mobile/core/Dashboard/card1/report/report_history.dart';
import 'package:tedfinance_mobile/shared/navigations/routes/navigation_service.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';

import '../../../../shared/util/widgets/appbar.dart';
import '../../../../shared/util/widgets/custom_containers.dart';
import '../../../../theme/custom_text_style.dart';
import '../../../env/utils/string_resources.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final List<PaymentContainer> itemList = [
     const PaymentContainer(
      imagePath: AssetResources.sendIcon,
      titleText: StringResources.send_money,
      subTitleText: StringResources.report_trans_history,
      isSvg: true,

    ),
    const PaymentContainer(
      imagePath: AssetResources.virtualCards,
      titleText: StringResources.virtual_cards,
      subTitleText: StringResources.report_trans_history,
      isSvg: true,
      icon: Icons.arrow_forward_ios_rounded,

    ),
    const PaymentContainer(
      imagePath: AssetResources.walletPurpleIcon,
      titleText: StringResources.wallet,
      subTitleText: StringResources.funds_reports_exchange,
      isSvg: true,
      icon: Icons.arrow_forward_ios_rounded,

    ),
    const PaymentContainer(
      imagePath: AssetResources.addPayIcon,
      titleText: StringResources.multi_virtual_account,
      subTitleText: StringResources.funds_reports_exchange,
      isSvg: true,
      icon: Icons.arrow_forward_ios_rounded,

    ),
    // Add more items as needed
  ];




  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: const TedAppBar(
          elevation: 0,
          titleText: StringResources.report,
          trailing: SizedBox(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Column(

            children: [
              Center(
                child: Text(StringResources.transactions_reports,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.titleSmallBlack900_1.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                    )
                ),
              ),
      20.verticalSpace,
      Expanded(
        child: ListView.separated(
          itemCount: itemList.length,
          itemBuilder: (context, index) {
            final item = itemList[index];
            return PaymentContainer(
              imagePath: item.imagePath,
              titleText: item.titleText,
              subTitleText: item.subTitleText,
              isSvg: item.isSvg,
              icon: item.icon,
              onTap: () {
                PageNavigator(ctx: context).nextPage(page: const ReportsHistory());
              },
            );
          }, separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 40.h,);
        },
        ),
      )

      ],
          ),
        ));
  }
}
