import 'package:first_app/utils/routes.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration:
                BoxDecoration(boxShadow: [BoxShadow(color: Colors.white)]),
            curve: Curves.easeInBack,
            duration: Duration(milliseconds: 20),
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.all(0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(46),
                      bottomRight: Radius.circular(46)),
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(241, 105, 105, 1),
                    Color.fromRGBO(240, 82, 150, 1),
                    Color.fromRGBO(239, 62, 189, 1),
                    Color.fromRGBO(237, 30, 255, 1),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(90, 90, 0, 0),
                child: Text(
                  "Colour Game",
                  // textAlign: TextAlign.end,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontFamily: GoogleFonts.caveat().fontFamily),
                ),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
            },
            leading: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            ),
            title: Text(
              "Close drawer",
              style: TextStyle(
                  fontSize: 22, fontFamily: GoogleFonts.nunito().fontFamily),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, MyRoutes.graph);
            },
            leading: Icon(
              Icons.trending_up_rounded,
              color: Colors.black,
              size: 30,
            ),
            title: Text(
              "Check Your Progress",
              style: TextStyle(
                  fontSize: 22, fontFamily: GoogleFonts.nunito().fontFamily),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, MyRoutes.daily);
            },
            leading: Icon(
              Icons.bar_chart,
              color: Colors.black,
              size: 30,
            ),
            title: Text(
              "Daily Challenge",
              style: TextStyle(
                  fontSize: 22, fontFamily: GoogleFonts.nunito().fontFamily),
            ),
          )
        ],
      ),
    );
  }
}
