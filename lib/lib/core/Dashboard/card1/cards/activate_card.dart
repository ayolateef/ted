import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tedfinance_mobile/core/Dashboard/kyc/kyc_verification.dart';
import 'package:tedfinance_mobile/shared/navigations/routes/navigation_service.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_containers.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_text_form_field.dart';

import '../../../../providers/dashboard_provider.dart';
import '../../../../shared/models/dashboard_models/card_bal_model.dart';
import '../../../../shared/models/dashboard_models/current_ex_model.dart';
import '../../../../shared/util/asset_images.dart';
import '../../../../theme/custom_text_style.dart';
import '../../../env/utils/colors.dart';
import '../../../env/utils/string_resources.dart';
import '../../../utililies.dart';
import 'enter_pin.dart';

class ActivateCard extends StatefulWidget {
  const ActivateCard({super.key});

  @override
  State<ActivateCard> createState() => _ActivateCardState();
}

class _ActivateCardState extends State<ActivateCard> {
  bool _isLoading = false;
  final TextEditingController _amountController = TextEditingController();
  CurrentFxModel? currentFxModel;
  CardBalModel? cardBalModel;
  double? _amount;
  double? _exchangeRate;
  double? _convertedAmount;
  String? _formattedAmount;
  final TextEditingController _fundSourceController = TextEditingController();
  String _selectedCurrency = '';
  final selectedCurrency = SelectedCurrency();

  void _handleSelection(String value) {
    final currency = value.split('-')[0]; // Get the currency code
    setState(() {
      _selectedCurrency = currency;
    });
  }

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
    return  PopScope(
      canPop: false,
      child: Scaffold(
          body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
            ),
            child: GeneralContainer(
              height: 590,
              vertical: 40.0,
              horizontal: 0.0,
              widget: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: SvgPicture.asset(
                            AssetResources.shortLeftArrow,
                          )),
                      30.horizontalSpace,
                      Text(
                        StringResources.activite_card,
                        style: CustomTextStyles.titleMedium18,
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  const BigPinkContainer(text: StringResources.by_proceeding),
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
                    borderDecoration: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.tedGrey,
                        width: 1,
                      ),
                    ),
                    suffix: DropdownButton(
                      value: _selectedCurrency.isEmpty ? null : _selectedCurrency,
                      underline: Container(height: 0),
                      items: [
                        DropdownMenuItem(
                          value: 'USD',
                          child: LayoutBuilder(builder: (context, constraints) {
                            return ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth: 390.w,
                                  maxHeight: 50), // Adjust the width as necessary
                              child: GestureDetector(
                                onTap: () => _handleSelection('USD'),
                                child: Row(
                                  children: [
                                    Image.asset(AssetResources.usWhiteFlag2),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'USD',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          'United State Dollar',
                                          style: TextStyle(
                                              color: Colors.grey[64],
                                              fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Text(
                                      "\$${cardBalModel?.balance}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                        DropdownMenuItem(
                          value: 'NGN',
                          child: LayoutBuilder(builder: (context, constraints) {
                            return ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth: 390.w,
                                    maxHeight:
                                        100.h), // Adjust the width as necessary
                                child: GestureDetector(
                                  onTap: () => _handleSelection('NGN'),
                                  child: Row(
                                    children: [
                                      Image.asset(AssetResources.nigWhiteFlag2),
                                      SizedBox(width: 10.w),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'NGN',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            'Nigeria Naira',
                                            style: TextStyle(
                                                color: Colors.grey[64],
                                                fontSize: 14.sp),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      const Text(
                                        '\$/0.00',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ));
                          }),
                        ),
                      ],
                      onChanged: (value) {
                        _handleSelection(value!);
                      },
                    ),
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
                            Text(
                              '\$ ${currentFxModel?.rate.toString()}',
                              style:
                                  CustomTextStyles.titleMediumBlack600.copyWith(),
                            ),
                            20.verticalSpace,
                            Text(
                              currentFxModel != null && currentFxModel?.rate != null
                                  ? (currentFxModel!.rate! * 3759.4).toString()
                                  : '0.0', // or some other default value
                              style: CustomTextStyles.titleMediumBlack600.copyWith(color: AppColors.tedGreen2),
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
                      setState(() {
                        _isLoading = true;
                      });
                      pushToWithRoute(context, CustomRoutes.slideIn( const EnterPinVirtualSheet(
                        originPage: "Activate Card")));

                    },
                    text: 'Continue',
                    radius: 30.r,
                    width: 350.w,
                  )
                ],
              ),
            ),
          ),

          // if (_isLoading)
          //   Positioned.fill(
          //     child: Container(
          //       color: Colors.white.withOpacity(0.5),
          //       child: const Center(
          //         child: CircularProgressIndicator(
          //           color: AppColors.primaryColor,
          //         ),
          //       ),
          //     ),
          //   )
        ],
      )),
    );
  }
}
