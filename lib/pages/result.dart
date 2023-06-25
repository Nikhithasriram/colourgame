import 'package:flutter/material.dart';
import 'package:first_app/widgets/drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:first_app/utils/routes.dart';
import 'package:hive/hive.dart';
import 'graphvalue.dart';
import 'package:first_app/widgets/loadingscreen.dart';

class Firstresult extends StatefulWidget {
  const Firstresult({Key? key}) : super(key: key);

  @override
  _FirstresultState createState() => _FirstresultState();
}

class _FirstresultState extends State<Firstresult> {
  @override
  void dispose() {
    Hive.box('graphs').close();
    Hive.box('daily').close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox('graphs'),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done)
          return FutureBuilder(
            future: Hive.openBox('daily'),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done)
                return ResultPage();
              else
                return Loadingscreen();
            },
          );
        else
          return Loadingscreen();
      },
    );
  }
}

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  // final correctwrong = ModalRoute.of(context)!.settings.arguments as Map;

  popup(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // title: Center(
            //   child: Text(
            //     "Congratulations",
            //     style: TextStyle(fontSize: 30),
            //   ),
            // ),
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            content: SingleChildScrollView(
              child: Center(
                child: Stack(
                  children: [
                    Positioned(
                        top: -70,
                        right: -4,
                        child: Container(
                          height: 230,
                          width: 230,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(190, 229, 251, 1),
                          ),
                        )),
                    Positioned(
                      left: -50,
                      top: -70,
                      child: Container(
                        height: 258,
                        width: 278,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(168, 238, 228, 1),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Text(
                              "Congratulations",
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              "You Just Earned 10 points",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: GoogleFonts.nunito().fontFamily),
                            ),
                          ),
                          Container(
                            height: 150,
                            width: 150,
                            child: Image.asset('assets/images/coin.png'),
                          ),
                          Text(
                            "10 Points",
                            style: TextStyle(fontSize: 30),
                          ),
                          Text(
                            "  Use these points to get bonus Time ",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                height: 40,
                                width: 170,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Color.fromRGBO(0, 194, 255, 0.7),
                                      Color.fromRGBO(47, 43, 255, 0.7)
                                    ]),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                    child: Text(
                                  "Hurray",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final correctwrong = ModalRoute.of(context)!.settings.arguments as Map;
    final correct = correctwrong['c'];
    final wrong = correctwrong['w'];
    final playagain = correctwrong['back'];
    var intplayagain;
    final score = correct - wrong;
    final circol = Color.fromRGBO(143, 210, 248, 0.7);
    final circol2 = Color.fromRGBO(124, 255, 184, 0.34);
    final circol3 = Color.fromRGBO(255, 231, 147, 1);
    final circol4 = Color.fromRGBO(187, 225, 138, 0.67);
    final backora = Color.fromRGBO(255, 114, 114, 0.88);
    final backyell = Color.fromRGBO(255, 224, 63, 0.86);
    final playpin = Color.fromRGBO(255, 29, 205, 0.73);
    final playpur = Color.fromRGBO(144, 41, 192, 0.77);

    final graphbox = Hive.box('graphs');
    final dailybox = Hive.box('daily');
    final scorebox = Hive.box('scores');

    if (playagain == MyRoutes.moderateroute) intplayagain = 3;
    if (playagain == MyRoutes.easygameroute) intplayagain = 2;
    if (playagain == MyRoutes.veryEasygameroute) intplayagain = 1;
    if (playagain == MyRoutes.hardgameroute) intplayagain = 4;

    var mediaorien = MediaQuery.of(context).orientation;

    var graphvalue = Graphvalue(intplayagain, wrong, correct);
    graphbox.add(graphvalue);

    dailybox.add(intplayagain);
    bool popupshowbool = false;

    int veryeasy = 0;
    int easy = 0;
    int moderate = 0;
    int hard = 0;
    for (int i = 0; i < dailybox.length; i++) {
      if (dailybox.get(i) == 1) veryeasy++;
      if (dailybox.get(i) == 2) easy++;
      if (dailybox.get(i) == 3) moderate++;
      if (dailybox.get(i) == 4) hard++;
    }

    int coins = 0;
    void specialscore(int level, int mymax) {
      if (scorebox.isEmpty) {
        if (level == mymax) {
          scorebox.add(10);
          coins = 10;
          popupshowbool = true;
        } else {
          coins = 0;
        }
      } else {
        if (level == mymax) {
          int totscore = scorebox.getAt(0);
          scorebox.clear();
          int addscore = totscore + 10;
          scorebox.add(addscore);
          coins = totscore + 10;
          popupshowbool = true;
        } else {
          coins = scorebox.getAt(0);
        }
      }
    }

    if (intplayagain == 1) specialscore(veryeasy, 5);
    if (intplayagain == 2) specialscore(easy, 4);
    if (intplayagain == 3) specialscore(moderate, 3);
    if (intplayagain == 4) specialscore(hard, 2);

    if (mediaorien == Orientation.portrait) {
      Future.delayed(Duration.zero, () {
        if (popupshowbool) popup(context);
      });
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Row(
            children: [
              Text(
                "Colour game",
                style: TextStyle(color: Colors.black, fontSize: 27),
              ),
              Spacer(flex: 2),
              Text(
                "Coins: $coins",
                style: TextStyle(color: Colors.black, fontSize: 27),
              ),
              Spacer(flex: 1)
            ],
          ),
        ),
        body: Stack(
          children: [
            Positioned(
              left: -30,
              child: ClipOval(
                child: Container(
                  height: 170,
                  width: 170,
                  color: circol,
                ),
              ),
            ),
            Positioned(
              right: -25,
              bottom: 260,
              child: ClipOval(
                child: Container(
                  height: 150,
                  width: 150,
                  color: circol3,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  Container(
                    child: Text("Time Up!!!", style: TextStyle(fontSize: 40)),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  ClipOval(
                    child: Container(
                      height: 300,
                      width: 300,
                      color: circol2,
                      child: Center(
                        child: Column(
                          children: [
                            Spacer(),
                            Container(
                              height: 200,
                              child: Image.asset("assets/images/award.png"),
                            ),
                            Container(
                              child: Text(
                                "Score: " + score.toString(),
                                style: TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 20,
                  )
                ],
              ),
            ),
            Positioned(
              bottom: -70,
              right: -60,
              child: ClipOval(
                child: Container(
                  height: 250,
                  width: 250,
                  color: circol4,
                ),
              ),
            ),
            // result part
            Container(
              child: Row(
                children: [
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spacer(
                        flex: 38,
                      ),
                      Container(
                        child: Text(
                          "Correct : " + correct.toString(),
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: GoogleFonts.solway().fontFamily,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "Wrong : " + wrong.toString(),
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: GoogleFonts.solway().fontFamily,
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 184,
                          height: 47,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                              child: Text(
                                "Go back",
                                style: TextStyle(
                                  fontSize: 29,
                                  fontFamily: GoogleFonts.solway().fontFamily,
                                ),
                              )),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [backora, backyell]),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, playagain);
                        },
                        child: Container(
                          width: 184,
                          height: 47,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                              child: Text(
                                "Play Again",
                                style: TextStyle(
                                  fontSize: 29,
                                  fontFamily: GoogleFonts.solway().fontFamily,
                                ),
                              )),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [playpin, playpur]),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 5,
                      )
                    ],
                  ),
                  Spacer(
                    flex: 5,
                  )
                ],
              ),
            )
          ],
        ),
        drawer: MyDrawer(),
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
        ),
      );
    }
  }
}

// class Hello extends StatelessWidget {
//   const Hello({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.lightBlue,
//     );
//   }
// }
