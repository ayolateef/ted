import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tedfinance_mobile/core/Dashboard/card1/transfer/send_with_username.dart';
import 'package:tedfinance_mobile/theme/custom_text_style.dart';
import '../../../../shared/navigations/routes/navigation_service.dart';
import '../../../../shared/util/asset_images.dart';
import '../../../../shared/util/widgets/appbar.dart';
import '../../../../shared/util/widgets/custom_containers.dart';
import '../../../env/utils/string_resources.dart';
import 'bank_account_details.dart';


class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        appBar: const TedAppBar(
          elevation: 0,
          titleText: StringResources.transfer,
          trailing: SizedBox(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
                children: [
          Text(StringResources.transfer_from_wallet,
            textAlign: TextAlign.center,
            style: CustomTextStyles.titleSmallBlack900_1.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400
            )
          ),
          50.verticalSpace,
          PaymentContainer(
            onTap: () {
              pushToWithRoute(context, CustomRoutes.slideUp(const BankAccountDetails()));
             // addPaymentMethodSheet(context: context);
            },
            imagePath: AssetResources.addPayIcon,
            titleText: StringResources.bank,
            subTitleText: StringResources.send_bank_account,
            icon: Icons.arrow_forward_ios,
            isSvg: true,
          ),
          40.verticalSpace,
          PaymentContainer(
            onTap: () {
             // sendWithUernameSheet(context: context);
              PageNavigator(ctx: context).nextPage(page: const SendWithUsername());

            },
            imagePath: AssetResources.addPayIcon,
            titleText: StringResources.username,
            subTitleText: StringResources.send_to_other,
            icon: Icons.arrow_forward_ios,
            isSvg: true,

          )

                ],
              ),
        ));
  }
}
