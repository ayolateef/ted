import 'package:local_auth/local_auth.dart';

class FingerprintAuthService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          useErrorDialogs: true,
          biometricOnly: true,
        ),
      );
    } catch (e) {
      print('Error using biometric authentication: $e');
    }
    return authenticated;
  }
}
