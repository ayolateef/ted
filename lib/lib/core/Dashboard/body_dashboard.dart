import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tedfinance_mobile/core/Dashboard/card1/report/exchange_currency.dart';
import 'package:tedfinance_mobile/core/Dashboard/kyc/bvn.dart';
import 'package:tedfinance_mobile/core/Dashboard/kyc/nin.dart';
import 'package:tedfinance_mobile/core/Dashboard/kyc/personal_bio.dart';
import 'package:tedfinance_mobile/core/Dashboard/kyc/select_country.dart';
import 'package:tedfinance_mobile/core/Dashboard/kyc/selfie.dart';
import 'package:tedfinance_mobile/core/Dashboard/kyc/upload_files.dart';
import 'package:tedfinance_mobile/providers/auth_provider.dart';
import 'package:tedfinance_mobile/shared/models/kyc_model/kyc_progress_model.dart';
import 'package:tedfinance_mobile/shared/navigations/routes/navigation_service.dart';

import '../../providers/dashboard_provider.dart';
import '../../providers/kyc_provider.dart';
import '../../shared/models/auth_models/user.dart';
import '../../shared/models/dashboard_models/card_transactions_model.dart';
import '../../shared/models/dashboard_models/wallet_model.dart';
import '../../shared/util/asset_images.dart';
import '../../shared/util/cards.dart';
import '../../shared/util/storage.dart';
import '../../shared/util/widgets/custom_containers.dart';
import '../../shared/util/widgets/custom_elevated_button.dart';
import '../../theme/custom_text_style.dart';
import '../env/app_config.dart';
import '../env/utils/alert_toast.dart';
import '../env/utils/colors.dart';
import '../env/utils/string_resources.dart';
import 'card1/add_fund/add_fund_to_wallet.dart';
import 'card1/cards/virtual_cards.dart';
import 'card1/report/report_page.dart';
import 'card1/send/send_money.dart';
import 'card1/transfer/send_with_username.dart';
import 'card1/transfer/traansfer.dart';
import 'kyc/kyc-progress.dart';
import 'kyc/kyc_identity.dart';

class DashboardBody extends StatefulWidget {
  const DashboardBody({super.key});

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  WalletModel? walletModel;
  bool isLoading = true;
  bool _isHovering = false;
  late DashboardProvider dashboardProvider;
  KYCProgressModel? kycProgressModel;
  late KYCProvider kycProvider;
  String token = '';
  List<TransactionsModel> transactionList = [];


  @override
  void initState() {
    super.initState();
    LocalStorageUtils.write(AppConstants.isUserFirstTime, "true");
    Future.microtask(() async{
      final prefs = await SharedPreferences.getInstance();
      String? fcmToken = prefs.getString(token);
      await fetchWalletInfo();
      await fetchKYCProgress();
      Provider.of<DashboardProvider>(context, listen: false).getCardTransactions()
          .then((value) {
        setState(() {
          transactionList = value;
        });
      });
      Provider.of<AuthenticationProvider>(context, listen: false).updateToken(fcmToken ?? '');
    });
  }
  Future<void> fetchWalletInfo() async {
    try {
      final walletInfo = await Provider.of<DashboardProvider>(context, listen: false).getWalletInfo();
      setState(() {
        walletModel = walletInfo;
        isLoading = false;
      });
    } catch (e) {
      if (e.toString().contains('User wallet do not exist')) {
        setState(() {
          walletModel = null;
          isLoading = false;
        });
      } else {
        rethrow;
      }
    }
  }

