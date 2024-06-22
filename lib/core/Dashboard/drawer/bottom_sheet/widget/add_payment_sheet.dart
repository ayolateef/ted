import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tedfinance_mobile/shared/navigations/routes/navigation_service.dart';
import '../../../../../shared/util/asset_images.dart';
import '../../../../../shared/util/widgets/custom_containers.dart';
import '../../../../../theme/custom_text_style.dart';
import '../../../../env/utils/string_resources.dart';
import '../../../card1/transfer/bank_account_details.dart';

class AddPaymentSheet extends StatelessWidget {
  const AddPaymentSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      height: MediaQuery.of(context).size.height / 2.3,
      child: Column(
        children: [
          Text(StringResources.add_payment,
              style: CustomTextStyles.titleLargeBlack),
          20.verticalSpace,
          PaymentContainer(
            onTap: () {
              Navigator.pop(context);
              PageNavigator(ctx: context)
                  .nextPage(page: const BankAccountDetails());
            },
            imagePath: AssetResources.addPayIcon,
            titleText: StringResources.bank,
            subTitleText: StringResources.addBank,
            icon: Icons.arrow_forward_ios,
            isSvg: true,
          ),
          30.verticalSpace,
          PaymentContainer(
            onTap: () {},
            imagePath: AssetResources.addPayIcon,
            titleText: StringResources.card,
            subTitleText: StringResources.addCard,
            icon: Icons.arrow_forward_ios,
            isSvg: true,
          ),
        ],
      ),
    );
  }
}
