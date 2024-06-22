
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tedfinance_mobile/shared/models/dashboard_models/card_details_model.dart';
import 'package:tedfinance_mobile/shared/models/dashboard_models/fund_card_model.dart';
import 'package:tedfinance_mobile/shared/models/dashboard_models/transfer_tedFinance_user.dart';
import 'package:tedfinance_mobile/shared/models/dashboard_models/username_lookup_model.dart';

import '../core/Dashboard/dashboard_state/home_state.dart';
import '../core/constants/api_constant.dart';
import '../core/enums/view_state.dart';
import '../core/env/app_config.dart';
import '../core/env/environment.dart';
import '../core/req_client.dart';
import '../core/utililies.dart';
import '../shared/models/dashboard_models/bank_model.dart';
import '../shared/models/dashboard_models/card_bal_model.dart';
import '../shared/models/dashboard_models/card_transactions_model.dart';
import '../shared/models/dashboard_models/current_ex_model.dart';
import '../shared/models/dashboard_models/wallet_model.dart';
import '../shared/models/kyc_model/name_equiry.dart';
import '../shared/models/kyc_model/transfer_model.dart';
import '../shared/util/storage.dart';

class DashboardProvider extends ChangeNotifier {
  ReqClient requestClient = ReqClient();

  BuildContext? context;


  HomeState homeState = HomeState();

  WalletModel? _walletModel;

  bool _isLoading = false;
  WalletModel? get walletModel => _walletModel;

  bool get isLoading => _isLoading;

  bool _isCardActivated = false;

  bool get isCardActivated => _isCardActivated;

  bool _isFrozen = false;

  bool get isFrozen => _isFrozen;



  String _errorMessage = "";

  String get errorMessage => _errorMessage;
  String _amount = '0.00';

  String get amount => _amount;

  void updateAmount(String newAmount) {
    _amount = newAmount;
    notifyListeners();
  }

  ViewState _homeViewState = ViewState.idle;

  ViewState get homeViewState => _homeViewState;

  setHomeViewState(ViewState viewState) {
    _homeViewState = viewState;
    notifyListeners();
  }


  ViewState _requestHomeViewState = ViewState.idle;

  ViewState get requestHomeViewState => _requestHomeViewState;

  setRequestHomeViewState(ViewState viewState) {
    _requestHomeViewState = viewState;
    notifyListeners();
  }
  Future<WalletModel> getWalletInfo() async {
    try {
      setRequestHomeViewState(ViewState.busy);
      Response response = await requestClient.getWithAuthHeaderClient(
        '${Environment().config.BASE_URL}/${APIConstants.WALLET_INFO}',
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Check if data exists before accessing it
        if (response.data != null) {
          if (response.data['data']['responseData'] != null) {
            WalletModel walletModel = WalletModel.fromJson(response.data['data']['responseData']);
            setHomeViewState(ViewState.completed);
            return walletModel;
          } else {
            _errorMessage = 'Failed to load wallet info - Missing Data';
            setHomeViewState(ViewState.error);
            throw Exception(_errorMessage);
          }
        } else {
          _errorMessage = 'Failed to load wallet info - No Data Received';
          setHomeViewState(ViewState.error);
          throw Exception(_errorMessage);
        }
      } else {
        _errorMessage = response.data["message"];
        setHomeViewState(ViewState.error);
        throw Exception(_errorMessage);
      }
    } on DioException catch (e) {
      print("siurofuy#dsd,$e");
      final err = Utilities.dioErrorHandler(e);
      _errorMessage = err;
      setHomeViewState(ViewState.error);
      throw Exception('Failed to load wallet info');
    }
  }




  Future<void> requestCard() async {
    try {
      setRequestHomeViewState(ViewState.busy);
      Response response = await requestClient.postWithAuthClient(
        '${Environment().config.BASE_URL}/${APIConstants.REQUEST_CARD}',
        {},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Card request successful, handle the response data
        // ...
        setHomeViewState(ViewState.completed);
      } else {
        _errorMessage = response.data["message"];
        setHomeViewState(ViewState.error);
        throw Exception(_errorMessage);
      }
    } on DioException catch (e) {
      print("siurofuy#dsd,$e");
      final err = Utilities.dioErrorHandler(e);
      _errorMessage = err;
      setHomeViewState(ViewState.error);
      throw Exception('Failed to request card');
    }
  }

