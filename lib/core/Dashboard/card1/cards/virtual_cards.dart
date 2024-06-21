import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tedfinance_mobile/core/Dashboard/card1/cards/withdraw_funds.dart';
import 'package:tedfinance_mobile/shared/navigations/routes/navigation_service.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/theme/custom_text_style.dart';
import '../../../../shared/util/widgets/appbar.dart';
import '../../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../env/utils/string_resources.dart';
import 'activate_card.dart';
import 'add_fund_to_card.dart';
import 'delete_card.dart';
import 'freeze_card.dart';

class VirtualCards extends StatelessWidget {
  const VirtualCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TedAppBar(
          elevation: 0,
          titleText: StringResources.your_virtual_cards,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 103.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFFB1DF8), // 100% #FB1DF8
                          Color(0xFF4543AC), // 100% #4543AC
                        ],
                      ),
                    ),
                    child: Center(
                        child: Text(StringResources.virtual_cards,
                            style: CustomTextStyles.titleSmallffffffff))),
                Stack(
                  children: [
                    Image.asset(
                      AssetResources.visaVirtualCard2,
                    ),
                    Positioned(
                      left: 43,
                      top: 32,
                      child: Column(
                        children: [
                          SvgPicture.asset(AssetResources.tedLogo2),
                          50.verticalSpace,
                          SvgPicture.asset(AssetResources.NFC),
                        ],
                      ),
                    ),
                  ],
                ),

                // 10.verticalSpace,

                10.verticalSpace,

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StringResources.card_settings,
                      style: CustomTextStyles.bodySmallBlack900
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         CardSettings(
                          onTap: (){
                            PageNavigator(ctx: context).nextPage(page: const AddFundToCard());
                          },
                          svgIcon: AssetResources.addFund,
                          textCard: 'Add funds',
                        ),
                        30.horizontalSpace,
                        const CardSettings(
                          svgIcon: AssetResources.seeCardIcon,
                          textCard: 'Card details',
                        ),
                        30.horizontalSpace,
                        CardSettings(
                          onTap: (){
                            PageNavigator(ctx: context).nextPage(page: const WithdrawFunds());
                          },
                          svgIcon: AssetResources.withdrawIcon,
                          textCard: 'Withdraw',
                        ),
                        30.horizontalSpace,
                         CardSettings(
                          onTap: (){
                            PageNavigator(ctx: context).nextPage(page: const FreezeCard());

                          },
                          svgIcon: AssetResources.freezeCard,
                          textCard: 'Freeze Card',
                        ),
                        30.horizontalSpace,
                         CardSettings(
                          onTap: (){
                            PageNavigator(ctx: context).nextPage(page: const DeleteCard());
                          },
                          svgIcon: AssetResources.deleteCardIcon,
                          textCard: 'Delete Card',
                        )
                      ],
                    ),
                    40.verticalSpace,
                    AppButton(
                      onPressed: () {
                        PageNavigator(ctx: context)
                            .nextPage(page: const ActivateCard());
                      },
                      text: 'Activate Card',
                      radius: 20.r,
                    ),
                    20.verticalSpace,
                    Text(StringResources.recent_activity,
                        style: CustomTextStyles.bodySmallBlack900
                            .copyWith(fontWeight: FontWeight.w600)),
                    20.verticalSpace,
                    Center(
                        child: Image.asset(AssetResources.noCardActivityIcon)),
                    10.verticalSpace,
                    Center(
                      child: Text(
                        StringResources.no_recent_activities,
                        style: CustomTextStyles.bodySmallBlack900
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class CardSettings extends StatelessWidget {
  final String? svgIcon;
  final String? textCard;
  final Function()? onTap;
  const CardSettings({
    super.key,
    this.svgIcon,
    this.textCard,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(svgIcon ?? ''),
          7.verticalSpace,
          Text(
            textCard ?? '',
            style: CustomTextStyles.bodySmallBlack900
                .copyWith(fontWeight: FontWeight.w600, fontSize: 10.sp),
          )
        ],
      ),
    );
  }
}
