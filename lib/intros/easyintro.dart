import 'package:first_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:first_app/widgets/background.dart';

class Easyintro extends StatefulWidget {
  const Easyintro({Key? key}) : super(key: key);

  @override
  _EasyintroState createState() => _EasyintroState();
}

class _EasyintroState extends State<Easyintro> {
  String move = " Skip Intro";
  String instru = " Choose one of the two options given below";
  @override
  Widget build(BuildContext context) {
    var mediaorin = MediaQuery.of(context).orientation;
    if (mediaorin == Orientation.portrait) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          title: Row(
            children: [
              Text("Colour Game",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w500)),
              Spacer(),
              Text("Intro",
                  style: TextStyle(
                      fontFamily: GoogleFonts.nunito().fontFamily,
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        body: Stack(
          children: [
            MyBackground(),
            Container(
              child: Column(
                children: [
                  Container(
                      height: 130,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "choose the option where first word represents the colour of the text and the second word represents the Colour itself ",
                          // intro,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 21,
                            fontFamily: GoogleFonts.nunito().fontFamily,
                          ),
                        ),
                      )),
                  // SizedBox(
                  //   height: 58,
                  // ),
                  Spacer(
                    flex: 1,
                  ),
                  Container(
                    width: 206,
                    child: Center(
                      child: Text("Blue",
                          style: TextStyle(
                              color: Colors.pink.shade300,
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              fontSize: 35,
                              fontWeight: FontWeight.bold)),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.pink.shade200, width: 4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  // SizedBox(
                  //   height: 50,
                  // ),
                  Spacer(
                    flex: 1,
                  ),
                  Container(
                    width: 280,
                    child: Text(
                      instru,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  // SizedBox(
                  //   height: 50,
                  // ),
                  Spacer(
                    flex: 1,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        instru =
                            "Good Job!! Now answer as many questions as you can in 60 seconds ";
                        move = "  Start";
                      });
                    },
                    child: Container(
                      height: 62,
                      width: 260,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black, width: 4)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text("Pink Blue",
                              style: TextStyle(
                                  fontFamily: GoogleFonts.nunito().fontFamily,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                  //
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        instru =
                            "oh..Close!!  Try Again The first word should be the text colour";
                        move = "  Start";
                      });
                    },
                    child: Container(
                      height: 62,
                      width: 260,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black, width: 4)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text("Blue Pink",
                              style: TextStyle(
                                  fontFamily: GoogleFonts.nunito().fontFamily,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  InkWell(
                    onTap: () => Navigator.pushReplacementNamed(
                        context, MyRoutes.easygameroute),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 61, 138, 255),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.6,
                                offset: Offset(4, 2))
                          ]),
                      height: 48,
                      width: 173,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              move,
                              textAlign: TextAlign.right,
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 3,
                  )
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
          body: Center(
        child: Container(
          child: Text(
            "Please hold the device in portrait mode",
            style: TextStyle(fontSize: 30),
          ),
        ),
      ));
    }
  }
}
