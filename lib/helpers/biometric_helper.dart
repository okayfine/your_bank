import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'dart:async';

final LocalAuthentication auth = LocalAuthentication();

Future<bool> checkBiometrics() async {
  bool canCheckBiometrics = false;
  try {
    canCheckBiometrics = await auth.canCheckBiometrics;
  } on PlatformException catch (e) {
    print(e);
  }
  return canCheckBiometrics;
}

// Future<BiometricType> getAvailableBiometrics() async {
//   List<BiometricType> availableBiometrics;
//   try {
//     availableBiometrics = await auth.getAvailableBiometrics();
//   } on PlatformException catch (e) {
//     // TODO: add an alert
//     print(e);
//   }
// }
