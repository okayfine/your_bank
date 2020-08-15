import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:your_bank/components/rounded_button.dart';
import 'package:your_bank/utilities/constants.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';
import 'package:your_bank/helpers/size_helpers.dart';
import 'package:your_bank/components/textfield_card.dart';
import 'package:your_bank/helpers/biometric_helper.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:your_bank/utilities/enc_dec.dart';
import 'dart:convert';

import 'dashboard.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  String email, password;
  String decryptMsg;

  @override
  void initState() {
    emailTextController.addListener(() {
      email = emailTextController.text;
    });
    passwordTextController.addListener(() {
      password = passwordTextController.text;
    });

    super.initState();
  }

  @override
  void dispose() {
    // Disposed controllers
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pxHeight = displayHeight(context);
    final pxWidth = displayWidth(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Animated background
          Container(
            height: 500,
            child: RotatedBox(
              quarterTurns: 2,
              child: WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [PrimaryColor, Colors.white70],
                    [Colors.indigo.shade200, Colors.lightBlueAccent],
                  ],
                  durations: [19440, 10800],
                  heightPercentages: [0.20, 0.25],
                  blur: MaskFilter.blur(BlurStyle.solid, 10),
                  gradientBegin: Alignment.bottomLeft,
                  gradientEnd: Alignment.topRight,
                ),
                waveAmplitude: 0,
                size: Size(
                  double.infinity,
                  double.infinity,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 80, 20, 60),
            child: Container(
              height: pxHeight,
              width: pxWidth,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(244, 244, 244, 210),
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(40.0),
                    topRight: const Radius.circular(40.0),
                  )),
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    child: Icon(
                      Icons.attach_money,
                      size: 100,
                      color: PrimaryColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Your ",
                        style: GoogleFonts.pacifico(
                          fontSize: 32.0,
                        ),
                      ),
                      RotateAnimatedTextKit(
                        text: ["Bank", "Home", "Family"],
                        repeatForever: true,
                        textStyle: GoogleFonts.pacifico(
                            textStyle: TextStyle(fontSize: 32.0)),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      TextFieldCard(
                        controller: emailTextController,
                        hideText: false,
                        hintText: 'Email',
                        iconInput: Icons.person,
                      ),
                      TextFieldCard(
                        controller: passwordTextController,
                        hideText: true,
                        iconInput: Icons.lock,
                        hintText: 'Password',
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RoundedButton(
                        colorRB: SecondaryColor,
                        titleRB: "Login",
                        onPressedRB: () {
                          loginEncryption(email, password);
                        },
                        tagHero: ' ',
                        styleButton: GoogleFonts.raleway(
                            color: Colors.white, fontSize: 18.0),
                      ),
                      IconButton(
                        icon: Icon(Icons.fingerprint),
                        onPressed: () async {
                          bool test = await checkBiometrics();
                          bool _;
                          if (test) {
                            List<BiometricType> availableBiometrics =
                                await auth.getAvailableBiometrics();
                            if (Platform.isIOS) {
                              // Don't need two but to show that we have access
                              // to both
                              if (availableBiometrics
                                  .contains(BiometricType.face)) {
                                if (_ = await auth.authenticateWithBiometrics(
                                    localizedReason:
                                        'Please authenticate to Login')) {
                                  print("Its done");

                                  Navigator.pushNamed(
                                      context, Dashboard.screenId);
                                }
                              } else if (availableBiometrics
                                  .contains(BiometricType.fingerprint)) {
                                if (_ = await auth.authenticateWithBiometrics(
                                    localizedReason:
                                        'Please authenticate to Login')) {
                                  print("Its done");
                                  Navigator.pushNamed(
                                      context, Dashboard.screenId);
                                }
                              }
                            }
                          } else {
                            new CupertinoAlertDialog(
                              title: new Text("Biometric Missing"),
                              content: new Text(
                                  "Your device does not have any biometric options"),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  isDefaultAction: true,
                                  child: Text("Okay"),
                                ),
                              ],
                            );
                          }
                        },
                        iconSize: 50,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void loginEncryption(String email, String password) async {
    print(email + "and" + password);
    http.Response response =
        await http.post('http://localhost:8080/index.php', body: {
      'email': '${encrypTer(email)}',
      'password': '${encrypTer(password)}',
    });
    print(response.body);
    var result = jsonDecode(response.body);
    setState(() {
      decryptMsg = decrypTer(result['key']);
      print(decryptMsg);
      if (decryptMsg == 'lionel') {
        Navigator.pushNamed(context, Dashboard.screenId);
      }
    });
  }
}

// Future<void> _handleClickMe(String title, String content) async {
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return CupertinoAlertDialog(
//         title: Text(title),
//         content: Text(content),
//         actions: <Widget>[
//           CupertinoDialogAction(
//             child: Text('Don\'t Allow'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           CupertinoDialogAction(
//             child: Text('Allow'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
