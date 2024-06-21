import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tedfinance_mobile/shared/models/dashboard_models/fund_card_model.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';

import '../../../../providers/dashboard_provider.dart';
import '../../../../shared/models/dashboard_models/card_bal_model.dart';
import '../../../../shared/models/dashboard_models/current_ex_model.dart';
import '../../../../shared/models/dashboard_models/wallet_model.dart';
import '../../../../shared/navigations/routes/navigation_service.dart';
import '../../../../shared/util/shimmer.dart';
import '../../../../shared/util/widgets/appbar.dart';
import '../../../../shared/util/widgets/custom_containers.dart';
import '../../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../../shared/util/widgets/custom_text_form_field.dart';
import '../../../../theme/custom_text_style.dart';
import '../../../env/utils/alert_toast.dart';
import '../../../env/utils/colors.dart';
import '../../../env/utils/string_resources.dart';
import '../../../utililies.dart';
import 'enter_pin.dart';

class AddFundToCard extends StatefulWidget {
  const AddFundToCard({super.key});

  @override
  State<AddFundToCard> createState() => _AddFundToCardState();
}

class _AddFundToCardState extends State<AddFundToCard> {
  late DashboardProvider dashboardProvider;
  final TextEditingController _amountController = TextEditingController();
  final selectedCurrency = SelectedCurrency();
  final TextEditingController _fundSourceController = TextEditingController();
  FundCardModel? fundCardModel;
  CurrentFxModel? currentFxModel;
  int? cardUsdFee;
  double? _amount;
  double? _exchangeRate;
  double? _convertedAmount;
  String? _formattedAmount;
  String _selectedCurrency = '';
  CardBalModel? cardBalModel;
  WalletModel? walletModel;

  void _handleSelection(String value) {
    final currency = value.split('-')[0];
    setState(() {
      _selectedCurrency = value;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchWalletInfo();
    Future.microtask(() async {
      Provider.of<DashboardProvider>(context, listen: false)
          .getCurrentFxRate()
          .then((value) {
        setState(() {
          currentFxModel = value;
          // currentFxModel = value["currentFxModel"];
          // cardUsdFee = value["cardUsdFee"];
        });
      });

      Provider.of<DashboardProvider>(context, listen: false)
          .getCardBalance()
          .then((value) {
        setState(() {
          cardBalModel = value;
        });
      });
    });
    }

  Future<void> fetchWalletInfo() async {
    try {
      final walletInfo = await Provider.of<DashboardProvider>(context, listen: false).getWalletInfo();
      setState(() {
        walletModel = walletInfo;

      });
    } catch (e) {
      if (e.toString().contains(e.toString())) {
        setState(() {
          walletModel = null;

        });
      } else {
        rethrow;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: TedAppBar(
          elevation: 0,
          titleWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                StringResources.add_funds_to_card,
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
          child:  Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              children: [
                10.verticalSpace,
                10.verticalSpace,
                CustomTextFormField(
                  headerText: "Source of funds",
                  hintText: "Select Sources of funds",
                  initialValue: _selectedCurrency,
                  controller: _fundSourceController,
                  autofocus: false,
                  onChange: (currency) {
                    _selectedCurrency = currency;
                    setState(() {});
                  },
                  suffix: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DropdownButton(
                      value: _selectedCurrency.isEmpty ? null : _selectedCurrency,
                      underline: Container(height: 0),
                      items: [

                        DropdownMenuItem(
                          value: 'NGN',
                          child: LayoutBuilder(builder: (context, constraints) {
                            return ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 390.w, maxHeight: 100.h), // Adjust the width as necessary
                                child: GestureDetector(
                                  onTap: () => _handleSelection('NGN'),
                                  child: Row(
                                    children: [
                                      Image.asset(AssetResources.nigWhiteFlag2),
                                      SizedBox(width: 10.w),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'NGN',
                                            style: TextStyle(fontWeight: FontWeight.w600,),
                                          ),
                                          Text(
                                            'Nigeria Naira',
                                            style: TextStyle(color: Colors.grey[64], fontSize: 14.sp),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                       Text(
                                        "\₦${walletModel?.accountBalance ?? "0.00"}",
                                        style: const TextStyle(fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                )
                            );
                          }),
                        ),
                      ],
                      onChanged: (value) {
                        _handleSelection(value!);
                      },
                    ),
                  ),
                ),
                20.verticalSpace,
                CustomTextFormField(
                  headerText: "Amount In USD",
                  hintText: "USD 0.00",
                  controller: _amountController,
                  textInputType: TextInputType.number,
                ),
                20.verticalSpace,
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
                          currentFxModel == null
                              ? ShimmerTextWidget(
                              style: TextStyle(
                                color: const Color(0xFF0C111D),
                                fontSize: 14.sp,
                                fontFamily: '',
                                height: 1,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                              )):Text(
                            '\$ ${currentFxModel?.rate.toString()}',
                            style:
                                CustomTextStyles.titleMediumBlack600.copyWith(),
                          ),
                          20.verticalSpace,
                          // currentFxModel == null
                          //     ? ShimmerTextWidget(
                          //     style: TextStyle(
                          //       color: const Color(0xFF0C111D),
                          //       fontSize: 14.sp,
                          //       fontFamily: '',
                          //       height: 1,
                          //       fontStyle: FontStyle.normal,
                          //       fontWeight: FontWeight.w600,
                          //     )):
                   Text(
                            'Free',
                            style: CustomTextStyles.titleMediumBlack600
                                .copyWith(color: AppColors.tedGreen2),
                          ),
                          20.verticalSpace,
                          ValueListenableBuilder(
                            valueListenable: _amountController,
                            builder: (context, value, child) {
                              _amount = double.tryParse(_amountController.text) ?? 0;
                              _exchangeRate = currentFxModel?.rate ?? 0;
                              _convertedAmount = (_amount! / _exchangeRate!);

                              _formattedAmount =
                                  Utilities.formatNumber(_convertedAmount ?? 0);

                              return currentFxModel == null
                                  ? ShimmerTextWidget(
                                  style: TextStyle(
                                    color: const Color(0xFF0C111D),
                                    fontSize: 14.sp,
                                    fontFamily: '',
                                    height: 1,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                  )):Text(
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
                    if (_amountController.text != null &&
                        _amountController.text.isNotEmpty) {
                      pushToWithRoute(
                          context,
                          CustomRoutes.slideIn(EnterPinVirtualSheet(
                            originPage: "Add Fund",
                            amountNGN: _formattedAmount,
                            selectedCurrency: _selectedCurrency,
                            amountUSD: _amountController.text,
                          )));
                    } else {
                      AlertToast(context: context)
                          .showError('Please enter an amount');
                    }
                  },
                  text: 'Continue',
                  radius: 30.r,
                  width: 350.w,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