  Future<void> fetchKYCProgress() async {
    final kycInfo = await Provider.of<KYCProvider>(context, listen: false).getKYCProgress();
    setState(() {
      kycProgressModel = kycInfo;
    });
  }
  @override
  Widget build(BuildContext context) {
    dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    kycProvider = Provider.of<KYCProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Positioned(
                right: -MediaQuery.of(context).size.width / 4,
                top: -5,
                child: Container(
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width / 2.8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryButtonColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: PurpleCardWithIcons(
                  widget: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              AssetResources.walletBalIcon,
                            ),
                            10.horizontalSpace,
                            Text('Your wallet Balance',
                                style: CustomTextStyles.titleSmallffffffff),
                            const Spacer(),
                            SvgPicture.asset(
                              AssetResources.$Icon,
                              height: 30.h,
                            ),
                          ],
                        ),
                        15.verticalSpace,
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(child: Image.asset(AssetResources.nigWhiteFlag2)),
                            Expanded(child: SvgPicture.asset(AssetResources.scrollIcon)),

                            Text(
                                "\₦${walletModel?.accountBalance ?? "0.00"}",
                                //"₦${walletModel?.accountBalance ?? "0.00"}",
                                style: TextStyle(
                                      fontFamily: " ",
                                        fontWeight: FontWeight.w800,
                                        fontSize: 25.sp,
                                        color: AppColors.white)),
                            10.horizontalSpace,
                            SvgPicture.asset(AssetResources.eyeIcon),
                            SvgPicture.asset(AssetResources.threeDotIcon),
                            15.horizontalSpace,
                            AddFundContainer(
                              onTap: () {
                                pushToWithRoute(context, CustomRoutes.slideIn(const AddFundToWallet()));
                              },
                            ),
                          ],
                        ),
                        35.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () => pushToWithRoute(context, CustomRoutes.fadeIn(const VirtualCards())),
                              child: const WhiteCircularIcons(
                                // onTap: () {
                                // pushToWithRoute(context, CustomRoutes.fadeIn(const VirtualCards()));
                                // },
                                circleSvgIcon: AssetResources.creditCard,
                                circleText: 'Card',
                              ),
                            ),
                            10.horizontalSpace,
                            WhiteCircularIcons(
                              onTap: () {
                                pushToWithRoute(context, CustomRoutes.slideIn(const ExchangeCurrency()));
                              },
                              circleSvgIcon: AssetResources.currencyIcon,
                              circleText: 'Exchange',
                            ),
                            10.horizontalSpace,
                            WhiteCircularIcons(
                              onTap: () {
                                pushToWithRoute(context, CustomRoutes.slideIn(const SendMoney()));

                              },
                              circleSvgIcon: AssetResources.sendIcon,
                              circleText: 'Send',
                            ),
                            10.horizontalSpace,
                            const WhiteCircularIcons(
                              circleSvgIcon: AssetResources.questionIcon,
                              circleText: 'Request',
                            ),
                            10.horizontalSpace,
                             WhiteCircularIcons(
                              circleSvgIcon: AssetResources.transferIcon,
                              circleText: 'Transfer',
                              onTap: (){
                                pushToWithRoute(context, CustomRoutes.fadeIn(const TransferPage()));
                              },
                            ),
                            10.horizontalSpace,
                            InkWell(
                                onTap: (){
                                  PageNavigator(ctx: context)
                                      .nextPage(page: const ReportPage());
                                },
                                child: Image.asset (AssetResources.reportIconWhiteCircle)),
                            // WhiteCircularIcons(
                            //   onTap: () {
                            //     PageNavigator(ctx: context)
                            //         .nextPage(page: const ReportPage());
                            //   },
                            //   padding: 0.0,
                            //   circleSvgIcon: AssetResources.reportIconWhiteCircle,
                            //   circleText: 'Report',
                            //   scale: 1.0,
                            // ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
          10.verticalSpace,
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 8.0),
            child: PurpleCardWithIcons(
              cardColor: AppColors.white,
              widget: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Other Services',
                      style: CustomTextStyles.bodySmallBlack900
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    20.verticalSpace,
                    SizedBox(
                      height: 70.0.h, // Provide a fixed height here
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          const RectangularIcons(
                            circleSvgIcon: AssetResources.balanceIcon,
                            circleText: 'Balance',
                          ),
                          SizedBox(width: 18.w),
                          RectangularIcons(
                            circleColor:
                                AppColors.tedLightPink.withOpacity(0.7),
                            circleSvgIcon: AssetResources.virtualCardIcon,
                            circleText: 'Virtual Card',
                          ),
                          SizedBox(width: 18.w),
                          const RectangularIcons(
                            circleSvgIcon: AssetResources.physicalCardIcon,
                            circleText: 'Physical Card',
                          ),
                          SizedBox(width: 18.w),
                          RectangularIcons(
                            circleColor:
                                AppColors.tedLightPink.withOpacity(0.7),
                            circleSvgIcon: AssetResources.cryptoIcon,
                            circleText: 'Crypto',
                          ),
                          SizedBox(width: 18.w),
                          const RectangularIcons(
                            circleSvgIcon: AssetResources.currencyIcon,
                            circleText: 'Exchange',
                          ),
                        ],
                      ),
                    ),
                    35.verticalSpace,
                    SizedBox(
                      height: 70.0.h, // Provide a fixed height here
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          RectangularIcons(
                            circleColor:
                                AppColors.tedLightPink.withOpacity(0.7),
                            circleSvgIcon: AssetResources.settingsIcon,
                            circleText: 'Settings',
                          ),
                          SizedBox(width: 18.w),
                          const RectangularIcons(
                            circleSvgIcon: AssetResources.accountIcon,
                            circleText: 'Account Details',
                          ),
                          SizedBox(width: 18.w),
                          RectangularIcons(
                            circleColor:
                                AppColors.tedLightPink.withOpacity(0.7),
                            circleSvgIcon: AssetResources.investmentIcon,
                            circleText: 'Investment',
                          ),
                          SizedBox(width: 18.w),
                          const RectangularIcons(
                            circleSvgIcon: AssetResources.kycIcon,
                            circleText: 'KYC',
                          ),
                          SizedBox(width: 18.w),
                          RectangularIcons(
                            circleColor:
                                AppColors.tedLightPink.withOpacity(0.7),
                            circleSvgIcon: AssetResources.chatTedIcon,
                            circleText: 'Chat Ted',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            isLoading
                  ? Container(
                      color: Colors.white.withOpacity(0.5),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )
                  :    walletModel == null || kycProgressModel?.isKYCVerified == "PENDING"
                      ? Center(
                          child: Column(
                            children: [
                              Text("KYC Identity Verification",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600),
                                  )),
                              Text(
                                  "Kindly proceed with your KYC to get full access to your account",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w500),
                                  )),
                              Image.asset(
                                AssetResources.kycIdentityImage,
                                height: 120,
                                width: 120,
                              ),
                              Center(
                                child: MouseRegion(
                                  onHover: (event) {
                                    setState(() {
                                      _isHovering = true;
                                    });
                                  },
                                  onExit: (event) {
                                    setState(() {
                                      _isHovering = false;
                                    });
                                  },
                                  child: AppButton(
                                    onPressed: () async {
                                      if (kycProgressModel?.kycStep ==  6 && kycProgressModel?.isKYCVerified == 'PENDING') {
                                        pushToWithRoute(context, CustomRoutes.fadeIn(const  KYCProgress()));
                                      } else {
                                        handleGetStarted();
                                      }
                                      //pushToWithRoute(context, CustomRoutes.fadeIn(const  KYCIdentity())
                                     //);
                                    },
                                    radius: 30.r,
                                    width: 270.w,
                                    color: _isHovering
                                        ? AppColors.primaryColor
                                        : AppColors.white,
                                    borderColor: AppColors.white2,
                                    buttonType: ButtonType.primary,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Get Started',
                                          style: TextStyle(
                                            color: _isHovering
                                                ? AppColors.white
                                                : AppColors.primaryColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20.sp,
                                          ),
                                        ),
                                        8.horizontalSpace,
                                        SvgPicture.asset(
                                            AssetResources.longRightArrow),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : kycProgressModel?.isKYCVerified == "APPROVE"
                          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Recent Activities',
                                  style: CustomTextStyles.bodySmallBlack900
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                10.verticalSpace,
                                Column(
                                  children: [
                                    10.verticalSpace,
                                    SizedBox(
                                      height: 300.h,
                                      child: Visibility(
                                        visible: transactionList.isNotEmpty,
                                        replacement:  SingleChildScrollView(
                                          child: Column(
                                            children: [
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
                                        ),
                                        child: ListView.separated(
                                          itemCount: transactionList.length,
                                          itemBuilder: (context, index) {
                                            return  CustomCard(
                                              transactionsModel: transactionList[index],
                                              // image: AssetResources.listTileImage2,
                                              // title: 'You Converted',
                                              // subtitle: '500 USD to 800,000 NGN',
                                              // trailingText: '800,000.00',
                                              // trailingSubtitle: '25-01-2024 6:00pm',
                                            );
                                          }, separatorBuilder: (BuildContext context, int index) {
                                          return SizedBox(
                                            height: 20.h,
                                          );
                                        },
                                        ),
                                      ),
                                    ),
                                    20.verticalSpace,
                                  ],
                                ),
                                20.verticalSpace,
                              ],
                            )
                  :  const SizedBox.shrink(
              ),
            ]),
          )
        ],
      ),
    );
  }

  handleGetStarted() async {
    try {
      final jsonData = await kycProvider.getKYCProgress();
      if (jsonData != null) {
        await trackKYCProgress(context, jsonData);
      } else {
        pushToWithRoute(context, CustomRoutes.fadeIn(const KYCIdentity()));
      }
    } catch (e) {
      AlertToast(context: context).showError(e.toString());
    }
  }


  Future<void> trackKYCProgress(BuildContext context, KYCProgressModel? kycProgress) async {
    if (kycProgress == null) {
      return;
    }

    final kycStep = kycProgress.kycStep?.kycStep;
    if(kycStep == -1){
      Future.delayed(const Duration(milliseconds: 500), () {
        pushToWithRoute(context, CustomRoutes.fadeIn(const KYCIdentity()));
      });
    }
     else if (kycStep == 6) {
      if (kycProgress.isKYCVerified == "PENDING") {

        pushToWithRoute(context, CustomRoutes.fadeIn(const KYCProgress()));
      }
    } else if (kycStep != null && kycStep < 6) {

      switch (kycProgress.kycStep) {
        case KYCSteps.setCountry :
          pushToWithRoute(context, CustomRoutes.fadeIn(const BVNPage()));
          //pushToWithRoute(context, CustomRoutes.fadeIn(const SelectCountry()));
          break;
        case KYCSteps.verifyBVN:

          pushToWithRoute(context, CustomRoutes.fadeIn(const NINPage()));
         // pushToWithRoute(context, CustomRoutes.fadeIn(const BVNPage()));
          break;
        case KYCSteps.verifyNIN:

          Future.delayed(Duration(milliseconds: 500), () {
            pushToWithRoute(context, CustomRoutes.fadeIn(const UploadFiles()));
          });
         // pushToWithRoute(context, CustomRoutes.fadeIn(const NINPage()));
          break;
        case KYCSteps.idValidation:
          pushToWithRoute(context, CustomRoutes.fadeIn(const PersonalBio()));
          //pushToWithRoute(context, CustomRoutes.fadeIn(const UploadFiles()));
          break;
        case KYCSteps.addressVerification:
          pushToWithRoute(context, CustomRoutes.fadeIn(const SelfieScreen()));
         // pushToWithRoute(context, CustomRoutes.fadeIn(const PersonalBio()));
          break;
        case KYCSteps.selfieVerification:
          print("Unexpected KYC step: ${kycProgress.kycStep}");
         // pushToWithRoute(context, CustomRoutes.fadeIn(const SelfieScreen()));
          break;
        default:
          print("Unexpected KYC step: ${kycProgress.kycStep}");
      }
    }
  }



}
