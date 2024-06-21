import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../shared/models/auth_models/user.dart';
import '../../shared/util/storage.dart';
import 'app_config.dart';

class AppStartUp{
  late AuthenticationProvider authenticationProvider;
  void loadStartUpConfig(BuildContext context) async {


    var userObject =
    await LocalStorageUtils.readObject<User>(AppConstants.userObject);
    log(userObject.toString());
    if (userObject != null) {
      User user = User.fromJson(userObject);
      authenticationProvider.user = user;

      //! Note: this has to be called after SignInCubit is registered
      authenticationProvider.login(user.email ?? '', user.name ?? '');
      //getIt.get<SignInCubit>().getProfile(isLogin: true);
    }
  }
}
