import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tedfinance_mobile/core/Dashboard/drawer/bottom_sheet/root.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_text_form_field.dart';

import '../../../../../shared/util/widgets/appbar.dart';
import '../../../../../shared/util/widgets/custom_containers.dart';
import '../../../../env/utils/colors.dart';
import '../../../../env/utils/string_resources.dart';

class AddPayment extends StatefulWidget {
  const AddPayment({super.key});

  @override
  State<AddPayment> createState() => _AddPaymentState();
}

class _AddPaymentState extends State<AddPayment> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: const TedAppBar(
          elevation: 0,
          titleText: StringResources.add_payment,
          trailing: SizedBox(),
        ),

        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              CustomTextFormField(
                fillColor: AppColors.tedButtonGrey,
                hintText: 'Search',
                suffix: Padding(
                  padding:  EdgeInsets.symmetric(horizontal:  15.0.w, ),
                  child: SvgPicture.asset(AssetResources.searchIcon, height: 20, width: 20,),
                ),
                radius: 30.r,

              ),
              40.verticalSpace,
             PaymentContainer(
                onTap: () {
                  addPaymentMethodSheet(context: context);
                },
                imagePath: AssetResources.addPayIcon,
                titleText: StringResources.add_payment,
                subTitleText: StringResources.method_via_credit,
                icon: Icons.arrow_forward_ios,
                isSvg: true,
              ),
              30.verticalSpace,
               PaymentContainer(
                 onTap: () {
                   confirmWithdrawSheet(context: context);
                 },
                imagePath: AssetResources.picNig,
                titleText: StringResources.ayoLateef,
                 subTitleText: StringResources.kuda,
                isSvg: false,

              )
            ],
          ),
        )
    );
  }
}


