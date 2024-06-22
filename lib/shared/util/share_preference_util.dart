import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtils {
  static const _storage = FlutterSecureStorage();
  static const String _pinKey = 'userPin';
  static Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<void> viewedIntro() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('hasViewedIntroScreens', true);
  }
  static Future<void> setLastLoginTime() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('lastLoginTime', DateTime.now().toString());
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

  // static Future<void> setPin(bool pinset) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('isPinSet', pinset);
  // }
  // static Future<String?> getPin() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(_pinKey);
  // }
  static Future<String?> getPin() async {
    return await _storage.read(key: 'pin');
  }
  static Future<void> setPin(String pin) async {
    await _storage.write(key: 'pin', value: pin);
  }
  // static Future<void> setPin(String pin) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString(_pinKey, pin);
  // }
  static Future<void> setDefaultPin(bool pinSet) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isPinDefault', pinSet);
  }

  static Future<void> deletePin() async {
    await _storage.delete(key: 'pin');
  }

  // static Future<bool> getPin() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final bool? isSet = prefs.getBool('isPinSet');
  //   return isSet ?? false;
  // }

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
  static Future<void> storeName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
  }
  static Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name') ?? '';
  }

  static Future<void> storePassword(String password) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('password', password);
  }

  static Future<String> getPassword() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('password') ?? '';

  }

  static Future<void> storePhoneNum(String phoneNum) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('phoneNum', phoneNum);
  }

  static Future<String> getPhoneNum() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('phoneNum') ?? '';
  }
}
