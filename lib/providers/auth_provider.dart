import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:tedfinance_mobile/core/constants/api_constant.dart';
import 'package:tedfinance_mobile/core/enums/view_state.dart';
import 'package:tedfinance_mobile/core/env/environment.dart';
import 'package:tedfinance_mobile/core/req_client.dart';
import 'package:tedfinance_mobile/core/utililies.dart';
import '../core/auth/auth_state.dart';
import '../shared/models/auth_models/user.dart';
import '../shared/util/share_preference_util.dart';

class AuthenticationProvider extends ChangeNotifier {
  ReqClient requestClient = ReqClient();

  AuthState authState = AuthState();

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  User? get user => user;

  ViewState _signupViewState = ViewState.idle;
  ViewState get signupViewState => _signupViewState;

  setSignupViewState(ViewState viewState) {
    _signupViewState = viewState;
    notifyListeners();
  }

  ViewState _requestOtpViewState = ViewState.idle;
  ViewState get requestOtpViewState => _requestOtpViewState;
  setRequestOtpViewState(ViewState viewState) {
    _requestOtpViewState = viewState;
    notifyListeners();
  }

  Future<bool> signup({required String email}) async {
    Map<String, dynamic> body = {
      "email": email,
    };

    print(body);
    try {
      setSignupViewState(ViewState.busy);
      Response response = await requestClient.postWithoutHeaderClient(
          '${Environment().config.BASE_URL}/${APIConstants.SIGNUP}', body);

      print("dsdkskd ${response.data}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        await SharedPreferenceUtils.storeEmail(email);
        setSignupViewState(ViewState.completed);

        return true;
      } else {
        _errorMessage = response.data["message"];

        setSignupViewState(ViewState.error);
        return false;
      }
    } on  DioException catch (e) {
      print("siurofuy#dsd,$e");
      final err = Utilities.dioErrorHandler(e);
      _errorMessage = err;
      setSignupViewState(ViewState.error);

      return false;
    }
  }

  Future<bool> verifyEmailSignup({
    required String name,
    required String email,
    required String password,
    required String code,
  }) async {
    Map<String, dynamic> body = {
      "name": name,
      "email": email,
      "password": password,
      "code": code,
    };

    try {
      setRequestOtpViewState(ViewState.busy);
      Response response = await requestClient.postWithoutHeaderClient(
          '${Environment().config.BASE_URL}/${APIConstants.VERIFY_SIGNUP }',
          body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        await SharedPreferenceUtils.storeToken(response.data['data']['token']);
        await SharedPreferenceUtils.storeEmail(email);
        await SharedPreferenceUtils.storePassword(password);
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



  Future<bool> resendOtp({required String email}) async {
    Map<String, dynamic> body = {
      "email": email,
    };
    try {
      setRequestOtpViewState(ViewState.busy);
      Response response = await requestClient.postWithoutHeaderClient(
          '${Environment().config.BASE_URL}/${APIConstants.RESEND_OTP}',
          body);

      if (response.statusCode == 200 || response.statusCode == 201) {
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

  Future<bool> verifyOTP({

    required String email,
    required String code,
  }) async {
    Map<String, dynamic> body = {
      "email": email,
      "code": code,
    };

    try {
      setRequestOtpViewState(ViewState.busy);
      log("Sending OTP verification request with body: $body");

      Response response = await requestClient.postWithoutHeaderClient(
          '${Environment().config.BASE_URL}/${APIConstants.VERIFY_OTP}',
          body);
      log("OTP verification response: ${response.data}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        await SharedPreferenceUtils.storeEmail(email);
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

  Future<bool> createPin(String pin) async {
    Map<String, dynamic> body = {
      "pin": pin,
    };
    try {
      setRequestOtpViewState(ViewState.busy);

      Response response = await requestClient.postWithAuthClient (

          '${Environment().config.BASE_URL}/${APIConstants.CREATE_PIN}', body,
          );

      if (response.statusCode == 200 || response.statusCode == 201) {
         await SharedPreferenceUtils.setPin(true);
        // await updateUserOnboardingStep(OnBoardingSteps.createPin);
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

  Future <bool> createUsername({required String username}) async {
    Map<String, dynamic> body = {
      "username": username
    };
    try {
      setRequestOtpViewState(ViewState.busy);
      Response response = await requestClient.postWithAuthClient(
          '${Environment().config.BASE_URL}/${APIConstants.CREATE_USERNAME}',body,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
       // await updateUserOnboardingStep(OnBoardingSteps.username);
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

  Future<bool> login(String email, String password) async {
    Map<String, dynamic> body = {
      "email": email,
      "password": password,
    };

    try {
      setRequestOtpViewState(ViewState.busy);

      Response response = await requestClient.postWithoutHeaderClient(
        '${Environment().config.BASE_URL}/${APIConstants.LOGIN}', body,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = response.data['data']['token'];
        await SharedPreferenceUtils.storeToken(token);
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

  Future<User?> fetchUser() async {
    try {
      setRequestOtpViewState(ViewState.busy);
      Response response = await requestClient.getWithAuthHeaderClient (
        '${Environment().config.BASE_URL}/${APIConstants.USER_DATA}',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        User user = User.fromJson(response.data['data']);
        setRequestOtpViewState(ViewState.completed);

        return user;

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

  Future<bool> forgotPassword({required String email}) async {
    Map<String, dynamic> body = {
      "email": email,
    };
    print(body);
    try {
      setRequestOtpViewState(ViewState.busy);
      Response response = await requestClient.postWithoutHeaderClient(
          '${Environment().config.BASE_URL}/${APIConstants.FORGOT_PASSWORD}', body);

      print("Forgot Password Response: ${response.data}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        setRequestOtpViewState(ViewState.completed);
        return true;
      } else {
        _errorMessage = response.data["message"];
        setRequestOtpViewState(ViewState.error);
        return false;
      }
    } on DioException catch (e) {
      print("Forgot Password Error: $e");
      final err = Utilities.dioErrorHandler(e);
      _errorMessage = err;
      setRequestOtpViewState(ViewState.error);
      return false;
    }
  }

  Future<bool> updatePassword(String email, String password) async {
    Map<String, dynamic> body = {
      "email": email,
      "password": password
    };
    print(body);
    try {
      setRequestOtpViewState(ViewState.busy);
      Response response = await requestClient.postWithoutHeaderClient(
          '${Environment().config.BASE_URL}/${APIConstants.FORGOT_PASSWORD}', body);

      print("Password Updated: ${response.data}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        setRequestOtpViewState(ViewState.completed);
        return true;
      } else {
        _errorMessage = response.data["message"];
        setRequestOtpViewState(ViewState.error);
        return false;
      }
    } on DioException catch (e) {
      print("Forgot Password Error: $e");
      final err = Utilities.dioErrorHandler(e);
      _errorMessage = err;
      setRequestOtpViewState(ViewState.error);
      return false;
    }
  }
  Future<void> updateUserOnboardingStep(OnBoardingSteps newStep) async {
    if (user != null) {
      user!.onboardingStep = newStep;
      if (newStep == OnBoardingSteps.dashboard) {
        user!.onboardingComplete = true;
      }
      notifyListeners();
    }
  }

}


//token and user