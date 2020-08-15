import 'package:flutter/material.dart';
import 'package:your_bank/screens/dashboard.dart';
// import 'package:your_bank/screens/login_screen_v2.dart';
import 'package:your_bank/screens/login_screen_v3.dart';
// import 'package:your_bank/screens/dashboard.dart';
import 'package:your_bank/utilities/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your Bank Demo',
      theme: ThemeData(
        primaryColor: PrimaryColor,
        accentColor: SecondaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
      initialRoute: LoginScreen.screenIdV3,
      routes: {
        LoginScreen.screenIdV3: (context) => LoginScreen(),
        Dashboard.screenId: (context) => Dashboard(),
      },
    );
  }
}
