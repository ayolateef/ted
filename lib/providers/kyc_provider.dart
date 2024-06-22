import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tedfinance_mobile/shared/models/kyc_model/save_bvn_model.dart';
import '../core/Dashboard/kyc/select_country.dart';
import '../core/Dashboard/kyc/upload_files.dart';
import '../core/auth/auth_state.dart';
import '../core/constants/api_constant.dart';
import '../core/enums/view_state.dart';
import '../core/env/environment.dart';
import '../core/env/utils/alert_toast.dart';
import '../core/req_client.dart';
import '../core/utililies.dart';
import '../shared/models/kyc_model/bvn_model.dart';
import '../shared/models/kyc_model/country_model.dart';
import '../shared/models/kyc_model/kyc_progress_model.dart';
import '../shared/models/kyc_model/nin_model.dart';
import '../shared/models/kyc_model/save_nin_model.dart';
import '../shared/util/share_preference_util.dart';

class KYCProvider extends ChangeNotifier {
  ReqClient requestClient = ReqClient();

  BuildContext? context;
  KYCProgressModel? _kycProgressModel;
  KYCProgressModel? get kycProgressModel => _kycProgressModel;

  AuthState authState = AuthState();

  String _errorMessage = "";
  String get errorMessage => _errorMessage;
  //3755

  ViewState _kycViewState = ViewState.idle;
  ViewState get kycViewState => _kycViewState;

  setKYCViewState(ViewState viewState) {
    _kycViewState = viewState;
    notifyListeners();
  }

  ViewState _requestOtpViewState = ViewState.idle;
  ViewState get requestOtpViewState => _requestOtpViewState;
  setRequestOtpViewState(ViewState viewState) {
    _requestOtpViewState = viewState;
    notifyListeners();
  }
  //
  // Future<List<CountryListModel>> getCountries() async {
  //   try {
  //     Response response = await requestClient.getWithAuthHeaderClient(
  //       '${Environment().config.BASE_URL}/${APIConstants.COUNTRIES}',
  //     );
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       if (response.data != null && response.data['data'] != null) {
  //
  //         List<dynamic> responseData = response.data['data'] as List<dynamic>;
  //         List<CountryListModel> countries = [];
  //         for (var country in responseData) {
  //           countries.add(CountryListModel.fromJson(country));
  //         }
  //         return countries;
  //       } else {
  //         throw Exception('Failed to load countries');
  //       }
  //     }
  //
  //     else {
  //       throw Exception('Failed to load countries');
  //     }
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
  Future<List<CountryListModel>> getCountries() async {
    try {
      Response response = await requestClient.getWithAuthHeaderClient(
        '${Environment().config.BASE_URL}/${APIConstants.COUNTRIES}',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<CountryListModel> countries = (response.data['data'] as List)
            .map((data) => CountryListModel.fromJson(data))
            .toList();
        return countries;
      } else {
        throw Exception('Failed to load countries');
      }
    } catch (e) {
      throw Exception(e);
    }
  }


  Future<SetCountryModel?> setCountry(String country) async {
    Map<String, dynamic> body = {"country": country};

    try {
      setRequestOtpViewState(ViewState.busy);
      Response response = await requestClient.postWithAuthClient(
          '${Environment().config.BASE_URL}/${APIConstants.UPDATE_COUNTRIES}',
          body);
      log("error:${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        setRequestOtpViewState(ViewState.completed);
        return SetCountryModel.fromJson(response.data['data']);
      } else {
        _errorMessage = response.data["message"];
        setRequestOtpViewState(ViewState.error);
        return null;
      }
    } on DioException catch (e) {
      final err = Utilities.dioErrorHandler(e);
      _errorMessage = err;
      setRequestOtpViewState(ViewState.error);
      return null;
    }
  }

  Future<Map<String, dynamic>?> verifyBVN(String bvn) async {
    Map<String, dynamic> body = {"bvn": bvn};
    try {
      setKYCViewState(ViewState.busy);
      Response response = await requestClient.postWithAuthClient(
        '${Environment().config.BASE_URL}/${APIConstants.VERIFY_BVN}',
        body,
      );
      log("error:${response.data.toString()}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null && response.data['data'] != null) {
          //BVNModel.fromJson(response.data['data']);
          BVNModel bvnModel = BVNModel.fromJson(
              response.data['data']['data']['data']['responseObject']);
          String? phoneNumber = bvnModel.phoneNumber;
          String? otp = bvnModel.otp;
          log("OTP received: $otp");
          return {
            'bvnModel': bvnModel,
            'phoneNumber': phoneNumber,
            'otp': otp,
          };
        } else {
          _errorMessage = "Invalid response structure or missing data";
          setKYCViewState(ViewState.error);
          return null;
        }
      } else {
        _errorMessage = response.data["message"];
        setKYCViewState(ViewState.error);
        return null;
      }
    } on DioException catch (e) {
      final err = Utilities.dioErrorHandler(e);
      _errorMessage = err;
      setKYCViewState(ViewState.error);
      return null;
    }
  }

