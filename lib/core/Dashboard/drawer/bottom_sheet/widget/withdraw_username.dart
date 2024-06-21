
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../shared/util/asset_images.dart';
import '../../../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../../../theme/custom_text_style.dart';
import '../../../../env/utils/colors.dart';
import '../../../../env/utils/string_resources.dart';
import '../root.dart';
import 'enter_pin.dart';

class WithdrawUsernameSheet extends StatefulWidget {
  const WithdrawUsernameSheet({super.key});

  @override
  State<WithdrawUsernameSheet> createState() => _WithdrawUsernameSheetState();
}

class _WithdrawUsernameSheetState extends State<WithdrawUsernameSheet> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 55.h),
      child: SizedBox(
        height: 580,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(AssetResources.questionIcon),
                  8.horizontalSpace,
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              "Please confirm you have\nprovided the correct details.",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.tedDeepPurple),
                        ),
                        TextSpan(
                          text: "\n",
                        ),
                        TextSpan(
                          text:
                              "Providing the wrong information will cause delay\nwith payment.",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: AppColors.tedDeepPurple),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              30.verticalSpace,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10.r)),
                child: Column(
                  children: [
                    Text(
                      StringResources.receiver_details,
                      style: CustomTextStyles.titleMedium18,
                    ),
                    40.verticalSpace,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(AssetResources.stepperIcon2),
                          20.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Receiver’s Name'),
                              65.verticalSpace,
                              Text('Receiver’s Username'),
                              18.verticalSpace,
                              Text('Currency '),
                              50.verticalSpace,
                            ],
                          ),
                          50.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Abdullateef Ayodele\nSalaudeen',
                                  textAlign: TextAlign.right,
                                  style: CustomTextStyles.titleSmallBlack400
                                      .copyWith(
                                    fontWeight: FontWeight.w600,
                                  )),
                              43.verticalSpace,
                              Text('@iamofficialteo',
                                  style: CustomTextStyles.titleSmallBlack400
                                      .copyWith(
                                    fontWeight: FontWeight.w600,
                                  )),
                              18.verticalSpace,
                              Text(
                                'Nigeria Naira',
                                style:
                                    CustomTextStyles.titleSmallBlack400.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              18.verticalSpace,
                            ],
                          )
                        ],
                      ),
                    ),
                    5.verticalSpace,
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(),
                        20.horizontalSpace,
                        Checkbox(
                          value: isChecked,
                            onChanged: (bool? value) {
                            if (value != null) {
                              setState(() {
                                isChecked =
                                    value;
                              });
                            }
                          },
                          materialTapTargetSize: MaterialTapTargetSize
                              .shrinkWrap,
                          visualDensity: const VisualDensity(
                              vertical: 3.0,
                              horizontal:
                                  3.0),
                          activeColor: AppColors.primaryColor,

                          checkColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.purple,
                              width: 2.0,
                            ),
                            borderRadius:
                                BorderRadius.circular(5.0),
                          ),
                        ),
                        const Text(
                          StringResources.saave_to_directory,
                          style: TextStyle(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 20),
                        decoration: BoxDecoration(
                            color: AppColors.white2,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  StringResources.amountWithdraw,
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                8.verticalSpace,
                                Text(
                                  "N 0.00 ",
                                  style: CustomTextStyles.titleMedium18
                                      .copyWith(fontSize: 34.sp),
                                )
                              ],
                            ),
                            Container(

                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: AppColors.grey[65],
                                    borderRadius: BorderRadius.circular(30.r)),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      AssetResources.circularNigFlag2,
                                      height: 40.h,
                                      width: 40.h,
                                    ),
                                    10.horizontalSpace,
                                    Text('NGN',
                                        style:
                                            CustomTextStyles.titleLargeBlack),
                                    5.horizontalSpace,
                                    SvgPicture.asset(

                                      AssetResources.smallDropDown, color: Colors.black,)
                                  ],
                                ))
                          ],
                        ))
                  ],
                ),
              ),
              60.verticalSpace,
              AppButton(
                onPressed: () {
                  Navigator.of(context).pop();
                   enterPinSheet(
                       context: context,
                       isFromSellButton: false

                   );
                },
                text: 'Withdraw',
                width: 350.w,
                color: AppColors.primaryColor,
                radius: 30.r,
              )
            ],
          ),
        ),
      ),
    );
  }
}
