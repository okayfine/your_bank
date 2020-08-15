import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:your_bank/screens/dashboard.dart';
import 'package:your_bank/utilities/constants.dart';
import 'package:your_bank/helpers/biometric_helper.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:your_bank/utilities/enc_dec.dart';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  static const String screenIdV3 = 'login_screen_v3';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  String email, password;
  String decryptMsg;
  bool _rememberMe = false;

  @override
  void dispose() {
    // Disposed controllers
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  void getBothText() {
    emailTextController.addListener(() {
      email = emailTextController.text;
      // print(email);
    });
    passwordTextController.addListener(() {
      password = passwordTextController.text;
    });
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: emailTextController,
            keyboardType: TextInputType.emailAddress,
            style:
                GoogleFonts.raleway(textStyle: TextStyle(color: Colors.white)),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: passwordTextController,
            obscureText: true,
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          // print("Email:" + emailTextController.text);
          loginEncryption(
              emailTextController.text, passwordTextController.text);
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.raleway().fontFamily,
          ),
        ),
      ),
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontFamily: GoogleFonts.raleway().fontFamily),
        ),
        SizedBox(height: 20.0),
        Text(
          'Sign in with',
          style: kLabelStyle,
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Icon(Icons.fingerprint),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(() async {
            bool test = await checkBiometrics();
            bool _;
            if (test) {
              List<BiometricType> _ =
                  await auth.getAvailableBiometrics();
              if (Platform.isIOS) {
                // Don't need two but to show that we have access
                // to both
                bool userAuthenticated = await auth.authenticateWithBiometrics(
                    localizedReason: 'Please authenticate to Login');
                if (userAuthenticated) {
                  Navigator.pushNamed(context, Dashboard.screenId);
                }
                // if (availableBiometrics.contains(BiometricType.face)) {
                //   if (_ = await auth.authenticateWithBiometrics(
                //       localizedReason: 'Please authenticate to Login')) {
                //     print("Its done");
                //     Navigator.pushNamed(context, Dashboard.screenId);
                //   }
                // } else if (availableBiometrics
                //     .contains(BiometricType.fingerprint)) {
                //   if (_ = await auth.authenticateWithBiometrics(
                //       localizedReason: 'Please authenticate to Login')) {
                //     print("Its done");
                //     Navigator.pushNamed(context, Dashboard.screenId);
                //   }
                // } else {

                // }
              }
            } else {
              return showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
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
                  });
            }
          }),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => print('Sign Up Button Pressed'),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: GoogleFonts.raleway().fontFamily),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.raleway().fontFamily),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: GoogleFonts.raleway().fontFamily,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 30.0),
                              _buildEmailTF(),
                              SizedBox(
                                height: 30.0,
                              ),
                              _buildPasswordTF(),
                              _buildForgotPasswordBtn(),
                              _buildRememberMeCheckbox(),
                              _buildLoginBtn(),
                              _buildSignInWithText(),
                              _buildSocialBtnRow(),
                              _buildSignupBtn(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void loginEncryption(String emails, String passwords) async {
    print(emails + "and" + passwords);
    http.Response response =
        await http.post('http://localhost:8080/index.php', body: {
      'email': '${encrypTer(emails)}',
      'password': '${encrypTer(passwords)}',
    });
    print(response.body);
    var result = jsonDecode(response.body);
    setState(() {
      decryptMsg = decrypTer(result['key']);
      // print("1: ${decryptMsg}");
    });
    // print("2: ${decryptMsg}");
    if (decryptMsg == 'lionel') {
      print("shoudl show box");
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text("Received Message Decrypted"),
            content: Text("The message is $decryptMsg"),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('Okay'),
                onPressed: () {
                  // Navigator.of(context).pop();
                  Navigator.pushNamed(context, Dashboard.screenId);
                },
              ),
            ],
          );
        },
      );
    }
  }
}
