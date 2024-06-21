import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtils {
  static Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<void> viewedIntro() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('hasViewedIntroScreens', true);
  }

  static Future<void> setWalletPin(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('walletTransactionPinIsActive', value);
  }

  static Future<void> storeUserId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('userId', id);
  }

  static Future<void> storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  static Future<void> storeEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
  }

  static Future<void> storeUserProfile(String user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userprofile', user);
  }

  static Future<void> setPin(bool pinset) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isPinSet', pinset);
  }

  static Future<void> setDefaultPin(bool pinSet) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isPinDefault', pinSet);
  }

  static Future<bool> getPin() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? isSet = prefs.getBool('isPinSet');
    return isSet ?? false;
  }

  static Future<bool> getDefaultPin() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? isSet = prefs.getBool('isPinDefault');
    return isSet ?? true;
  }

  static Future<int> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final int? id = prefs.getInt('userId');
    return id!;
  }

  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    return token ?? '';
  }
  static Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('email');
    return email ?? '';
  }

  static Future<void> storePassword(String password) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('password', password);
  }

  static Future<String> getPassword() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('password') ?? '';

  }
}
