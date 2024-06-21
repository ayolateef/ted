import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tedfinance_mobile/core/Dashboard/card1/send/verifying_payment.dart';
import 'package:tedfinance_mobile/shared/navigations/routes/navigation_service.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_checkbox_button.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_text_form_field.dart';

import '../../../../shared/util/widgets/appbar.dart';
import '../../../env/utils/string_resources.dart';

class CardDetails extends StatefulWidget {
  const CardDetails({super.key});

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TedAppBar(
            elevation: 0,
            titleText: StringResources.card_details,
            trailing: Container()),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Image.asset(AssetResources.masterCard2),
                      10.horizontalSpace,
                      Image.asset(AssetResources.visaCard2),
                      10.horizontalSpace,
                      Image.asset(AssetResources.americaExpress2),
                      10.horizontalSpace,
                      Image.asset(AssetResources.discoverCard2)
                    ],
                  ),
                ),
                const CustomTextFormField(
                  headerText: "Card Number",
                  hintText: "0000 0000 0000 0000",
                ),
                30.verticalSpace,
                Row(
                  children: [
                    const Expanded(
                      child: CustomTextFormField(
                        headerText: "Expiry Date",
                        hintText: "MM/YY",
                      ),
                    ),
                    40.horizontalSpace,
                    const Expanded(
                      child: CustomTextFormField(
                        headerText: "CVV",
                        hintText: "CVV",
                      ),
                    ),
                  ],
                ),
                30.verticalSpace,
                const CustomTextFormField(
                  headerText: "Card Holder’s Name",
                  hintText: "Andrew Michael ",
                ),
                30.verticalSpace,
                CustomCheckboxButton(
                  value: _isChecked,
                  onChange: (newValue) {
                    setState(() {
                      _isChecked = newValue;
                    });
                  },
                  iconSize: 24,
                  text: "Save card Details",
                  textStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                  textAlignment: TextAlign.left,
                  isExpandedText: true,
                ),
                100.verticalSpace,
                Center(
                  child: AppButton(
                    onPressed: () {
                      PageNavigator(ctx: context).nextPage(page: const VerifyingPayment());
                    },
                    text: 'Continue',
                    radius: 20.r,
                  ),
                )
              ],
            ),
          ),
        )

    );
  }
}
