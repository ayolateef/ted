import 'package:provider/provider.dart';
import 'package:tedfinance_mobile/providers/kyc_provider.dart';

import '../core/auth/auth_state.dart';
import '../shared/models/auth_models/user.dart';
import 'auth_provider.dart';

final allProviders = [
  ChangeNotifierProvider<AuthenticationProvider>(create: (_) => AuthenticationProvider()),
  ChangeNotifierProvider<KYCProvider>(create: (_) =>KYCProvider()),
];
//AuthState()