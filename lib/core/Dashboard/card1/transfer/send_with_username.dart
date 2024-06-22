import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tedfinance_mobile/providers/dashboard_provider.dart';
import 'package:tedfinance_mobile/shared/models/auth_models/user.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';

import '../../../../shared/models/dashboard_models/card_bal_model.dart';
import '../../../../shared/models/dashboard_models/current_ex_model.dart';
import '../../../../shared/models/dashboard_models/transfer_tedFinance_user.dart';
import '../../../../shared/models/dashboard_models/username_lookup_model.dart';
import '../../../../shared/models/dashboard_models/wallet_model.dart';
import '../../../../shared/util/asset_images.dart';
import '../../../../shared/util/widgets/appbar.dart';
import '../../../../shared/util/widgets/custom_containers.dart';
import '../../../../shared/util/widgets/custom_text_form_field.dart';
import '../../../../theme/custom_text_style.dart';
import '../../../env/utils/alert_toast.dart';
import '../../../env/utils/colors.dart';
import '../../../env/utils/string_resources.dart';
import '../../../utililies.dart';
import '../../drawer/bottom_sheet/root.dart';

class SendWithUsername extends StatefulWidget {
  const SendWithUsername({super.key});

  @override
  State<SendWithUsername> createState() => _SendWithUsernameState();
}

class _SendWithUsernameState extends State<SendWithUsername> {
  String _selectedCurrency = '';
  final selectedCurrency = SelectedCurrency();
  late DashboardProvider dashboardProvider ;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fundSourceController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _narrationController = TextEditingController();
  Timer? _debounce;
  Username? usernameModel;
  CardBalModel? cardBalModel;
  CurrentFxModel? currentFxModel;
  int? receiverId;
  WalletModel? walletModel;
  String? usernamePage;
  int? _amount;
  Utilities utils = Utilities();
  TedFinanceUser? tedFinanceUser;

  User? user;