  Future<CardDetailsModel> getDetailsCard() async {
    try {
      setRequestHomeViewState(ViewState.busy);
      Response response = await requestClient.getWithAuthHeaderClient (
        '${Environment().config.BASE_URL}/${APIConstants.GET_CARD_DETAILS}',
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data']['responseData'] != null) {
          CardDetailsModel cardDetailsModel = CardDetailsModel.fromJson(response.data['data']['responseData']);
          setHomeViewState(ViewState.completed);
          return cardDetailsModel;
        } else {
          _errorMessage = 'No data found';
          setHomeViewState(ViewState.error);
          throw Exception(_errorMessage);
        }
      } else {
        _errorMessage = response.data["message"];
        setHomeViewState(ViewState.error);
        throw Exception(_errorMessage);
      }
    } on DioException catch (e) {
      print("siurofuy#dsd,$e");
      final err = Utilities.dioErrorHandler(e);
      _errorMessage = err;
      setHomeViewState(ViewState.error);
      throw Exception('Failed to request card');
    }
  }

  Future<FundCardModel> fundCard(
      {required int amountUsd, required int amountNGN, required String sourceOfFund}) async {
    Map<String, dynamic> body = {
      "amountUsd": amountUsd,
      "amountNGN": amountNGN,
      "sourceOfFund": sourceOfFund
    };
    try {
      setRequestHomeViewState(ViewState.busy);
      Response response = await requestClient.postWithAuthClient(
        '${Environment().config.BASE_URL}/${APIConstants.FUND_CARD}',
        body,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data']['responseData'] != null) {
          FundCardModel fundCardModel = FundCardModel.fromJson(
              response.data['data']['responseData']);
          setHomeViewState(ViewState.completed);
          return fundCardModel;
        }
        else {
          setHomeViewState(ViewState.completed);
          return FundCardModel();
        }

      } else {
        _errorMessage = response.data["message"];
        setHomeViewState(ViewState.error);
        throw Exception(_errorMessage);
      }
    } on DioException catch (e) {
      print("siurofuy#dsd,$e");
      final err = Utilities.dioErrorHandler(e);
      _errorMessage = err;
      setHomeViewState(ViewState.error);
      throw Exception(_errorMessage);
    }
  }

  Future<void> freezeOrUnfreezeAccount(bool freeze) async {
    try {
      setRequestHomeViewState(ViewState.busy);
      Map<String, dynamic> body = {
        'freeze': freeze,
      };
      Response response = await requestClient.postWithAuthClient(
        '${Environment().config.BASE_URL}/${APIConstants.FREEZE_UNFREEZE}',
        body,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Account freezing or unfreezing successful, handle the response data
        // ...
        setHomeViewState(ViewState.completed);
      } else {
        _errorMessage = response.data["message"];
        setHomeViewState(ViewState.error);
        throw Exception(_errorMessage);
      }
    } on DioException catch (e) {
      print("siurofuy#dsd,$e");
      final err = Utilities.dioErrorHandler(e);
      _errorMessage = err;
      setHomeViewState(ViewState.error);
      throw Exception('Failed to freeze or unfreeze account');
    }
  }

  Future<void> deleteCard() async {
    try {
      setRequestHomeViewState(ViewState.busy);
      Response response = await requestClient.deleteWithAuthClient(
        '${Environment().config.BASE_URL}/${APIConstants.DELETE_CARD}',

      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Card deleted successfully
        setHomeViewState(ViewState.completed);
      } else {
        _errorMessage = response.data["message"];
        setHomeViewState(ViewState.error);
        throw Exception(_errorMessage);
      }
    } on DioException catch (e) {
      print("siurofuy#dsd,$e");
      final err = Utilities.dioErrorHandler(e);
      _errorMessage = err;
      setHomeViewState(ViewState.error);
      throw Exception('Failed to delete card');
    }
  }

  Future<CurrentFxModel> getCurrentFxRate() async {
    try {
      setRequestHomeViewState(ViewState.busy);
      Response response = await requestClient.getWithAuthHeaderClient(
        '${Environment().config.BASE_URL}/${APIConstants.CURRENT_FX_RATE}',
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data']['data']['responseData'] != null) {
          print( "e: ${response.data['data']['data']['responseData']}" );
          CurrentFxModel currentFxModel = CurrentFxModel.fromJson(response.data);
          // int cardUsdFee = response.data['data']['cardUsdFee'];
          //print('Card USD Fee: $cardUsdFee');  setHomeViewState(ViewState.completed);
          return  currentFxModel;
        } else {
          setHomeViewState(ViewState.error);
          throw Exception(_errorMessage);
        }
      } else {
        _errorMessage = response.data["message"];
        setHomeViewState(ViewState.error);
        throw Exception(_errorMessage);
      }
    } on DioException catch (e) {
      print("siurofuy#dsd,$e");
      final err = Utilities.dioErrorHandler(e);
      _errorMessage = err;
      setHomeViewState(ViewState.error);
      throw Exception('Failed to load current FX rate');
    }
  }
  // Future<CurrentFxModel?> getCurrentFxRate() async {
  //   try {
  //     setRequestHomeViewState(ViewState.busy);
  //     Response response = await requestClient.getWithAuthHeaderClient(
  //       '${Environment().config.BASE_URL}/${APIConstants.CURRENT_FX_RATE}',
  //     );
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final responseData = response.data['data']['data']['responseData'];
  //       if (responseData != null && responseData['responseData'] != null) {
  //         CurrentFxModel currentFxModel = CurrentFxModel.fromJson(responseData['responseData']);
  //         setHomeViewState(ViewState.completed);
  //         return currentFxModel;
  //       } else if (responseData != null && responseData['message'] != null) {
  //         _errorMessage = responseData['message'];
  //         setHomeViewState(ViewState.error);
  //         throw Exception(_errorMessage);
  //       } else {
  //         _errorMessage = 'Failed to load current FX rate - Missing Data';
  //         setHomeViewState(ViewState.error);
  //         throw Exception(_errorMessage);
  //       }
  //     } else {
  //       _errorMessage = response.data["message"];
  //       setHomeViewState(ViewState.error);
  //       throw Exception(_errorMessage);
  //     }
  //   } on DioException catch (e) {
  //     print("siurofuy#dsd,$e");
  //     final err = Utilities.dioErrorHandler(e);
  //     _errorMessage = err;
  //     setHomeViewState(ViewState.error);
  //     throw Exception('Failed to load current FX rate');
  //   }
  // }

  Future<void> withdrawFromCard(int? amount,) async {
    try {
      setRequestHomeViewState(ViewState.busy);
      Map<String, dynamic> body = {
        'amount': amount,

      };
      Response response = await requestClient.postWithAuthClient(
        '${Environment().config.BASE_URL}/${APIConstants.WITHDRAW_FROM_CARD}',
        body,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {

        setHomeViewState(ViewState.completed);
      } else {
        _errorMessage = response.data["message"];
        setHomeViewState(ViewState.error);
        throw Exception(_errorMessage);
      }
    } on DioException catch (e) {
      final err = Utilities.dioErrorHandler(e);
      _errorMessage = err;
      setHomeViewState(ViewState.error);
      throw Exception(_errorMessage);
    }
  }

  Future<CardBalModel> getCardBalance() async {
    try {
      setRequestHomeViewState(ViewState.busy);
      Response response = await requestClient.getWithAuthHeaderClient(
        '${Environment().config.BASE_URL}/${APIConstants.GET_CARD_BALANCE}',
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data']['responseData'] != null) {
          CardBalModel cardBalanceModel = CardBalModel.fromJson(response.data['data']['responseData']);
          setHomeViewState(ViewState.completed);
          return cardBalanceModel;
        } else {
          _errorMessage = 'Failed to load card balance';
          setHomeViewState(ViewState.error);
          throw Exception(_errorMessage);
        }
      } else {
        _errorMessage = response.data["message"];
        setHomeViewState(ViewState.error);
        throw Exception(_errorMessage);
      }
    } on DioException catch (e) {
      final err = Utilities.dioErrorHandler(e);
      _errorMessage = err;
      setHomeViewState(ViewState.error);
      throw Exception('Failed to load card balance');
    }
  }

  Future<List<TransactionsModel>> getCardTransactions() async {
    try {
      setRequestHomeViewState(ViewState.busy);
      Response response = await requestClient.getWithAuthHeaderClient(
        '${Environment().config.BASE_URL}/${APIConstants.GET_CARD_TRANSACTIONS}',
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data']['responseData'] != null) {
          List<TransactionsModel> cardTransactionsModel = (response.data['data']['responseData']['items'] as List)
              .map((e) => TransactionsModel.fromJson(e))
              .toList();
             setHomeViewState(ViewState.completed);
          return cardTransactionsModel;
        } else {
          _errorMessage = 'Failed to load card transactions';
          setHomeViewState(ViewState.error);
          throw Exception(_errorMessage);
        }
      }
      else {
        _errorMessage = response.data["message"];
        setHomeViewState(ViewState.error);
        throw Exception(_errorMessage);
      }
    } on DioException catch (e) {
      final err = Utilities.dioErrorHandler(e);
      _errorMessage = err;
      setHomeViewState(ViewState.error);
      throw Exception('Failed to load card transactions');
    }
  }

  Future<Username> lookupUsername(String username) async {
    try {
      setRequestHomeViewState(ViewState.busy);
      Response response = await requestClient.postWithAuthClient(
        '${Environment().config.BASE_URL}/${APIConstants.USERNAME_LOOKUP}',
        jsonEncode({'username': username}),
      );
      if (response.statusCode == 200 || response.statusCode == 201 ) {
        final responseData = response.data['data'];
        final usernameModel = Username.fromJson(responseData);
        setRequestHomeViewState(ViewState.completed);
        return usernameModel;
      } else {
        _errorMessage = response.data["message"];
        setRequestHomeViewState(ViewState.error);
        throw Exception(_errorMessage);
      }
    } on DioException catch (e) {
      final err = Utilities.dioErrorHandler(e);
      _errorMessage = err;
      setRequestHomeViewState(ViewState.error);
      throw Exception(_errorMessage);
    }
  }

  Future<TedFinanceUser> sendMoneyToTedFinanceUser(
      {  int? amount,
       int? recieverId,
       String? clientReference,
       String? narration
      }) async {
    Map<String, dynamic> body = {
      'amount': amount,
      'recieverId': recieverId,
      'clientReference': clientReference,
      'narration': narration,
    };
    try {
      setRequestHomeViewState(ViewState.busy);
      Response response = await requestClient.postWithAuthClient(
        '${Environment().config.BASE_URL}/${APIConstants.SEND_MONEY_TO_TEDFINANCE_USER}',
        body
      );
      if (response.statusCode == 200) {
        // Handle the response data
        final responseData = response.data['data']['responseData'];
        final usernameData = response.data['data'];
        final tedFinanceModel = TedFinanceUser.fromJson(responseData);
       // final usernameModel = Username.fromJson(usernameData);


        setRequestHomeViewState(ViewState.completed);

         return tedFinanceModel;
        // return  SendMoneyResponse(
        //   usernameModel: usernameModel,
        //   tedFinanceUser: tedFinanceModel,
        // );
      } else {
        _errorMessage = response.data["message"];
        setRequestHomeViewState(ViewState.error);
        throw Exception(_errorMessage);
      }
    } on DioException catch (e) {
      final err = Utilities.dioErrorHandler(e);
      _errorMessage = err;
      setRequestHomeViewState(ViewState.error);
      throw Exception('Failed to send money');
    }
  }

  Future<List<BankModel>> getBanks() async {
    try {
      setHomeViewState(ViewState.busy);
      Response? response = await requestClient.getWithAuthHeaderClient(
        '${Environment().config.BASE_URL}/${APIConstants.GET_BANKS}',
      );

      if (response != null) {
        final responseData = response.data;
        if (response.statusCode == 200 || response.statusCode == 201) {
          if (response.data['data']['responseData'] != null){
            List<BankModel> banks =
            (response.data ['data']['responseData']as List)
                .map((e) => BankModel.fromJson(e)).toList();

            setHomeViewState(ViewState.completed);
            return banks;
          }
          else {
            _errorMessage = response.data["message"];
            setHomeViewState(ViewState.error);
            throw Exception(_errorMessage);
          }
        }
        else {
          _errorMessage = responseData["message"];
          setHomeViewState(ViewState.error);
          throw Exception(_errorMessage);
        }
      } else {
        throw Exception(_errorMessage);
      }
    } on DioException catch (e) {
      final err = Utilities.dioErrorHandler(e);
      _errorMessage = err;
      setHomeViewState(ViewState.error);
      throw Exception(_errorMessage);
    }
  }
  Future nameEnquiry(String bankCode, String accountNumber) async {
    try {
      setRequestHomeViewState(ViewState.busy);
      Response response = await requestClient.postWithAuthClient(
        '${Environment().config.BASE_URL}/${APIConstants.NAME_ENQUIRY}',
        jsonEncode({
          "bankCode": bankCode,
          "accountNumber": accountNumber
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['data'] != null) {
          String nameEquiry = response.data['data']['responseData'];
         // NameEquiryModel nameEquiry = NameEquiryModel.fromJson(response.data['data']);
          setHomeViewState(ViewState.completed);
          return nameEquiry;
        } else {
          _errorMessage = 'Failed to load card balance';
          setHomeViewState(ViewState.error);
          throw Exception(_errorMessage);
        }
      } else {
        _errorMessage = response.data["message"];
        setHomeViewState(ViewState.error);
        throw Exception(_errorMessage);
      }
    } on DioException catch (e) {
      final err = Utilities.dioErrorHandler(e);
      _errorMessage = err;
      setHomeViewState(ViewState.error);
      throw Exception('Failed to load card balance');
    }
  }

  Future<OutwardTransferModel> outwardTransfer({
     String ? sourceAccountId,
     int ? amount,
     String ? clientReference,
     String ? narration,
     String ? destinationBankCode,
     String ? destinationAccount,
     String ? destinationAccountName,
     String ? destinationBankName,
  }) async {
    try {
      setRequestHomeViewState(ViewState.busy);
      Response response = await requestClient.postWithAuthClient(
        '${Environment().config.BASE_URL}/${APIConstants.OUTWARD_TRANSFER}',
        jsonEncode({
          "sourceAccountId": sourceAccountId,
          "amount": amount,
          "clientReference": clientReference,
          "narration": narration,
          "destinationBankCode": destinationBankCode,
          "destinationAccount": destinationAccount,
          "destinationAccountName": destinationAccountName,
          "destinationBankName": destinationBankName
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null) {
          OutwardTransferModel outwardTransferResponse =
          OutwardTransferModel.fromJson(response.data['data']['responseData']);
          setHomeViewState(ViewState.completed);
          return outwardTransferResponse;
        } else {
          _errorMessage = 'Failed to load outward transfer - No Data Received';
          setHomeViewState(ViewState.error);
          throw Exception(_errorMessage);
        }
      } else {
        _errorMessage = response.data["message"];
        setHomeViewState(ViewState.error);
        throw Exception(_errorMessage);
      }
    } on DioException catch (e) {
      print("siurofuy#dsd,$e");
      final err = Utilities.dioErrorHandler(e);
      _errorMessage = err;
      setHomeViewState(ViewState.error);
      throw Exception('Failed to load outward transfer');
    }
  }







  void setCardActivated(bool value) {
    _isCardActivated = value;
    notifyListeners();
  }
}
// @festusifo