  Future<void> saveBVN(String bvn) async {
    Map<String, dynamic> body = {"bvn": bvn};

    try {
      Response response = await requestClient.postWithAuthClient(
        '${Environment().config.BASE_URL}/${APIConstants.SAVE_BVN}',
        body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        SaveBVNModel.fromJson(response.data['data']);
        // BVN saved successfully
        log("BVN saved successfully");
        if (context != null) {
          AlertToast(context: context!).showSuccess("BVN saved successfully");
        }
      } else {
        _errorMessage = response.data["message"];
        setKYCViewState(ViewState.error);
      }
    } on DioException catch (e) {
      final err = Utilities.dioErrorHandler(e);
      _errorMessage = err;
      setKYCViewState(ViewState.error);
    }
  }

  Future<NINModel?> verifyNIN(String nin) async {
    Map<String, dynamic> body = {"nin": nin};

    try {
      setKYCViewState(ViewState.busy);
      Response response = await requestClient.postWithAuthClient(
        '${Environment().config.BASE_URL}/${APIConstants.VERIFY_NIN}',
        body,
      );

      log("Full Response Data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null) {
          print('Response data: ${response.data}');
          print('Response data["data"]: ${response.data['data']}');

          final responseData = response.data['data']['data'];
          final responseObject = responseData['data']['responseObject'];
          if (responseObject != null) {
            NINModel bvnModel = NINModel.fromJson(responseObject);
            print('NIN: ${bvnModel.nin}');
            print('First Name: ${bvnModel.firstName}');
            print('Last Name: ${bvnModel.lastName}');
            return bvnModel;
          } else {
            _errorMessage = "responseObject is null";
            setKYCViewState(ViewState.error);
            return null;
          }
        } else {
          _errorMessage = "Response data is null";
          setKYCViewState(ViewState.error);
          return null;
        }
      } else {
        _errorMessage = response.data["message"] ?? "Unknown error occurred";
        setKYCViewState(ViewState.error);
        return null;
      }
    } on DioException catch (e) {
      final err = Utilities.dioErrorHandler(e);
      _errorMessage = err;
      setKYCViewState(ViewState.error);
      return null;
    }
  }

  Future<void> saveNIN(String nin) async {
    Map<String, dynamic> body = {"nin": nin};

    try {
      Response response = await requestClient.postWithAuthClient(
        '${Environment().config.BASE_URL}/${APIConstants.SAVE_NIN}',
        body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        SaveNINModel.fromJson(response.data);
        // BVN saved successfully
        log("NIN saved successfully");
        if (context != null) {
          AlertToast(context: context!).showSuccess("BVN saved successfully");
        }
      } else {
        _errorMessage = response.data["message"];
        setKYCViewState(ViewState.error);
      }
    } on DioException catch (e) {
      final err = Utilities.dioErrorHandler(e);
      _errorMessage = err;
      setKYCViewState(ViewState.error);
    }
  }

  Future<bool> verifyOTP({
    required String phone,
    required String code,
  }) async {
    Map<String, dynamic> body = {
      "email": phone,
      "code": code,
    };

    try {
      setRequestOtpViewState(ViewState.busy);
      log("Sending OTP verification request with body: $body");

      Response response = await requestClient.postWithoutHeaderClient(
          '${Environment().config.BASE_URL}/${APIConstants.VERIFY_OTP}', body);
      log("OTP verification response: ${response.data}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        await SharedPreferenceUtils.storePhoneNum(phone);
        setRequestOtpViewState(ViewState.completed);
        return true;
      } else {
        _errorMessage = response.data["message"];
        setRequestOtpViewState(ViewState.error);
        return false;
      }
    } on DioException catch (e) {
      final err = Utilities.dioErrorHandler(e);
      _errorMessage = err;
      setRequestOtpViewState(ViewState.error);
      return false;
    }
  }

  Future<bool> updateBio(
    String firstName,
    String lastName,
    String gender,
    String phone,
    String country,
    String city,
    String state,
    String dob,
    String address,
  ) async {
    Map<String, dynamic> body = {
      "firstName": firstName,
      "lastName": lastName,
      "gender": gender,
      "phone": phone,
      "country": country,
      "city": city,
      "state": state,
      "dob": dob,
      "address": address,
    };

    try {
      setKYCViewState(ViewState.busy);
      Response response = await requestClient.postWithAuthClient(
          '${Environment().config.BASE_URL}/${APIConstants.UPDATE_BIO}', body);
      log("error:${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        setKYCViewState(ViewState.completed);
        return true;
      } else {
        _errorMessage = response.data["message"];
        setKYCViewState(ViewState.error);
        return false;
      }
    } on DioException catch (e) {
      final err = Utilities.dioErrorHandler(e);
      _errorMessage = err;
      setKYCViewState(ViewState.error);
      return false;
    }
  }

  Future<bool> updateAdditionalInfo(String sourceOfIncome,
      String employmentStatus, String occupation, String incomeBand) async {
    Map<String, dynamic> body = {
      "sourceOfIncome": sourceOfIncome,
      "employmentStatus": employmentStatus,
      "occupation": occupation,
      "incomeBand": incomeBand,
    };

    try {
      setKYCViewState(ViewState.busy);
      Response response = await requestClient.postWithAuthClient(
          '${Environment().config.BASE_URL}/${APIConstants.ADDITIONAL_INFO}',
          body);
      log("error:${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        setKYCViewState(ViewState.completed);
        return true;
      } else {
        _errorMessage = response.data["message"];
        setKYCViewState(ViewState.error);
        return false;
      }
    } on DioException catch (e) {
      final err = Utilities.dioErrorHandler(e);
      _errorMessage = err;
      setKYCViewState(ViewState.error);
      return false;
    }
  }

  Future<bool> uploadDocument({
    required List<DocToSend?> documents,
    required String idType,
    required String idNumber,
  }) async {
    try {
      log('uploadDocument started');
      setKYCViewState(ViewState.busy);
      log('View state set to busy');

      FormData formData = FormData();

      formData.fields.add(MapEntry('idNumber', idNumber));
      formData.fields.add(MapEntry('idType', idType));

      for (var document in documents) {
        if (document != null &&
            document.file != null &&
            document.type != null) {
          formData.files.add(MapEntry(
            document.type!,
            await MultipartFile.fromFile(document.file!.path,
                filename: document.file!.path.split('/').last),
          ));
          log('Added document ${document.type} to formData');
        }
      }
      Response response = await requestClient.postWithAuthClient(
          '${Environment().config.BASE_URL}/${APIConstants.UPLOAD_DOC}',
          formData);

      //log('Response received');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // log('Response status: ${response.statusCode}');
        // log('Response data: ${response.data}');
        setKYCViewState(ViewState.completed);
        return true;
      } else {
        _errorMessage = response.data["message"];
        // log('Response error message: $_errorMessage');
        setKYCViewState(ViewState.error);
        return false;
      }
    } on DioError catch (e) {
      final err = Utilities.dioErrorHandler(e);
      // log('DioError: $err');
      _errorMessage = err;
      setKYCViewState(ViewState.error);
      return false;
    } catch (e) {
      // log('Exception: $e');
      _errorMessage = e.toString();
      setKYCViewState(ViewState.error);
      return false;
    }
  }

  Future<bool> uploadSelfie({required File selfieFile}) async {
    try {
      setKYCViewState(ViewState.busy);
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(selfieFile.path,
            filename: "selfie.jpg"),
      });
      Response response = await requestClient.postWithAuthClient(
          '${Environment().config.BASE_URL}/${APIConstants.UPLOAD_SELFIE}',
          formData);
      log("error:${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        setKYCViewState(ViewState.completed);
        return true;
      } else {
        _errorMessage = response.data["message"];
        setKYCViewState(ViewState.error);
        return false;
      }
    } on DioException catch (e) {
      final err = Utilities.dioErrorHandler(e);
      _errorMessage = err;
      setKYCViewState(ViewState.error);
      return false;
    }
  }

  Future<KYCProgressModel?> getKYCProgress() async {
    try {
      setRequestOtpViewState(ViewState.busy);

      Response response = await requestClient.getWithAuthHeaderClient(
        '${Environment().config.BASE_URL}/${APIConstants.KYC_PROGRESS}',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          //  response.data is not null and is a map
          if (response.data != null && response.data is Map<String, dynamic>) {
            KYCProgressModel model =
                KYCProgressModel.fromJson(response.data);
            setRequestOtpViewState(ViewState.completed);
            return model;
          } else {
            _errorMessage = "Unexpected response format";
            setRequestOtpViewState(ViewState.error);
            return null;
          }
        } catch (e) {
          _errorMessage = "Error parsing data: $e";
          setRequestOtpViewState(ViewState.error);
          return null;
        }
      } else {
        _errorMessage = response.data["message"];
        setRequestOtpViewState(ViewState.error);
        return null;
      }
    } on DioException catch (e) {
      final err = Utilities.dioErrorHandler(e);
      _errorMessage = err;
      setRequestOtpViewState(ViewState.error);
      return null;
    } catch (e) {
      _errorMessage = "Unexpected error: $e";
      setRequestOtpViewState(ViewState.error);
      return null;
    }
  }
}

// {"status":"success","data":{"_id":"6650f27b45815af7a2f0a52a","userId":"6650e00145815af7a2f0a511","isKYCVerified":"PENDING","countryOfDocument":"Nigeria","kycStep":6,"createdAt":"2024-05-24T20:03:07.062Z","updatedAt":"2024-05-25T05:37:06.350Z","__v":0,"bvn":"22392366294","idNumber":"12344,g fjrj","idType":"Drivers License"},"message":"KYC fetched successfully"}
