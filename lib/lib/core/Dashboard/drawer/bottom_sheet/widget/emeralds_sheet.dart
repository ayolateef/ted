import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tedfinance_mobile/core/Dashboard/drawer/bottom_sheet/root.dart';
import 'package:tedfinance_mobile/core/Dashboard/drawer/bottom_sheet/widget/verify_address.dart';
import '../../../../../shared/util/widgets/custom_containers.dart';
import '../../../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../../../theme/custom_text_style.dart';
import '../../../../env/utils/colors.dart';
import '../../../../env/utils/string_resources.dart';
import '../../settings/account_tier/account_tier.dart';

class EmeraldsSheet extends StatefulWidget {
  const EmeraldsSheet({super.key});

  @override
  State<EmeraldsSheet> createState() => _EmeraldsSheetState();
}

class _EmeraldsSheetState extends State<EmeraldsSheet> {


  bool isAddressVerified = false;

  void updateAddressVerification(bool verified) {
    setState(() {
      isAddressVerified = verified;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 28.h),
      child: SizedBox(
        height: 560.h,
        child: Column(
          children: [
            Text(StringResources.emerald,
                style: CustomTextStyles.titleLargeBlack),
            10.verticalSpace,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10.r)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          CircleWidget(color: AppColors.grey[65]!),
                          const GreyLineWidget(height: 15),
                          const CircleWidget(
                              color: Colors.green, icon: Icons.check),
                          const GreyLineWidget(height: 30),
                          const CircleWidget(
                              color: Colors.green, icon: Icons.check),
                          const GreyLineWidget(height: 36),
                          CircleWidget(
                            color: isAddressVerified ? Colors.green : Colors.red,
                            icon: isAddressVerified ? Icons.check : Icons.close,
                            onTap: () {
                            },
                          ),
                          const GreyLineWidget(height: 30),
                          const CircleWidget(
                              color: Colors.green, icon: Icons.check),
                          const GreyLineWidget(height: 20),
                          CircleWidget(color: AppColors.grey[65]!),
                        ],
                      ),
                      30.horizontalSpace,
                      Column(
                        children: [
                          EmeraldTextIcon(
                            firstText: StringResources.email_verification,
                            secondText: StringResources.email_verified2,
                          ),
                          20.verticalSpace,
                          EmeraldTextIcon(
                            firstText: StringResources.phone_verification,
                            secondText: StringResources.phone_verified,
                          ),
                          20.verticalSpace,
                          EmeraldTextIcon(
                            firstText: StringResources.address_verification,
                            secondText: StringResources.verify_address,
                            onTap: (){
                               //verifyAddressSheet(context: context);

                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return VerifyAddressSheet(
                                    onUpdateAddressVerification: updateAddressVerification,
                                  );
                                },
                              );
                            },
                          ),



                          18.verticalSpace,
                          EmeraldTextIcon(
                            firstText: StringResources.valid_id,
                            secondText: StringResources.verified_id,
                          ),
                        ],
                      ),
                    ],
                  ),

                  20.verticalSpace,
                  AppButton(
                    onPressed: () {

                      // PageNavigator(ctx: context).nextPage(page: const TransferPage());
                    },
                    text: 'Upgrade to Emerald',
                    color: AppColors.primaryColor,
                    radius: 28.r,
                    height: 60,
                    width: 300.w,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


