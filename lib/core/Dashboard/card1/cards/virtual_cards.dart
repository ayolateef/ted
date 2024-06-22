import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tedfinance_mobile/core/Dashboard/card1/cards/withdraw_funds.dart';
import 'package:tedfinance_mobile/shared/navigations/routes/navigation_service.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/theme/custom_text_style.dart';
import '../../../../providers/dashboard_provider.dart';
import '../../../../shared/models/dashboard_models/card_details_model.dart';
import '../../../../shared/models/dashboard_models/card_transactions_model.dart';
import '../../../../shared/util/cards.dart';
import '../../../../shared/util/widgets/appbar.dart';
import '../../../../shared/util/widgets/custom_elevated_button.dart';
import '../../../env/utils/alert_toast.dart';
import '../../../env/utils/colors.dart';
import '../../../env/utils/string_resources.dart';
import '../../../utililies.dart';
import 'activate_card.dart';
import 'add_fund_to_card.dart';
import 'delete_card.dart';
import 'freeze_card.dart';

class VirtualCards extends StatefulWidget {
  const VirtualCards({super.key});

  @override
  State<VirtualCards> createState() => _VirtualCardsState();
}

class _VirtualCardsState extends State<VirtualCards> {
  late DashboardProvider dashboardProvider;

  bool showCardDetails = false;
  CardDetailsModel? _cardDetails;
  final bool _isLoading = false;
  List<TransactionsModel> transactionList = [];


  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      Provider.of<DashboardProvider>(context, listen: false).getCardTransactions()
          .then((value) {
        setState(() {
          transactionList = value;
        });
      });
    });
  }
  String formatCardNumber(String number) {
    return number.replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ");
  }

  @override
  Widget build(BuildContext context) {
    dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    final bool isCardActivated = dashboardProvider.isCardActivated;
    final bool isCardFrozen = dashboardProvider.isFrozen;
    return Scaffold(
        appBar:  TedAppBar(

          elevation: 0,
          titleText: StringResources.your_virtual_cards,
          trailing: Container()
        ),
        body: FutureBuilder(
            future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
    if (snapshot.hasData) {
      final sharedPrefs = snapshot.data;
      final isCardActivated = sharedPrefs?.getBool('card_activated') ?? false;

      return SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
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
                  showCardDetails
                      ? Stack(
                    children: [
                      Image.asset(
                        AssetResources.visaVirtualCard2,
                      ),
                      Positioned(
                          left: 40,
                          top: 32,
                          child: Image.asset(AssetResources.tedLogo2, height: 37, )),
                      Positioned(
                        top: 120,
                        left: 100,
                        child: Text(
                          formatCardNumber( _cardDetails?.fullCardPan ?? '**** **** **** 1234'),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 35,
                        bottom: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            20.horizontalSpace,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Card Holder Name',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                Text(
                                    _cardDetails?.nameOnCard ??
                                        "Ayodele Lateef",
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600),
                                    )),
                              ],
                            ),
                            20.horizontalSpace,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Exp Date',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                Text(
                                    _cardDetails?.expirationDate != null
                                        ? Utilities.addSlashToExpDate(
                                        _cardDetails!.expirationDate!
                                            .substring(0, 7))
                                        : "00/00",
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600),
                                    )),
                              ],
                            ),
                            20.horizontalSpace,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "cvv",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),
                                Text(_cardDetails?.cvv ?? '000',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  )

                      : Stack(
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
                      Positioned(
                        top: 110,
                        left: 120,
                        child:  isCardFrozen == true ? Image.asset(AssetResources.freezeIcon)

                            :Text(
                          formatCardNumber(_cardDetails?.maskedPan ?? '**** **** **** 1234',),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                          ),
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
                            onTap: () {
                              pushToWithRoute(context, CustomRoutes.fadeIn(const AddFundToCard()));
                            },
                            svgIcon: AssetResources.addFund,
                            textCard: 'Add funds',
                          ),
                          30.horizontalSpace,
                          CardSettings(
                              onTap: () {
                                if (_cardDetails != null) {
                                  // Card details are already available, just show it
                                  setState(() {
                                    showCardDetails = !showCardDetails;
                                  });
                                } else {
                                  // Call the API to get the card details
                                  showCard();
                                }
                              },
                              svgIcon: AssetResources.seeCardIcon,
                              textCard: 'Card Details'),
                          30.horizontalSpace,
                          CardSettings(
                            onTap: () {
                              pushToWithRoute(context, CustomRoutes.fadeIn(const WithdrawFunds()));

                            },
                            svgIcon: AssetResources.withdrawIcon,
                            textCard: 'Withdraw',
                          ),
                          30.horizontalSpace,
                          CardSettings(
                            onTap: () {
                              pushToWithRoute(context, CustomRoutes.fadeIn(const FreezeCard()));

                            },
                            svgIcon: AssetResources.freezeCard,
                            textCard: 'Freeze Card',
                          ),
                          30.horizontalSpace,
                          CardSettings(
                            onTap: () {
                              pushToWithRoute(context, CustomRoutes.slideIn(const DeleteCard()));

                            },
                            svgIcon: AssetResources.deleteCardIcon,
                            textCard: 'Delete Card',
                          )
                        ],
                      ),
                      40.verticalSpace,
                      // Consumer<DashboardProvider>(
                      //   builder: (context, dashboardProvider, child) {
                      //     return Center(
                      //       child:   isCardActivated == true ?
                      //       AppButton(
                      //         onPressed: () {
                      //           pushToWithRoute(context, CustomRoutes.slideIn(const ActivateCard())).then((value) => dashboardProvider.setCardActivated(false));
                      //         },
                      //         text: _isLoading ? 'Loading...' : 'Activate Card',
                      //         radius: 20.r,
                      //       )
                      //           : Container()
                      //     );
                      //   },
                      // ),
                      Consumer<DashboardProvider>(
                        builder: (context, dashboardProvider, child) {
                          return Center(
                              child: isCardActivated == true ?
                              //dashboardProvider.isCardActivated == true ?
                              AppButton(
                                onPressed: null,
                                text: _isLoading ? 'Loading...' : 'Activated',
                                radius: 20.r,
                              )
                                  : AppButton(
                                onPressed: () {
                                  pushToWithRoute(context, CustomRoutes.slideIn(const ActivateCard())).then((value) => dashboardProvider.setCardActivated(false));
                                },
                                text: _isLoading ? 'Loading...' : 'Activate Card',
                                radius: 20.r,
                              )
                          );
                        },
                      ),
                      20.verticalSpace,
                      Text(StringResources.recent_activity,
                          style: CustomTextStyles.bodySmallBlack900
                              .copyWith(fontWeight: FontWeight.w600)),
                      20.verticalSpace,


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

                    ],
                  ),
                ],
              ),
            ),

            if (_isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.white.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              )
          ],
        ),
      );
    }
    else {
      return  Center(child: CircularProgressIndicator(
        color: AppColors.primaryColor.withOpacity(0.5),
      ));
    }

          }
        ));
  }



  void showCard() async {
    try {
      _cardDetails = await dashboardProvider.getDetailsCard();
      setState(() {
        showCardDetails = !showCardDetails;
      });
    } catch (e) {
      AlertToast(context: context).showError(e.toString());
    }
  }
}
