import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:tedfinance_mobile/providers/kyc_provider.dart';

import '../shared/models/auth_models/user.dart';
import 'auth_provider.dart';
import 'dashboard_provider.dart';


// List <SingleChildWidget> all(){
//    return
//    [
//
//      ChangeNotifierProvider<AuthenticationProvider>(create: (_) => AuthenticationProvider()),
//      ChangeNotifierProvider<KYCProvider>(create: (_) =>KYCProvider()),
//      ChangeNotifierProvider<DashboardProvider>(create: (_) =>DashboardProvider()),
//    ];
//
//  }
final allProviders = [
  ChangeNotifierProvider<AuthenticationProvider>(create: (_) => AuthenticationProvider()),
  ChangeNotifierProvider<KYCProvider>(create: (_) =>KYCProvider()),
  ChangeNotifierProvider<DashboardProvider>(create: (_) =>DashboardProvider()),
];
//AuthState()