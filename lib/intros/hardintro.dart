import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:first_app/utils/routes.dart';
import 'package:first_app/widgets/background.dart';

class Hardintro extends StatefulWidget {
  const Hardintro({Key? key}) : super(key: key);

  @override
  _HardintroState createState() => _HardintroState();
}

class _HardintroState extends State<Hardintro> {
  String instru = "Choose one of the four options given below";
  String move = "  Skip Intro";
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
                          "Interchange the colour of the text and what the text reads.For example if Orange in written in green then choose a option with green written in orange",
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
                  Spacer(
                    flex: 1,
                  ),
                  Row(
                    children: [
                      Spacer(
                        flex: 2,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            instru =
                                "Oh..try Again..check the text colour again";
                            move = "  Start";
                          });
                        },
                        child: Container(
                          height: 62,
                          width: 160,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: Colors.black, width: 4)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text("Pink",
                                  style: TextStyle(
                                      color: Colors.pink.shade300,
                                      fontFamily:
                                          GoogleFonts.nunito().fontFamily,
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
                        onTap: () {
                          setState(() {
                            instru =
                                "Good job!! ..Now answer as many questions as you can under 60 seconds";
                            move = "  Start";
                          });
                        },
                        child: Container(
                          height: 62,
                          width: 160,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: Colors.black, width: 4)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text("Pink",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontFamily:
                                          GoogleFonts.nunito().fontFamily,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ),
                      Spacer(flex: 2),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Spacer(
                        flex: 2,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            move = "  Start";
                            instru =
                                "Oh..Try Again..Not the same option as given in the question";
                          });
                        },
                        child: Container(
                          height: 62,
                          width: 160,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: Colors.black, width: 4)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text("Blue",
                                  style: TextStyle(
                                      color: Colors.pink.shade300,
                                      fontFamily:
                                          GoogleFonts.nunito().fontFamily,
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
                        onTap: () {
                          setState(() {
                            move = "  Start";
                            instru =
                                "Oh..Try Again..Check the text written again";
                          });
                        },
                        child: Container(
                          height: 62,
                          width: 160,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: Colors.black, width: 4)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text("Blue",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontFamily:
                                          GoogleFonts.nunito().fontFamily,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  InkWell(
                    onTap: () => Navigator.pushReplacementNamed(
                        context, MyRoutes.hardgameroute),
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
                  ),
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
