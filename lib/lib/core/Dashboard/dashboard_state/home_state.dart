
import 'package:flutter/cupertino.dart';

import '../../../shared/models/dashboard_models/wallet_model.dart';

class HomeState with ChangeNotifier {
  bool _isLoading = false;
  WalletModel? _walletInfo;


  Future<void> getWalletInfo() async {
    _isLoading = true;
    notifyListeners();

    try {
      _walletInfo = WalletModel(/* data */);
    } catch (e) {
      // Handle errors
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


bool get isLoading => _isLoading;
  WalletModel? get walletInfo => _walletInfo;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setWalletInfo(WalletModel walletInfo) {
    _walletInfo = walletInfo;
    notifyListeners();
  }
}