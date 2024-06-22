import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tedfinance_mobile/core/env/utils/string_resources.dart';
import 'package:tedfinance_mobile/shared/models/kyc_model/name_equiry.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_elevated_button.dart';
import 'package:tedfinance_mobile/shared/util/widgets/custom_text_form_field.dart';
import 'package:tedfinance_mobile/theme/custom_text_style.dart';

import '../../../../providers/dashboard_provider.dart';
import '../../../../shared/models/dashboard_models/bank_model.dart';
import '../../../../shared/models/dashboard_models/wallet_model.dart';
import '../../../../shared/models/kyc_model/transfer_model.dart';
import '../../../../shared/navigations/routes/validator.dart';
import '../../../../shared/util/widgets/appbar.dart';
import '../../../env/utils/colors.dart';
import '../../../utililies.dart';
import '../../drawer/bottom_sheet/root.dart';
import '../../kyc/select_country.dart';
import 'dart:convert';

class BankAccountDetails extends StatefulWidget {
  const BankAccountDetails({super.key});

  @override
  State<BankAccountDetails> createState() => _BankAccountDetailsState();
}

class _BankAccountDetailsState extends State<BankAccountDetails> {
  bool _loadingBanks = false;
  WalletModel? walletModel;
  List<BankModel> banks = [];
  String? fetchedAccountName;
  BankModel? selectedBank;
  String? accountName ;
  String? accountNumber;
  String? transfer = '';
  bool isLoading = false;
  NameEquiryModel? nameEquiryModel;
  String? errorMessage;
  late DashboardProvider dashboardProvider;
  final TextEditingController _narrationController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  BanksSingleton banksSingleton = BanksSingleton();
  OutwardTransferModel? outwardTransferModel;
  Utilities utils = Utilities();

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      Provider.of<DashboardProvider>(context, listen: false)
          .getWalletInfo()
          .then((value) {
        setState(() {
          walletModel = value;
        });
      });
      if (banksSingleton.banks.isEmpty) {
        fetchBanks();
      } else {
        banks = banksSingleton.banks;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    return Scaffold(
        appBar: const TedAppBar(
          elevation: 0,
          titleText: StringResources.bankAccountDetails,
          trailing: SizedBox(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
            child: Column(
              children: [
                AppDropdownModal(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, top: 5.0, right: 15, bottom: 8),
                    child: SvgPicture.asset(
                      AssetResources.addPayIcon,
                      height: 35,
                      width: 22,
                    ),
                  ),
                  options: banks,
                  value: selectedBank,
                  isLoading: _loadingBanks,
                  useMargin: false,
                  hasSearch: true,
                  onChanged: (BankModel? val) {
                    selectedBank = val;
                    // selectedCustomers = val;
                    setState(() {});
                  },
                  validator: (v) {
                    return null;
                  },
                  modalHeight: 710.h,
                  headerText: "Bank",
                  hintText: "Select Bank",
                ),
                30.verticalSpace,
                CustomTextFormField(
                  headerText: "Account Number",
                  hintText: "Recipient  Account Number ",
                  controller: _accountNumberController,
                  textInputType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field is required";
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return "Only digits are allowed";
                    }
                    return null;
                  },
                  textInputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  onChange: (String value) {
                    setState(() {
                      accountName = value;

                      if (value.length == 10) {
                        isLoading = true;
                        accountNum().then((value) => isLoading = false);
                      } else {
                        accountName = '';
                      }
                    });
                  },
                  suffix: isLoading ? const CupertinoActivityIndicator() : null,
                ),
                30.verticalSpace,
                CustomTextFormField(
                  headerText: "Full name",
                  hintText: "Recipient Name",
                  //initialValue: accountName,
                   controller: _fullNameController,
                 // initialValue: nameEquiryModel?.responseData,
                  onChange: (value) {
                    setState(() {
                      accountName = value;
                    });
                  },
                  enabled: false,
                ),

                30.verticalSpace,
                CustomTextFormField(
                  headerText: "Amount",
                  hintText: "Enter amount",
                  controller: _amountController,

                ),
                30.verticalSpace,
                CustomTextFormField(
                  headerText: "Email(Optional)",
                  hintText: "Recipient Email Address",
                  controller: _emailController,
                ),
                30.verticalSpace,
                CustomTextFormField(
                  headerText: "Narration",
                  hintText: "Narration",
                  controller: _narrationController,
                  maxLines: 3,
                ),
                180.verticalSpace,
                Row(
                  children: [
                    SvgPicture.asset(AssetResources.questionIcon),
                    10.horizontalSpace,
                    Text(
                      StringResources.by_proceeding_with_this_payment,
                      style: CustomTextStyles.titleSmallBlack400
                          .copyWith(color: AppColors.tedDeepPurple),
                    )
                  ],
                ),
                30.verticalSpace,
                AppButton(
                  width: 340.w,
                  onPressed: () {
                    transferFund();
                  },
                  radius: 30.r,
                  text: 'Continue',
                )
              ],
            ),
          ),
        ));
  }

  Future<void> fetchBanks() async {
    setState(() {
      _loadingBanks = true;
      errorMessage = null;
    });

    try {
      banks = await Provider.of<DashboardProvider>(context, listen: false)
          .getBanks();
      if (banks.isNotEmpty) {
        banksSingleton.banks = banks;
      }

      setState(() {});
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      setState(() {
        _loadingBanks = false;
      });
    }
  }

  Future<String?> accountNum() async {
    setState(() {
      _loadingBanks = true;
      errorMessage = null;
    });
    try {
      accountName = await Provider.of<DashboardProvider>(context, listen: false)
          .nameEnquiry(
              selectedBank!.bankName ?? '', _accountNumberController.text  );
   _fullNameController.text = accountName ?? '';
      return accountName;
      // if (accountName .isNotEmpty) {
      //   banksSingleton.accountName  = accountName ;
      // }

      setState(() {});
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      setState(() {
        _loadingBanks = false;
      });
    }
    return null;
  }

  Future transferFund() async {
    setState(() {
      _loadingBanks = true;
      errorMessage = null;
    });
    try {
      OutwardTransferModel result =
          await Provider.of<DashboardProvider>(context, listen: false)
              .outwardTransfer(
        sourceAccountId: walletModel!.accountId.toString(),
              amount: int.parse(_amountController.text),
        clientReference: utils.generateClientReference(),
        narration: _narrationController.text,
        destinationBankCode: selectedBank!.bankCode ?? '',
        destinationAccount: _accountNumberController.text,
        destinationAccountName: _fullNameController.text,
        destinationBankName: selectedBank!.displayName,
      );
      if (result != null) {
        confirmAccountSheet(
            context: context,
          accountName: _fullNameController.text,
          bankName: selectedBank!.displayName,
          accountNum: _accountNumberController.text,


        );
      } else {
        errorMessage;
      }
      // if (accountName .isNotEmpty) {
      //   banksSingleton.accountName  = accountName ;
      // }

      setState(() {});
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      setState(() {
        _loadingBanks = false;
      });
    }
  }
}

class BanksSingleton {
  static final BanksSingleton _banksSingleton =
      BanksSingleton._createInstance();

  BanksSingleton._createInstance();

  factory BanksSingleton() {
    return _banksSingleton;
  }

  List<BankModel> banks = [];
}

// confirmAccountSheet(
// context: context,
// accountName: _fullNameController.text,
// bankName: selectedBank!.displayName,
// accountNum: _accountNumberController.text,
// amount: int.parse(_amountController.text),
// clientReference: utils.generateClientReference(),
// narration: _narrationController.text,
// bankCode: selectedBank!.bankCode ?? '',
// outwardTransferModel: outwardTransferModel
// // destinationAccount: _accountNumberController.text,
// // destinationAccountName: _fullNameController.text,
// //destinationBankName: selectedBank!.displayName,
//
//
// );