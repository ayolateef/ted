import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tedfinance_mobile/core/env/utils/colors.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_text_form_field.dart';

import '../../../../shared/util/widgets/appbar.dart';
import '../../../env/utils/string_resources.dart';
import '../../drawer/bottom_sheet/root.dart';

class ExchangeCurrency extends StatefulWidget {
  const ExchangeCurrency({super.key});

  @override
  State<ExchangeCurrency> createState() => _ExchangeCurrencyState();
}

class _ExchangeCurrencyState extends State<ExchangeCurrency> {
  String? _selectedUSACurrency;
  String? _selectedNGNCurrency;

  @override
  void initState() {
    super.initState();
    _selectedUSACurrency = 'USD';
    _selectedNGNCurrency = 'NGN';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TedAppBar(
          elevation: 0,
          titleText: StringResources.exchange_currency,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              SvgPicture.asset(AssetResources.exchangeCurrency2),
              20.verticalSpace,
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: AppColors.white,
                  ),
                  child: Column(
                    children: [
                      CustomTextFormField(
                        headerText: 'From',
                        hintText: 'Amount',
                        headerTextColor: AppColors.tedGreyText,
                        suffix: Row(
                          children: [
                            const Spacer(),
                            const VerticalDivider(),
                            10.horizontalSpace,
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              // margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                color: AppColors.grey[65],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  // USA flag
                                  Image.asset(
                                    AssetResources.usaFlag2,
                                  ),
                                  // "USD" text
                                  const SizedBox(width: 8),
                                  // Dropdown button
                                  DropdownButton<String>(
                                    value:
                                        _selectedUSACurrency, // Initial value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedUSACurrency = newValue!;
                                      });
                                    },
                                    items: ['USD', 'NGN'].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      20.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AssetResources.blueBackIcon),
                          SvgPicture.asset(AssetResources.redBackIcon)
                        ],
                      ),
                      CustomTextFormField(
                        headerText: 'To',
                        hintText: 'Amount',
                        headerTextColor: AppColors.tedGreyText,
                        suffix: Row(
                          children: [
                            const Spacer(),
                            const VerticalDivider(),
                            10.horizontalSpace,
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              // margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                color: AppColors.grey[65],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  // USA flag
                                  Image.asset(
                                    AssetResources.circularNigFlag2,
                                  ),
                                  // "USD" text
                                  const SizedBox(width: 8),
                                  // Dropdown button
                                  DropdownButton<String>(
                                    value: _selectedNGNCurrency,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedNGNCurrency = newValue!;
                                      });
                                    },
                                    items: ['USD', 'NGN'].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      20.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Currency rate',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: AppColors.tedTextBlue,
                                    fontWeight: FontWeight.w500)),
                          ),
                          Text(
                            '1 USD = 1650 NGN',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle()),
                          )
                        ],
                      ),
                      30.verticalSpace,
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xFFCE2ACD),
                              Color(0xFF000000),
                            ],
                          ),
                        ),
                        child: AppButton(
                          onPressed: () {
                            enterPinSheet(
                                context: context, isFromSellButton: false);
                          },
                          text: 'Exchange',
                          radius: 20.r,
                          height: 50,
                        ),
                      ),
                      30.verticalSpace,
                    ],
                  ))
            ],
          ),
        ));
  }
}

class VerticalDivider extends StatelessWidget {
  final Color? verticalColor;
  final double? margin;
  const VerticalDivider({
    super.key,
    this.verticalColor,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      width: 1,
      color: verticalColor ?? AppColors.grey[3],
      margin: EdgeInsets.symmetric(horizontal: margin ?? 8),
    );
  }
}
