import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tedfinance_mobile/core/Dashboard/card1/cards/virtual_cards.dart';
import 'package:tedfinance_mobile/shared/navigations/routes/navigation_service.dart';
import '../../../../../shared/util/asset_images.dart';
import '../../../../../shared/util/widgets/custom_containers.dart';
import '../../../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../../env/utils/colors.dart';
import '../../../../env/utils/string_resources.dart';

class VirtualCardActivatedSheet extends StatelessWidget {
  const VirtualCardActivatedSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xffDA5ED8),
        const Color(0xffB854B7),
        AppColors.black
      ],
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 35.h),
      child: ClipPath(
        clipper: MyTopClipper(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.4,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return gradient.createShader(bounds);
                    },
                    blendMode: BlendMode.srcIn,
                    child: const Text(
                      StringResources.congratulations,
                      textScaler: TextScaler.linear(1.1),
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Image.asset(AssetResources.virtualCardActivated),
                20.verticalSpace,
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25.sp,
                    ),
                    children: const [
                      TextSpan(
                        text: 'Virtual Card Activated',
                        style: TextStyle(
                          color: AppColors.tedGradientColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: ' \nsuccessfully.',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                20.verticalSpace,
                const Text(
                  StringResources.you_can_now_make_payment,
                  textAlign: TextAlign.center,
                ),
                50.verticalSpace,
                AppButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    PageNavigator(ctx: context)
                        .nextPage(page: const VirtualCards());
                  },
                  text: 'Done',
                  radius: 30.r,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FundAddedSuccessSheet extends StatelessWidget {
  const FundAddedSuccessSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xffDA5ED8),
        const Color(0xffB854B7),
        AppColors.black
      ],
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 35.h),
      child: ClipPath(
        clipper: MyTopClipper(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.4,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(AssetResources.fundAddedImage),
                20.verticalSpace,
                ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return gradient.createShader(bounds);
                    },
                    blendMode: BlendMode.srcIn,
                    child: const Text(
                      StringResources.fund_added_success,
                      textScaler: TextScaler.linear(1.1),
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15.sp,
                    ),
                    children: const [
                      // Your Funds of $100 Have been added to your virtual
                      // dollar card successfully.
                      TextSpan(
                        text: 'Your Funds of ',
                      ),
                      TextSpan(
                        text: ' \$100 ',
                        style: TextStyle(
                          color: AppColors.tedGradientColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: 'Have been added to your virtual\n',
                      ),
                      TextSpan(
                        text: 'dollar card successfully.',
                      ),
                    ],
                  ),
                ),
                50.verticalSpace,
                AppButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    PageNavigator(ctx: context)
                        .nextPage(page: const VirtualCards());
                  },
                  text: 'Done',
                  radius: 30.r,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SuccessfulWithdrawalSheet extends StatelessWidget {
  const SuccessfulWithdrawalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xffDA5ED8),
        const Color(0xffB854B7),
        AppColors.black
      ],
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 35.h),
      child: ClipPath(
        clipper: MyTopClipper(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.4,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(AssetResources.successWithdrawalImage2),
                20.verticalSpace,
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 25.sp,
                    ),
                    children: [
                      const TextSpan(
                        text: ' You have successfully\n',
                        style: TextStyle(
                          color: AppColors.tedGradientColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: ' placed a withdraw',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          foreground: Paint()
                            ..shader = LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                const Color(0xffDA5ED8),
                                const Color(0xffB854B7),
                                AppColors.black,
                              ],
                            ).createShader(
                                const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                        ),
                      )
                    ],
                  ),
                ),
                const Text(StringResources.your_payment_is_on_the_way),
                50.verticalSpace,
                AppButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    PageNavigator(ctx: context)
                        .nextPage(page: const VirtualCards());
                  },
                  text: 'Done',
                  radius: 30.r,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FrozenCardSheet extends StatelessWidget {
  const FrozenCardSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xffDA5ED8),
        const Color(0xffB854B7),
        AppColors.black
      ],
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 35.h),
      child: ClipPath(
        clipper: MyTopClipper(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.4,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  AssetResources.freezeCardImage2,
                ),
                20.verticalSpace,
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 25.sp,
                    ),
                    children: [
                      const TextSpan(
                        text: ' Virtual Card\n',
                        style: TextStyle(
                          color: AppColors.tedGradientColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: 'Frozen Successfully',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          foreground: Paint()
                            ..shader = LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                const Color(0xffDA5ED8),
                                const Color(0xffB854B7),
                                AppColors.black,
                              ],
                            ).createShader(
                                const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                        ),
                      )
                    ],
                  ),
                ),
                const Text(StringResources.your_us_virtual_dollar),
                50.verticalSpace,
                AppButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    PageNavigator(ctx: context)
                        .nextPage(page: const VirtualCards());
                  },
                  text: 'Done',
                  radius: 30.r,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DeleteSuccessSheet extends StatelessWidget {
  const DeleteSuccessSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xffDA5ED8),
        const Color(0xffB854B7),
        AppColors.black
      ],
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 35.h),
      child: ClipPath(
        clipper: MyTopClipper(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.4,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(AssetResources.deleteSuccessImage),
                20.verticalSpace,
                Text(
                  ' Virtual Card\nDeleted Successfully',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.tedBigTextPurpleColor2,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                20.verticalSpace,
                const Text(StringResources.your_us_card_deleted),
                50.verticalSpace,
                AppButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    PageNavigator(ctx: context)
                        .nextPage(page: const VirtualCards());
                  },
                  text: 'Done',
                  radius: 30.r,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

