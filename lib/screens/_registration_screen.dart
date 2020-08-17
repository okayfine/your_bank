// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';
// import 'package:your_bank/utilities/constants.dart';
// import 'package:your_bank/components/rounded_button.dart';
// import 'package:http/http.dart' as http;
// import 'package:your_bank/utilities/enc_dec.dart';

// class RegistrationScreen extends StatefulWidget {
//   static const String registerScreenId = 'registration';

//   @override
//   _RegistrationScreenState createState() => _RegistrationScreenState();
// }

// class _RegistrationScreenState extends State<RegistrationScreen> {
//   bool showSpinner = false;
//   String email, password;
//   String decryptMsg ;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: ModalProgressHUD(
//         inAsyncCall: showSpinner,
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               TextField(
//                   keyboardType: TextInputType.emailAddress,
//                   textAlign: TextAlign.center,
//                   onChanged: (value) {
//                     email = value;
//                     //Do something with the user input.
//                   },
//                   style: TextStyle(color: Colors.black),
//                   decoration: kTextFieldDecoration.copyWith(
//                       hintText: 'Enter your email')),
//               SizedBox(
//                 height: 8.0,
//               ),
//               TextField(
//                   textAlign: TextAlign.center,
//                   obscureText: true,
//                   onChanged: (value) {
//                     password = value;
//                     //Do something with the user input.
//                   },
//                   style: TextStyle(color: Colors.black),
//                   decoration: kTextFieldDecoration.copyWith(
//                       hintText: 'Enter the password')),
//               SizedBox(
//                 height: 24.0,
//               ),
//               RoundedButton(
//                 titleRB: 'Register',
//                 colorRB: Colors.blueAccent,
//                 tagHero: 'registration_button',
//                 onPressedRB: () {
//                   print("Email:$email");
//                   print("Password:$password");
//                   login(email, password);
//                                     // setState(() {
//                                     //   showSpinner = true;
//                                     // });
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     }
//                     void login(String email, String password) async {
//                       http.Response response = await http.post('http://localhost:8080/index.php', body:{
//                         'email': '${encrypTer(email)}','password':'${encrypTer(password)}',
//                       });

//                       print(response.body);
//                       var result = jsonDecode(response.body);
//                       setState(() {
//                         decryptMsg = decrypTer(result['key']);
//                         if(decryptMsg == 'lionel'){

//                         }

//                       });
//                     }

// }

//                   //                  try {
//                   ////                    final newUser = await _auth.createUserWithEmailAndPassword(
//                   ////                        email: email.trim(), password: password);
//                   ////                    if (newUser != null) {
//                   ////                      setState(() {
//                   ////                        showSpinner = false;
//                   ////                      });
//                   ////                      Navigator.of(context)
//                   ////                          .pushReplacementNamed(ChatScreen.chatScreenId);
//                   ////                      Navigator.popAndPushNamed(
//                   ////                          context, ChatScreen.chatScreenId);
//                   //                    }
//                   //                  } catch (e) {
//                   //                    setState(() {
//                   //                      showSpinner = false;
//                   //                    });
//                   //                    print(e);
//                   //                  }
