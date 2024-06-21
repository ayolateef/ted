import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tedfinance_mobile/core/Dashboard/kyc/kyc_verification.dart';
import 'package:tedfinance_mobile/core/env/utils/colors.dart';
import 'package:tedfinance_mobile/core/env/utils/string_resources.dart';
import 'package:tedfinance_mobile/theme/custom_text_style.dart';

import '../../../shared/util/asset_images.dart';
import '../../../shared/util/widgets/custom_checkbox_button.dart';
import '../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../shared/util/widgets/custom_text_form_field.dart';
import 'invest_portfolio.dart';

class ReasonForInvestment extends StatefulWidget {
  const ReasonForInvestment({super.key});

  @override
  State<ReasonForInvestment> createState() => _ReasonForInvestmentState();
}

class _ReasonForInvestmentState extends State<ReasonForInvestment> {
  int progressIndex = 0;
  int selectedRadio = 0;
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  final List<List<String>> itemTexts = [
    [
      'I want to grow my capital',
      'I want to speculate',
      'I want to hedge',
      'I want to learn investment',
      'I still don\'t know',
    ],
    ["Yes", "No"],
    [
      "I’m employed",
      "I’m a professional",
      "I’m an entrepreneur",
      "I’m a freelancer",
      "I’m a student",
      "I’m Retired"
    ],
    ["Yes", "No"],
    [
      ]
  ];
  final List<String> pageTexts = [
    StringResources.what_do_hope_to_achieve,
    StringResources.do_you_have_experience,
    StringResources.what_do_you_do_for_living,
    StringResources.are_you_investing,
    StringResources.company_you_work_for,
    //StringResources.what_do_you_do_at_tedfinance,
    StringResources.by_checking_the_box,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset(AssetResources.shortLeftArrow)),
                  50.horizontalSpace,
                  SizedBox(
                    width: 200.w,
                    height: 10.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: LinearProgressIndicator(
                        value: progressIndex / 6,
                        color: AppColors.primaryButtonColor,
                      ),
                    ),
                  ),
                ],
              ),
              20.verticalSpace,
              if (progressIndex == 6)
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Text(
                    StringResources.by_checking_the_box,
                    style: CustomTextStyles.titleLarge30.copyWith(
                      fontSize: 30.sp, // or any other big font size you want
                      color: AppColors.black,
                    ),
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child:
                progressIndex == 5?
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'What do you do at\n',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 28.sp,
                            color: AppColors.black,
                            fontWeight: FontWeight.w600

                          )
                        )


                      ),
                      TextSpan(
                        text: 'TedFinance Technologies',
                        style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                      fontSize: 28.sp,
                          color:  AppColors.primaryColor,
                          fontWeight: FontWeight.w600

                      )
                )
                      ),
                      TextSpan(
                          text: '?',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 28.sp,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600

                              )
                          )
                      ),
                    ],
                  ),
                )
               :Text(
                  progressIndex < pageTexts.length
                      ? pageTexts[progressIndex]
                      : '', // or some default text
                  style: CustomTextStyles.titleLarge30.copyWith(color: AppColors.black),
                ),

              ),
              progressIndex == 6 ? 0.verticalSpace : 30.verticalSpace,
              if (progressIndex == 4)
                const BigPinkContainer(
                  containerColor: Colors.transparent,
                  text:
                      "Regulations require us to ask you this question.\nWe will never contact your company.",
                ),
              if (progressIndex == 4)
                const CustomTextFormField(
                    headerText: 'Company Name',
                    borderDecoration: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.primaryButtonColor))),
              if (progressIndex == 5)
                const CustomTextFormField(
                    headerText: 'Your Occupation',
                    borderDecoration: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.primaryButtonColor))),

                if (progressIndex == 6)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomCheckboxButton(
                        text: 'I acknowledge that my investment\nprofile will be auto generated.',
                        value: isChecked1,
                        fontSize: 18.sp,
                        onChange: (value) {
                          setState(() {});
                          isChecked1 = value;
                        },
                      ),
                      10.verticalSpace,
                      Divider(
                        color: AppColors.grey[65],
                      ),
                      10.verticalSpace,
                      CustomCheckboxButton(
                        text: 'I certify that i am above the\nage of 18 ',
                        value: isChecked2,
                        fontSize: 18.sp,
                        onChange: (value) {
                          setState(() {});
                          isChecked2 = value;
                        },
                      ),
                      10.verticalSpace,
                      Divider(
                        color: AppColors.grey[65],
                      ),
                      10.verticalSpace,
                      CustomCheckboxButton(
                        widget:  RichText(
                          text: TextSpan(
                          style: CustomTextStyles.titleMedium18.copyWith(
                              fontWeight:FontWeight.w500,
                            fontSize: 18.sp,
                          ),
                            children: [
                              const TextSpan(
                                  text: "I have read, understood and agree to\n"
                                      "be bound by all terms, disclosures,\n"
                                      "certifications, and disclaimers\n"
                                      "applicable to me, as found on the\n",
                              ),
                              TextSpan(
                                  text: "legal page",
                                  style: CustomTextStyles.titleMedium18.copyWith(
                                      color: AppColors.primaryColor
                                  )
                              ),
                              const TextSpan(
                                  text:  "of the TedFinance\nWebsite.",
                              ),
                            ],
                          ),
                        ),
                        value: isChecked3,
                        onChange: (value) {
                          setState(() {});
                          isChecked3 = value;
                        },
                      ),
                      10.verticalSpace,
                      Divider(
                        color: AppColors.grey[65],
                      ),
                    ],
                  ),

              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
               itemCount: progressIndex < itemTexts.length ? itemTexts[progressIndex].length : 0,
                  //itemTexts[progressIndex].length,
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10.h,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Transform.scale(
                              scale: 1.2,
                              child: Radio(
                                activeColor: AppColors.primaryButtonColor,
                                fillColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return AppColors.primaryButtonColor;
                                  } else {
                                    return AppColors.primaryColor;
                                  }
                                }),
                                value: index,
                                groupValue: selectedRadio,
                                onChanged: (value) {
                                  setState(() {
                                    //progressIndex = value!;
                                    selectedRadio = value!;
                                  });
                                },
                              ),
                            ),
                            Text(
                              itemTexts[progressIndex][index],
                              style: CustomTextStyles.titleMedium18
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        // 10.verticalSpace,
                        Divider(color: AppColors.grey[65]),
                      ],
                    );
                  },
                ),
              ),
              // Continue button
              Center(
                child: AppButton(
                  onPressed: () {
                    if (progressIndex < 6) {
                      setState(() {
                        progressIndex++;
                      });
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const InvestmentPortfolio()),
                      );
                    }


                  },
                  text: 'Continue',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
