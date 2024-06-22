import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';

import '../../../../providers/dashboard_provider.dart';
import '../../../../shared/models/dashboard_models/card_details_model.dart';
import '../../../../shared/navigations/routes/navigation_service.dart';
import '../../../../shared/util/widgets/appbar.dart';
import '../../../env/utils/colors.dart';
import '../../../env/utils/string_resources.dart';
import 'enter_pin.dart';

class FreezeCard extends StatefulWidget {
  const FreezeCard({super.key});

  @override
  State<FreezeCard> createState() => _FreezeCardState();
}

class _FreezeCardState extends State<FreezeCard> {
  late DashboardProvider dashboardProvider;
  CardDetailsModel? _cardDetails;
  String formatCardNumber(String number) {
    return number.replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ");
  }
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      Provider.of<DashboardProvider>(context, listen: false)
          .getDetailsCard()
          .then((value) {
        setState(() {
          _cardDetails = value;
        });
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
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
                children: [
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
                          ..shader = gradient
                              .createShader(const Rect.fromLTRB(10, 1000, 10, 350))),
                  ),
                ],
              ),
            ),
             Text(
              "You wont be able to make or receive payments\n"
              "on  ${formatCardNumber(_cardDetails?.fullCardPan ?? '')}\n"
              "until your card is unfrozen or, request for a\n"
              "replacement to continue making payments.",
              textAlign: TextAlign.center,
            ),
            20.verticalSpace,
            AppButton(
              onPressed: () {
                pushToWithRoute(context,CustomRoutes.fadeIn(const EnterPinVirtualSheet(originPage: 'FreezeCard')));
              },
              text: 'Continue',
              radius: 30.r,
            )
          ],
        ));
  }


}
