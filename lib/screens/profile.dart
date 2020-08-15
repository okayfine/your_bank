import 'package:flutter/material.dart';
import 'package:your_bank/utilities/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.deepOrange,
      body: ListView(
        children: <Widget>[
          Container(
            height: 200,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.5, 0.9],
                    colors: [PrimaryColor, SecondaryColor])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CircleAvatar(
                      minRadius: 60,
                      backgroundColor: ButtonColorPrimary,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(avatar),
                        minRadius: 50,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "John Doe",
                  style: GoogleFonts.raleway(
                      textStyle:
                          TextStyle(fontSize: 22.0, color: Colors.white)),
                ),
                Text(
                  "Dubai, UAE",
                  style: TextStyle(fontSize: 14.0, color: Colors.white60),
                )
              ],
            ),
          ),
          Container(
            // height: 50,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: ButtonColorPrimary,
                    child: ListTile(
                        title: Text(
                          "Show Branches",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: GoogleFonts.raleway().fontFamily,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        subtitle: Icon(Icons.location_on)),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              "Email",
              style: TextStyle(
                  color: SecondaryColor,
                  fontSize: 12.0,
                  fontFamily: GoogleFonts.raleway().fontFamily),
            ),
            subtitle: Text(
              "john@doe",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              "Phone",
              style: TextStyle(
                  color: SecondaryColor,
                  fontSize: 12.0,
                  fontFamily: GoogleFonts.raleway().fontFamily),
            ),
            subtitle: Text(
              "+971 500012244",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              "Twitter",
              style: TextStyle(
                  color: SecondaryColor,
                  fontSize: 12.0,
                  fontFamily: GoogleFonts.raleway().fontFamily),
            ),
            subtitle: Text(
              "@johndoey",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              "Facebook",
              style: TextStyle(
                  color: SecondaryColor,
                  fontSize: 12.0,
                  fontFamily: GoogleFonts.raleway().fontFamily),
            ),
            subtitle: Text(
              "facebook.com/johndoey",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