  void _handleSelection(String value) {
    final currency = value.split('-')[0];
  setState(() {
      _selectedCurrency = currency;
    });
  }
  void _lookupUsername(String username) async {
    try {
      final Username result = await dashboardProvider.lookupUsername(username);
      setState(() {
        usernameModel = result;
      });
    } catch (e) {
      AlertToast(context: context).showError(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      Provider.of<DashboardProvider>(context, listen: false)
          .getCardBalance()
          .then((value) {
        if (mounted) {
          setState(() {
            cardBalModel = value;
          });
        }
      });
      fetchWalletInfo();
      // Provider.of<DashboardProvider>(context, listen: false)
      //     .getCurrentFxRate()
      //     .then((value) {
      //   if (mounted) {
      //     setState(() {
      //       currentFxModel = value;
      //     });
      //   }
      // });
    }


    );
  }
  Future<void> fetchWalletInfo() async {
    try {
      final walletInfo = await Provider.of<DashboardProvider>(context, listen: false).getWalletInfo();
      setState(() {
        walletModel = walletInfo;

      });
    } catch (e) {
      if (e.toString().contains(e.toString())) {
        setState(() {
          walletModel = null;

        });
      } else {
        rethrow;
      }
    }
  }
  @override
  void dispose() {
    _usernameController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    return Scaffold(
        appBar: const TedAppBar(
          elevation: 0,
          titleText: StringResources.transfer,
          trailing: SizedBox(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(StringResources.transfer_from_wallet,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.titleSmallBlack900_1.copyWith(
                        fontSize: 14.sp, fontWeight: FontWeight.w400)),
                30.verticalSpace,

                CustomTextFormField(
                  headerText: "Source of funds",
                  hintText: "Select Sources of funds",
                  initialValue: _selectedCurrency.isEmpty ? null : _selectedCurrency,

                  controller: _fundSourceController,
                  autofocus: false,
                  onChange: (currency) {
                    _selectedCurrency = currency;
                    setState(() {});
                  },
                  suffix: DropdownButton(
                    value: _selectedCurrency.isEmpty ? null : _selectedCurrency,
                    underline: Container(height: 0),
                    items: [
                      DropdownMenuItem(
                        value: 'NGN',
                        child: LayoutBuilder(builder: (context, constraints) {
                          return ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 390.w, maxHeight: 100.h), // Adjust the width as necessary
                            child: GestureDetector(
                              onTap: () => _handleSelection('NGN'),
                           child: Row(
                                children: [
                                  Image.asset(AssetResources.nigWhiteFlag2),
                                   SizedBox(width: 10.w),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       const Text(
                                        'NGN',
                                        style: TextStyle(fontWeight: FontWeight.w600,),
                                      ),
                                      Text(
                                        'Nigeria Naira',
                                        style: TextStyle(color: Colors.grey[64], fontSize: 14.sp),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                             Text(
                                    "\₦${walletModel?.accountBalance ?? "0.00"}",
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                          )
                          );
                        }),
                      ),
                    ],
                    onChanged: (value) {
                      _handleSelection(value!);
                    },
                  ),
                ),

                30.verticalSpace,
                 CustomTextFormField(
                  headerText: "Amount",
                  hintText: "Enter amount",
                   controller: _amountController,
                   onChange: (value) {
                     Provider.of<DashboardProvider>(context, listen: false).updateAmount(value);
                     _amount = int.parse(value);
                   },
                ),
                30.verticalSpace,
                CustomTextFormField(
                    headerText: "Receiver’s Username",
                    hintText: "@username",
                    controller: _usernameController,
                    hintStyle: TextStyle(
                        color: AppColors.white, fontWeight: FontWeight.w500),
                    fillColor: AppColors.primaryColor,
                    filled: true,
                    borderDecoration: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    onChange: (value) {
                      if (_debounce?.isActive ?? false) _debounce?.cancel();
                      _debounce = Timer(const Duration(milliseconds: 1500), () {
                        if (value.isNotEmpty) {
                          _lookupUsername(value.trim());
                        }
                      });
                    }

                ),
                30.verticalSpace,
                usernameModel != null
                    ? PaymentContainer(
                  onTap: () {
                    //confirmWithdrawSheet(context: context);
                  },
                  imagePath: AssetResources.picNig,
                  titleText: "${usernameModel!.firstName} ${usernameModel?.lastName}",
                  subTitleText: usernameModel!.username ??
                      StringResources.offical_teo,
                  isSvg: false,
                )
                    : const SizedBox.shrink(),
                30.verticalSpace,
                CustomTextFormField(
                  headerText: "Narration",
                  hintText: "Narration",
                  controller: _narrationController,
                  maxLines: 3,
                ),
                30.verticalSpace,
                Text('Choose beneficiary',
                    style: CustomTextStyles.bodySmallGray500
                        .copyWith(color: AppColors.primaryColor)),
                40.verticalSpace,
                Center(
                  child: AppButton(
                    onPressed: () {
                      sendMoneyWithUsername();
                      // if (_fundSourceController.text.isNotEmpty ||
                      //     _amountController.text.isNotEmpty ||
                      //     _usernameController.text.isNotEmpty) {
                      //   withdrawWithUsernameSheet(
                      //     context: context,
                      //     isSendWithUsername: _usernameController.text,
                      //     amount: _amount,
                      //     fund: _selectedCurrency
                      //   );
                      // } else {
                      //   AlertToast(context: context,).showError("Please fill in all fields");

                      //}
                    },
                    text: 'Confirm',
                    radius: 30.r,
                    width: 350.w,
                  ),
                )
                // Center(
                //   child: AppButton(
                //     onPressed: () {
                //
                //       withdrawWithUsernameSheet(context: context, isSendWithUsername: usernamePage);
                //
                //     },
                //     text: 'Confirm',
                //     radius: 30.r,
                //     width: 350.w,
                //   ),
                // )
              ],
            ),
          ),
        )
    );
  }
  Future <void> sendMoneyWithUsername() async {
    try {
      print('receiverId: ${usernameModel!.id!}');
      await dashboardProvider.sendMoneyToTedFinanceUser(
        amount: _amount?.toInt() ,
        recieverId: usernameModel?.id ?? 0,
        clientReference:  utils.generateClientReference(),
        narration: _narrationController.text
      );
      withdrawWithUsernameSheet(
          context: context,
          amount: _amount?.toInt(),
          recieverId: usernameModel?.id,
          receiverName:
          //"${usernameModel!.firstName} ${usernameModel?.lastName}",
          tedFinanceUser?.sourceAccountName,
          receiverUsername:
          //usernameModel!.username,
          _usernameController.text,
          narration: _narrationController.text,
          clientReference: utils.generateClientReference(),
          currency: _selectedCurrency

          // fund: tedFinanceUser.
      );
      // withdrawWithUsernameSheet(context: context, isSendWithUsername: usernamePage);
    } catch (e) {
      AlertToast(context: context,).showError(e.toString());
    }
  }

}
