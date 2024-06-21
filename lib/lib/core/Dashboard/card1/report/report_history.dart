import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tedfinance_mobile/core/Dashboard/drawer/bottom_sheet/root.dart';
import 'package:tedfinance_mobile/shared/navigations/routes/navigation_service.dart';

import '../../../../shared/util/widgets/appbar.dart';
import '../../../../shared/util/widgets/custom_containers.dart';
import '../../../../theme/custom_text_style.dart';
import '../../../env/utils/string_resources.dart';

class ReportsHistory extends StatefulWidget {
  const ReportsHistory({super.key});

  @override
  State<ReportsHistory> createState() => _ReportsHistoryState();
}

class _ReportsHistoryState extends State<ReportsHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TedAppBar(
          elevation: 0,
          titleText: StringResources.report,
          trailing: SizedBox(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Column(
            children: [
              20.verticalSpace,
              Center(
                child: Text(StringResources.transactions_reports_of_money_sent ,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.titleSmallBlack900_1.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    )),
              ),
              20.verticalSpace,
              Expanded(
                child: ListView.separated(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    // Generate ReportsContainer for each report
                    return ReportsContainer(
                      titleText: 'You sent money',
                      subTitleText: 'sent money to Lateef-Kuda',
                      imagePath: 'image.png', // Replace with actual image path
                      isSvg: true,
                      onTap: () {
                 withdrawSuccessSheet(context: context);
                      },
                      trailingText: '5,000,000',
                      subTrailingText: '29-04-2024 6:40pm',
                    );
                  }, separatorBuilder: (BuildContext context, int index) {
                    return 10.verticalSpace;
                },
                ),
              )
            ],
          ),
        ));
  }
}
