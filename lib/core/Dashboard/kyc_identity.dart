import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tedfinance_mobile/core/Dashboard/select_country.dart';
import 'package:tedfinance_mobile/core/env/utils/colors.dart';
import 'package:tedfinance_mobile/core/env/utils/string_resources.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/appbar.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_drop_down.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';
import 'package:tedfinance_mobile/theme/custom_text_style.dart';

import '../../shared/navigations/routes/navigation_service.dart';

class KYCIdentity extends StatefulWidget {
  const KYCIdentity({super.key});

  @override
  State<KYCIdentity> createState() => _KYCIdentityState();
}

class _KYCIdentityState extends State<KYCIdentity> {
  String _selectedLanguage = 'English';
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar:  const TedAppBar(
          titleText: StringResources.KYC_KYB_VERIFICATION,

        ),
        body:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Text(StringResources.KYC_KYB_IDENTITY_VERIFICATION,
                  style: GoogleFonts.poppins(
          textStyle: TextStyle(
          fontSize: 20.sp,
              fontWeight: FontWeight.w700
          )
        )
              
              ),
              Text(StringResources.Your_identity_will_be,
                textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        color: AppColors.tedGreyText
                      )
                  )
              ),
              Image.asset(AssetResources.webSecurity),
              25.verticalSpace,
              MouseRegion(
                onHover: (event) {
                  setState(() {
                    isHovered = true;
                  });
                },
                onExit: (event) {
                  setState(() {
                    isHovered = false;
                  });
                },
                child: AppButton(
                  onPressed: (){
                    pushToWithRoute(context, CustomRoutes.fadeIn(
                        const SelectCountry())
                    );
                  },
                  text: 'Get Started',
                  radius: 15.r,
                  height: 50,
                  color: isHovered ? AppColors.primaryColor : AppColors.tedButtonGrey,

                ),
              ),
                35.verticalSpace,
                RichText(
          textAlign: TextAlign.left,
          text:  TextSpan(
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                )
            ),
            children:  [
              TextSpan(
                text: 'By proceeding, you agree to our ',
                style: TextStyle(
                  color: AppColors.tedGreyText,
                ),
              ),
              TextSpan(
                text: 'Terms &\n Conditions ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              TextSpan(
                text: 'and ',
                style: TextStyle(
                  color: AppColors.tedGreyText
                ),
              ),
              TextSpan(
                text: 'Privacy Policy',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
                ),
              20.verticalSpace,
              Row(
                children: [
                  SvgPicture.asset(AssetResources.whyIcon),
                  5.horizontalSpace,
                  Text(
                    StringResources.Why_this,
                     style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                  fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.tedGreyText
                  )
        )
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Language',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.tedGreyText
                              )
                          )
                      ),
                      CustomDropDown(
                        width: 100.h,
                        items: const ['English', 'French', 'German', 'Spanish'],
                        fillColor: Colors.transparent ,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedLanguage = newValue!;
                          });
                          initialValue: 'English';
                        },
                      ),
                    ],
                  ),
                ],
              )

            ],
          ),
        ));
  }
}
