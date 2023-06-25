import 'package:first_app/utils/routes.dart';
import 'package:first_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dough/dough.dart';
import 'package:hive/hive.dart';
import 'package:first_app/widgets/loadingscreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    Hive.box('daily').close();
    Hive.box('date').close();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Hive.openBox('daily'),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return FutureBuilder(
                future: Hive.openBox('date'),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done)
                    return FutureBuilder(
                        future: Hive.openBox('scores'),
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return AfterHomePage();
                          } else
                            return Loadingscreen();
                        });
                  else
                    return Loadingscreen();
                });
          } else {
            return Loadingscreen();
          }
        });
  }
}

class AfterHomePage extends StatefulWidget {
  @override
  State<AfterHomePage> createState() => _AfterHomePageState();
}

class _AfterHomePageState extends State<AfterHomePage> {
  final int days = 30;

  final Color orange1 = const Color.fromRGBO(244, 92, 92, 0.79);
  final Color yellow1 = const Color.fromRGBO(250, 219, 58, 0.82);
  final Color green1 = const Color.fromRGBO(138, 238, 136, 0.79);
  final Color yellow2 = const Color.fromRGBO(250, 196, 58, 0.82);
  final Color green2 = const Color.fromRGBO(43, 111, 19, 0.49);
  final Color blue2 = const Color.fromRGBO(58, 238, 250, 0.78);
  final Color purple = const Color.fromRGBO(85, 56, 205, 0.79);
  final Color pink = const Color.fromRGBO(250, 58, 231, 0.24);
  final Color circleyellow = const Color.fromRGBO(240, 209, 130, 0.80);
  final Color circlepurple = const Color.fromRGBO(118, 149, 228, 0.56);
  final Color circlegreen = const Color.fromRGBO(176, 219, 120, 0.74);
  final Color circleblue = const Color.fromRGBO(154, 212, 254, 1);

  var points;

  void refreshdaily() {
    DateTime date =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    var datebox = Hive.box('date');
    datebox.add(date);
    int length = datebox.length;
    if (datebox.length >= 2) {
      if (datebox.getAt(length - 1) != datebox.getAt(length - 2)) {
        Hive.box('daily').clear();
      }
    }

    var scores = Hive.box('scores');

    if (scores.isNotEmpty)
      points = scores.getAt(0);
    else
      points = 0;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    refreshdaily();

    var mediaorin = MediaQuery.of(context).orientation;
    if (mediaorin == Orientation.portrait) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Row(
            children: [
              Spacer(),
              Text(
                "My first App",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
              Spacer(
                flex: 10,
              ),
              Text(
                "Coins $points",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    fontFamily: GoogleFonts.nunito().fontFamily),
              ),
              Spacer()
            ],
          ),
        ),
        body: Stack(children: [
          Container(
            child: ClipOval(
              clipper: CircleClipper(),
              child: Container(
                height: 700,
                width: 700,
                decoration: BoxDecoration(
                  color: circleyellow,
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: 170,
            child: Container(
              child: ClipOval(
                child: Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    color: circlepurple,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 260,
            right: 250,
            child: Container(
              child: ClipOval(
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: circlegreen,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              child: ClipOval(
                clipper: CircleClipperblue(),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    color: circleblue,
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.transparent),
            //image: DecorationImage(
            //image: AssetImage("assets/images/background.png"))),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, MyRoutes.veryeasymoderateintro,
                            arguments: {
                              'intro':
                                  "Choose the colour of the text        Answer as many questions you can in 60 seconds",
                              'wrong':
                                  "Good job!! Now answer as many questions you can in 60 seconds",
                              'correct':
                                  "oh...try again! neglect what the text reads",
                              'next': MyRoutes.veryEasygameroute,
                            });
                      },
                      child: PressableDough(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [orange1, yellow1]),
                            borderRadius: BorderRadius.circular(20),
                            // boxShadow: [
                            //   BoxShadow(color: Colors.grey, blurRadius: 8)
                            // ]
                          ),
                          //padding: EdgeInsets.all(10),
                          height: 100,
                          width: 280,
                          //onPressed: () {},
                          child: Center(
                            child: Text(
                              "Very Easy",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: GoogleFonts.nunito().fontFamily,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, MyRoutes.easyintro);
                      },
                      child: PressableDough(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [green1, yellow2]),
                            borderRadius: BorderRadius.circular(20),
                            // boxShadow: [
                            //   BoxShadow(color: Colors.grey, blurRadius: 8)
                            // ]
                          ),
                          //padding: EdgeInsets.all(10),
                          height: 100,
                          width: 280,
                          //onPressed: () {},
                          child: Center(
                            child: Text(
                              "Easy",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily:
                                      GoogleFonts.nunitoSans().fontFamily,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, MyRoutes.veryeasymoderateintro,
                            arguments: {
                              'intro':
                                  "Choose the option with the same text as given in the question neglecting the question colour ",
                              'correct':
                                  "Good job!! Now answer as many questions you can in 60 seconds",
                              'wrong':
                                  "oh...try again neglect the colour of the text",
                              'next': MyRoutes.moderateroute,
                            });
                      },
                      child: PressableDough(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [green2, blue2]),
                            borderRadius: BorderRadius.circular(20),
                            // boxShadow: [
                            //   BoxShadow(color: Colors.grey, blurRadius: 8)
                            // ]
                          ),
                          //padding: EdgeInsets.all(10),
                          height: 100,
                          width: 280,
                          //onPressed: () {},
                          child: Center(
                            child: Text(
                              "Moderate",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily:
                                      GoogleFonts.nunitoSans().fontFamily,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, MyRoutes.hardintro);
                      },
                      child: PressableDough(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [purple, pink]),
                            borderRadius: BorderRadius.circular(20),
                            //boxShadow: [
                            //BoxShadow(color: Colors.grey, blurRadius: 8)
                            //]
                          ),
                          //padding: EdgeInsets.all(10),
                          height: 100,
                          width: 280,
                          //onPressed: () {},
                          child: Center(
                            child: Text(
                              "Hard",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily:
                                      GoogleFonts.nunitoSans().fontFamily,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
        drawer: MyDrawer(),
      );
    } else {
      return Scaffold(
        body: Container(
          child: Center(
            child: Text(
              "Please hold the device in portrait mode",
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
      );
    }
  }
}

class CircleClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromCenter(center: Offset(40, 100), width: 220, height: 220);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}

class CircleClipperblue extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromCenter(
        center: Offset(260.0, 230.0), width: 200, height: 200);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}

class MyBackground {
  Widget build(BuildContext context) {
    return Container();
  }
}
