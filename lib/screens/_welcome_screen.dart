import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:io';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isBiometricEnabledFace = false;
  bool isBiometricEnabledTouch = false;
  bool _canCheckBiometrics = false;
  List<BiometricType> _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  final LocalAuthentication auth = LocalAuthentication();

  // Checks if the device has biometric hardware
  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  // Future<void> _authenticate() async {
  //   bool authenticated = false;
  //   try {
  //     setState(() {
  //       _isAuthenticating = true;
  //       _authorized = 'Authenticating';
  //     });
  //     authenticated = await auth.authenticateWithBiometrics(
  //         localizedReason: 'Scan your fingerprint to authenticate',
  //         useErrorDialogs: true,
  //         stickyAuth: true);
  //     setState(() {
  //       _isAuthenticating = false;
  //       _authorized = 'Authenticating';
  //     });
  //   } on PlatformException catch (e) {
  //     print(e);
  //   }
  //   if (!mounted) return;

  //   final String message = authenticated ? 'Authorized' : 'Not Authorized';
  //   setState(() {
  //     _authorized = message;
  //   });
  // }

  // void _cancelAuthentication() {
  //   auth.stopAuthentication();
  // }

  // get the available biometric devices
  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  @override
  void initState() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    if (canCheckBiometrics) {
      List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();
      if (Platform.isIOS) {
        if (availableBiometrics.contains(BiometricType.face)) {
          isBiometricEnabledFace = true;
        } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
          isBiometricEnabledTouch = true;
        }
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Can check biometrics: $_canCheckBiometrics\n'),
              RaisedButton(
                child: const Text('Check biometrics'),
                onPressed: _checkBiometrics,
              ),
              Text('Available biometrics: $_availableBiometrics\n'),
              RaisedButton(
                child: const Text('Get available biometrics'),
                onPressed: _getAvailableBiometrics,
              ),
              Text('Current State: $_authorized\n'),
              RaisedButton(
                  child: Text(_isAuthenticating ? 'Cancel' : 'Authenticate'),
                  onPressed: () {
                    CupertinoAlertDialog(
                      title: new Text("Biometric found"),
                      content: new Text(
                          "Would you like to use Biometric Login for passwordless access?"),
                      actions: [
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          child: new Text("Yes"),
                          onPressed: () {
                            // show up only if the login id and password is
                            // correct. Save data for autologin and try
                            // authenticating after showing up the biometric,
                            // if passed.
                          },
                        ),
                        CupertinoDialogAction(
                          isDestructiveAction: true,
                          child: new Text("No"),
                          onPressed: () {
                            // do not save and continue to login into dash-
                            // board.
                          },
                        )
                      ],
                    );
                  }
//                    _isAuthenticating ? _cancelAuthentication : _authenticate,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
