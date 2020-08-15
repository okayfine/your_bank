import 'package:flutter/material.dart';

class TextFieldCard extends StatelessWidget {
  final TextEditingController controller;
  final IconData iconInput;
  final bool hideText;
  final String hintText;

  TextFieldCard(
      {this.controller, this.iconInput, this.hideText, this.hintText});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 30, right: 30, top: 30),
      elevation: 11,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40))),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.visiblePassword,
        obscureText: hideText,
        decoration: InputDecoration(
            prefixIcon: Icon(
              iconInput,
              color: Colors.black26,
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.black26),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0)),
      ),
    );
  }
}
