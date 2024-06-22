import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tedfinance_mobile/shared/models/dashboard_models/card_bal_model.dart';
import '../../../../providers/dashboard_provider.dart';
import '../../../../shared/models/dashboard_models/current_ex_model.dart';
import '../../../../shared/navigations/routes/navigation_service.dart';
import '../../../../shared/util/asset_images.dart';
import '../../../../shared/util/widgets/appbar.dart';
import '../../../../shared/util/widgets/custom_containers.dart';
import '../../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../../shared/util/widgets/custom_text_form_field.dart';
import '../../../../theme/custom_text_style.dart';
import '../../../env/utils/colors.dart';
import '../../../env/utils/string_resources.dart';
import '../../../utililies.dart';
import 'enter_pin.dart';

class WithdrawFunds extends StatefulWidget {
  const WithdrawFunds({super.key});

  @override
  State<WithdrawFunds> createState() => _WithdrawFundsState();
}

class _WithdrawFundsState extends State<WithdrawFunds> {
  final TextEditingController _amountController = TextEditingController();
  CurrentFxModel? currentFxModel;
  CardBalModel? cardBalModel;
  double? _amount;
  double? _exchangeRate;
  double? _convertedAmount;
  String? _formattedAmount;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      Provider.of<DashboardProvider>(context, listen: false)
          .getCardBalance()
          .then((value) => setState(() {
                cardBalModel = value;
              }));
      Provider.of<DashboardProvider>(context, listen: false)
          .getCurrentFxRate()
          .then((value) {
        setState(() {
          currentFxModel = value;
          // currentFxModel = value["currentFxModel"];
          // currentFxModel = value["cardUsdFee"];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TedAppBar(
        elevation: 0,
        titleWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              StringResources.withdraw_funds,
              style: CustomTextStyles.titleMedium18,
            ),
            5.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("USD ${cardBalModel?.balance}",
                    style: CustomTextStyles.bodySmallBlack900),
                5.horizontalSpace,
                SvgPicture.asset(
                  AssetResources.dropdownIcon,
                  height: 10.h,
                  width: 10.w,
                )
              ],
            )
          ],
        ),
        trailing: Container(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Column(
            children: [
              20.verticalSpace,
              CustomTextFormField(
                headerText: "Amount In USD",
                hintText: "USD 0.00",
                controller: _amountController,
              ),
              30.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    GreyCirclesWithLines(
                      circleRadius: 7.0,
                      lineWidth: 2.5,
                      circleColor: AppColors.grey[65]!,
                      lineColor: AppColors.grey[65]!,
                    ),
                    20.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(''),
                        20.verticalSpace,
                        const Text('Rate'),
                        20.verticalSpace,
                        const Text('Fee'),
                        20.verticalSpace,
                        const Text('Amount in NGN'),
                        20.verticalSpace,
                        const Text(''),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '',
                          style:
                              CustomTextStyles.titleMediumBlack600.copyWith(),
                        ),
                        20.verticalSpace,
                        Text(
                          '\$ ${currentFxModel?.rate.toString()}',
                          style:
                              CustomTextStyles.titleMediumBlack600.copyWith(),
                        ),
                        20.verticalSpace,
                        Text(
                          'FREE',
                          style: CustomTextStyles.titleMediumBlack600
                              .copyWith(color: AppColors.tedGreen2),
                        ),
                        20.verticalSpace,
                        ValueListenableBuilder(
                          valueListenable: _amountController,
                          builder: (context, value, child) {
                            _amount =
                                double.tryParse(_amountController.text) ?? 0;
                            _exchangeRate = currentFxModel?.rate ?? 0;
                            _convertedAmount = (_amount! / _exchangeRate!);

                            _formattedAmount =
                                Utilities.formatNumber(_convertedAmount ?? 0);

                            return Text(
                              '${Utilities.nairaSign}$_formattedAmount',
                              style: CustomTextStyles.titleMediumBlack600
                                  .copyWith(),
                            );
                          },
                        ),
                        20.verticalSpace,
                        Text(
                          '',
                          style:
                              CustomTextStyles.titleMediumBlack600.copyWith(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              30.verticalSpace,
              AppButton(
                onPressed: () {
                  PageNavigator(ctx: context).nextPage(
                      page: EnterPinVirtualSheet(
                    originPage: "Withdraw Fund",
                    amountUSD: _amountController.text,
                  ));
                },
                text: 'Continue',
                radius: 30.r,
                width: 350.w,
              )
            ],
          ),
        ),
      ),
    );
  }
}
