
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';
import '../../../shared/navigations/routes/navigation_service.dart';
import '../../../shared/util/asset_images.dart';
import '../../../theme/custom_text_style.dart';
import '../../Dashboard/kyc_identity.dart';
import '../../env/utils/colors.dart';
import '../../env/utils/string_resources.dart';

class ChangedPassword extends StatefulWidget {
  const ChangedPassword({super.key});

  @override
  State<ChangedPassword> createState() => _ChangedPasswordState();
}

class _ChangedPasswordState extends State<ChangedPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                child:  Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(AssetResources.shortLeftArrowWhite),
                      35.horizontalSpace,
                      Text(
                        StringResources.change_password,
                        style: CustomTextStyles.titleMediumBoldWhite,
                      )
                    ],
                  )
                ),
              ),
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0),
                      ),
                    ),
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 21.0.w, vertical: 28.h),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            20.verticalSpace,
                            Image.asset(AssetResources.verifySignUp),
                            16.verticalSpace,
                            Center(
                              child: Text(
                                StringResources.change_password_successfully ,
                                style: CustomTextStyles.titleMediumPurple16
                                    .copyWith(
                                    color: AppColors.tedPurpleText),
                              ),
                            ),
                            10.verticalSpace,
                            Center(
                              child: Text(
                                StringResources
                                    .password_successfully_verified,
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.titleSmallBlack400
                                    .copyWith(),
                              ),
                            ),
                            45.verticalSpace,
                            AppButton(
                              onPressed: () {
                                PageNavigator(ctx: context).nextPageOnly(
                                    page: const KYCIdentity());
                              },
                              text: "Ok",
                              radius: 20.r,
                            ),
                          ],
                        )

                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
