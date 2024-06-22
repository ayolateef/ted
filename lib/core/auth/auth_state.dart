
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tedfinance_mobile/core/auth/signup/sign_up.dart';

import '../../shared/models/auth_models/user.dart';
import '../../shared/navigations/routes/navigation_service.dart';
import '../../shared/util/storage.dart';
import '../env/app_config.dart';

class AuthState with ChangeNotifier{
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  Future<int?> getOnboardingProgress() async {

    final prefs = await SharedPreferences.getInstance();
    final prefValue = prefs.getInt(AppConstants.currentPage);
    if (prefValue != null) {
      return prefValue;
    }

    return null;
  }
  late User _user;

  String _token = '';

  String _userId = '';

  String get token => _token;

  String get userId => _userId;

  User get user => _user;
  set user(User value) {
    _user = value;
    notifyListeners();
  }

  void saveToken(String token) async {
    SharedPreferences value = await _pref;

    value.setString('token', token);
  }

  void saveUserId(String id) async {
    SharedPreferences value = await _pref;

    value.setString('id', id);
  }

  Future<String> getToken() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('token')) {
      String data = value.getString('token')!;
      _token = data;
      notifyListeners();
      return data;
    } else {
      _token = '';
      notifyListeners();
      return '';
    }
  }

  Future<String> getUserId() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('id')) {
      String data = value.getString('id')!;
      _userId = data;
      notifyListeners();
      return data;
    } else {
      _userId = '';
      notifyListeners();
      return '';
    }
  }

  // void loadStartUpConfig() async {
  //   var userObject =
  //   await LocalStorageUtils.readObject<User>(AppConstants.userObject);
  //   log(userObject.toString());
  //   if (userObject != null) {
  //     User user = User.fromJson(userObject);
  //     getIt.registerSingleton<User>(user);
  //
  //     //! Note: this has to be called after SignInCubit is registered
  //     getIt.get<SignInCubit>().getProfile(isLogin: true);
  //   }
  // }

  void logOut(BuildContext context) async {
    final value = await _pref;

    value.clear();

    PageNavigator(ctx: context).nextPageOnly(page: const SignUpScreen());
  }
}