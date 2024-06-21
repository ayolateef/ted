import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../core/Dashboard/select_country.dart';
import '../core/Dashboard/upload_files.dart';
import '../core/auth/auth_state.dart';
import '../core/constants/api_constant.dart';
import '../core/enums/view_state.dart';
import '../core/env/environment.dart';
import '../core/req_client.dart';
import '../core/utililies.dart';
import '../shared/models/kyc_model/bvn_model.dart';
import '../shared/models/kyc_model/nin_model.dart';

class KYCProvider extends ChangeNotifier {
  ReqClient requestClient = ReqClient();

   BuildContext? context;
  File document = File('path/to/document');



  AuthState authState = AuthState();

   String _errorMessage = "";
  String get errorMessage => _errorMessage;
  String? storedOtp;
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


  Future<Country?> getCountries(String country) async {
    Map<String, dynamic> body = {"country":country};

    try {
      setRequestOtpViewState(ViewState.busy);
      Response response = await requestClient.postWithAuthClient(
          '${Environment().config.BASE_URL}/${APIConstants.UPDATE_COUNTRIES }', body);
      log("error:${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        setRequestOtpViewState(ViewState.completed);
        return Country.fromJson(response.data['data']); // Return a single Country object
      }

      else {
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

  Future<Map<String, dynamic>?>  verifyBVN(String bvn) async {

    Map<String, dynamic> body = {"bvn": bvn};
    try {
      setKYCViewState(ViewState.busy);
      Response response = await requestClient.postWithAuthClient(
          '${Environment().config.BASE_URL}/${APIConstants.VERIFY_BVN }', body,
          );
      log("error:${response.data.toString()}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null && response.data['data'] != null) {
           //BVNModel.fromJson(response.data['data']);
           BVNModel bvnModel = BVNModel.fromJson(response.data['data']);
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

  Future<NINModel?> verifyNIN(String nin) async {
    Map<String, dynamic> body = {"nin": nin};

    try {
      setKYCViewState(ViewState.busy);
      Response response = await requestClient.postWithAuthClient(
        '${Environment().config.BASE_URL}/${APIConstants.VERIFY_NIN}',
        body,
        headers: {
          'Authorization': 'Bearer ${Environment().config.API_KEY}',
        },
      );
      log("Full Response Data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null && response.data['data'] != null) {
          return NINModel.fromJson(response.data['data']);
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


  Future<bool> updateBio(
      String firstName,
      String lastName,
      String gender,
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
      "country": country,
      "city": city,
      "state": state,
      "dob": dob,
      "address": address,
    };

    try {
      setKYCViewState(ViewState.busy);
      Response response = await requestClient.postWithAuthClient(
          '${Environment().config.BASE_URL}/${APIConstants.UPDATE_BIO }', body);
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



  Future<bool> updateAdditionalInfo(
      String sourceOfIncome,
      String employmentStatus,
      String occupation,
      String incomeBand
      ) async {
    Map<String, dynamic> body = {
      "sourceOfIncome": sourceOfIncome,
      "employmentStatus": employmentStatus,
      "occupation": occupation,
      "incomeBand": incomeBand,
    };

    try {
      setKYCViewState(ViewState.busy);
      Response response = await requestClient.postWithAuthClient(
          '${Environment().config.BASE_URL}/${APIConstants.ADDITIONAL_INFO }',
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
     // log('Added idNumber and idType to formData');

      for (var document in documents) {
        if (document != null && document.file != null && document.type != null) {
          formData.files.add(MapEntry(
            document.type!,
            await MultipartFile.fromFile(document.file!.path, filename: document.file!.path.split('/').last),
          ));
          log('Added document ${document.type} to formData');
        }
      }

      // log('FormData fields: ${formData.fields}');
      // log('FormData files: ${formData.files.map((e) => e.value.filename).toList()}');

      Response response = await requestClient.postWithAuthClient(
        '${Environment().config.BASE_URL}/${APIConstants.UPLOAD_DOC}', formData
      );

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
    // Map<String, dynamic> body = {
    //   "file": selfieFile.path,
    // };

    try {
      setKYCViewState(ViewState.busy);
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(selfieFile.path, filename: "selfie.jpg"),
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


}

