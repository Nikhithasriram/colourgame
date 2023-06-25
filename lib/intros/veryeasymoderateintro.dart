import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:first_app/widgets/background.dart';

class VeryEasyModerateintro extends StatefulWidget {
  const VeryEasyModerateintro({Key? key}) : super(key: key);

  @override
  _VeryEasyModerateintroState createState() => _VeryEasyModerateintroState();
}

class _VeryEasyModerateintroState extends State<VeryEasyModerateintro> {
  String instru = "Choose one the two options given below";
  String move = "  Skip Intro";
  @override
  Widget build(BuildContext context) {
    final result = ModalRoute.of(context)!.settings.arguments as Map;
    final intro = result['intro'];
    final correct = result['correct'];
    final wrong = result['wrong'];
    final next = result['next'];
    var mediaorien = MediaQuery.of(context).orientation;
    if (mediaorien == Orientation.portrait) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          title: Row(
            children: [
              Text(
                "Colour Game",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Container(
                child: Text(
                  "Intro",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: GoogleFonts.nunito().fontFamily),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            MyBackground(),
            Container(
              child: Center(
                child: Column(
                  children: [
                    // Spacer(),

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
                            // "Choose the option with the same text as given in the question neglecting the question colour ",
                            intro,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: GoogleFonts.nunito().fontFamily,
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    // this is the qn part

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
                          border:
                              Border.all(color: Colors.pink.shade200, width: 4),
                          borderRadius: BorderRadius.circular(20)),
                    ),

                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Container(
                          width: 280,
                          alignment: Alignment.center,
                          child: Text(
                            instru,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: 60,
                    ),

                    Stack(
                      children: [
                        Row(
                          children: [
                            Spacer(
                              flex: 5,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  instru =
                                      // "Good job!! Now answer as many questions you can in 60 seconds";
                                      correct;
                                  move = "  Start";
                                });
                              },
                              child: Container(
                                height: 62,
                                width: 140,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text("Blue",
                                        style: TextStyle(
                                            fontFamily:
                                                GoogleFonts.nunito().fontFamily,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    // color: Colors.greenAccent.shade400,
                                    border: Border.all(
                                        color: Colors.black, width: 4),
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                            Spacer(
                              flex: 2,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  instru =
                                      // "oh...try again neglect the colour of the text";
                                      wrong;
                                  move = "  Start";
                                });
                              },
                              child: Container(
                                height: 62,
                                width: 140,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text("Pink",
                                        style: TextStyle(
                                            fontFamily:
                                                GoogleFonts.nunito().fontFamily,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 4),
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                            Spacer(
                              flex: 5,
                            ),
                          ],
                        ),
                      ],
                    ),

                    Spacer(
                      flex: 1,
                    ),
                    InkWell(
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, next),
                      child: Container(
                        // alignment: Alignment.center,
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
                    Spacer(
                      flex: 2,
                    ),
                  ],
                ),
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
