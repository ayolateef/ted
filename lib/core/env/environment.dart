import 'package:tedfinance_mobile/core/env/prod_config.dart';
import 'package:tedfinance_mobile/core/env/staging_config.dart';

import 'base_config.dart';
import 'dev_config.dart';

class Environment {
  factory Environment() {
    return _singleton;
  }

  Environment._internal();

  static final Environment _singleton = Environment._internal();

  static const String DEV = 'DEV';
  static const String STAGING = 'STAGING';
  static const String PROD = 'PROD';
  static const String isUserFirstTime = "isUserFirstTime";
  late BaseConfig config;
   static String env = "";

  initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    switch (environment) {
      case Environment.PROD:
        env=Environment.PROD;
        return ProdConfig();
      case Environment.STAGING:
        env=Environment.STAGING;
        
        return StagingConfig();
      default:
        env=Environment.DEV;

        return DevConfig();
    }
  }
  
  static String getEnv(){
    return env;
  }
}
