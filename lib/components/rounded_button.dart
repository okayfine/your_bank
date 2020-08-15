import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color colorRB;
  final String titleRB;
  final Function onPressedRB;
  final String tagHero;
  final TextStyle styleButton;

  RoundedButton({
    this.colorRB,
    this.titleRB,
    this.onPressedRB,
    this.tagHero = ' ',
    this.styleButton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Hero(
        tag: tagHero,
        child: Material(
          elevation: 5.0,
          color: colorRB,
          borderRadius: BorderRadius.circular(30.0),
          child: MaterialButton(
            onPressed: onPressedRB,
            minWidth: 200.0,
            height: 42.0,
            child: Text(
              titleRB,
              style: styleButton,
            ),
          ),
        ),
      ),
    );
  }
}
