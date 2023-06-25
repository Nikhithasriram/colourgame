// this is the moderate level
import 'dart:async';
import 'dart:math';
import 'package:first_app/utils/routes.dart';
import 'package:first_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:first_app/widgets/background.dart';
import 'package:first_app/utils/colors.dart';
import 'package:first_app/widgets/points.dart';
import 'package:hive/hive.dart';

class ModeratePage extends StatefulWidget {
  const ModeratePage({Key? key}) : super(key: key);

  @override
  _ModeratePageState createState() => _ModeratePageState();
}

class _ModeratePageState extends State<ModeratePage>
    with SingleTickerProviderStateMixin {
  late String qn;
  late String ans1;
  late String ans2;

  int len = Random().nextInt(9);
  int len2 = Random().nextInt(9);
  late Color qncolor;
  Color border = Colors.blue.shade200;
  late String counterstring;
  int correct = 0;
  int wrong = 0;
  late int counter;
  int tottime = 60;
  late PausableTimer mytimer;
  Duration d = Duration(milliseconds: 0);

  late AnimationController animationcontroller;
  late Animation coloranim;
  late Animation coloranim1;

  IconData corrrecticon = Icons.check_rounded;
  IconData wrongicon = Icons.close_rounded;
  IconData defaulticon = Icons.close_rounded;

  bool isopen = false;
  late var score;

  @override
  void initState() {
    super.initState();
    counter = tottime;
    counterstring = tottime.toString();
    
    if (len == len2) {
      if (len2 >= 5)
        len2 += 1;
      else
        len2 -= 1;
    }
    qncolor = customcolor[len];
    qn = name[len2];
    bool rand = Random().nextBool();
    if (rand) {
      ans1 = name[len2];
      ans2 = name[len];
    } else {
      ans2 = name[len2];
      ans1 = name[len];
    }

    // mytimer = Timer.periodic(
    //   Duration(seconds: 1),
    //   (timer) {
    //     timecall();
    //   },
    // );
    mytimer = PausableTimer(Duration(seconds: 1), () {
      timecall();
      mytimer
        ..reset()
        ..start();
    });
    mytimer.start();
  }

  Future<bool?> showpopup(BuildContext context) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          isopen = true;
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text("Are you sure you want to \nleave the game?"),
              actions: [
                OutlinedButton(
                    onPressed: () {
                      isopen = false;
                      mytimer.cancel();
                      Navigator.pop(context, true);
                    },
                    child: Text("Yes")),
                ElevatedButton(
                    onPressed: () {
                      isopen = false;
                      mytimer.start();
                      Navigator.pop(context, false);
                    },
                    child: Text("No"))
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var scores = Hive.box('scores');
    if (scores.isNotEmpty)
      score = scores.getAt(0);
    else
      score = 0;

    void increasetime() {
      if (counter <= 50) {
        counter = counter + 10;
      } else {
        counter = tottime;
      }
    }

    var mediaorien = MediaQuery.of(context).orientation;
    if (mediaorien == Orientation.portrait) {
      mytimer.start();
      return WillPopScope(
        onWillPop: () async {
          final shouldpop = await showpopup(context);
          return shouldpop ?? false;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
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
                Text(
                  "Level:  Moderate",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: GoogleFonts.nunito().fontFamily),
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
                      MyPoints(
                        scores: score,
                       
                        increasetime: increasetime,
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Container(
                              alignment: Alignment.topRight,
                              child: Text("Correct: $correct",
                                  style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.nunito().fontFamily,
                                      fontSize: 26)),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Text("Wrong: $wrong",
                                  style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.nunito().fontFamily,
                                      fontSize: 26)),
                            ),
                          ),
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
                          child: Text(qn,
                              style: TextStyle(
                                  color: qncolor,
                                  fontFamily: GoogleFonts.nunito().fontFamily,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold)),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: border, width: 4),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          //this is the first ans
                          Spacer(),
                          Container(
                            alignment: Alignment.center,

                            child: CircularStepProgressIndicator(
                              totalSteps: tottime,
                              currentStep: tottime - counter,
                              width: 120,
                              stepSize: 12,
                              height: 120,
                              child: Center(
                                child: Column(
                                  children: [
                                    Spacer(),
                                    Icon(
                                      Icons.access_time_outlined,
                                      size: 30,
                                    ),
                                    Text(
                                      "00:" + counterstring,
                                      style: TextStyle(
                                        fontFamily:
                                            GoogleFonts.nunito().fontFamily,
                                        fontSize: 24,
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                              unselectedColor: Colors.grey.withOpacity(0.023),
                              gradientColor: LinearGradient(
                                  colors: [progresspurple, progressblue]),
                              roundedCap: (_, __) => true,
                            ),
                            //},
                            //),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Spacer(
                            flex: 5,
                          ),

                          InkWell(
                            onTap: () {
                              setState(() {
                                correctwrong2();
                                mystate();
                              });
                            },
                            child: Container(
                              height: 62,
                              width: 160,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(ans2,
                                      style: TextStyle(
                                          fontFamily:
                                              GoogleFonts.nunito().fontFamily,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 4),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),

                          //this is the second answer
                          Spacer(
                            flex: 2,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                correctwrong1();
                                mystate();
                              });
                            },
                            child: Container(
                              height: 62,
                              width: 160,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(ans1,
                                      style: TextStyle(
                                          fontFamily:
                                              GoogleFonts.nunito().fontFamily,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 4),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          Spacer(
                            flex: 5,
                          )
                        ],
                      ),
                      // the tick and wrong animation
                      AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        child: Icon(
                          defaulticon,
                          color: defaultanimationcolour,
                          size: 100,
                        ),
                      ),
                      Spacer(
                        flex: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          drawer: MyDrawer(),
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

  // to incrimenting the seconds and going to the next screen after 1 min
  void timecall() {
    setState(() {
      if (isopen == false) {
        if (counter <= 0) {
          mytimer.cancel();
          if (correct > 0 && wrong > 0)
            Navigator.of(context)
                .pushReplacementNamed(MyRoutes.result, arguments: {
              'c': correct,
              'w': wrong,
              'back': MyRoutes.moderateroute,
            });
          else if (correct == 0 && wrong > 0) {
            Navigator.of(context).pushReplacementNamed(MyRoutes.result,
                arguments: {
                  'c': 0,
                  'w': wrong,
                  'back': MyRoutes.moderateroute
                });
          } else if (correct > 0 && wrong == 0) {
            Navigator.of(context).pushReplacementNamed(MyRoutes.result,
                arguments: {
                  'c': correct,
                  'w': 0,
                  'back': MyRoutes.moderateroute
                });
          } else
            Navigator.of(context).pushReplacementNamed(MyRoutes.result,
                arguments: {'c': 0, 'w': 0, 'back': MyRoutes.moderateroute});
        } else {
          counter = counter - 1;
          if (counter < 10) {
            counterstring = "0" + counter.toString();
          } else {
            counterstring = counter.toString();
          }
        }
      } else {
        mytimer.pause();
      }
    });
  }

  // new qn after the person answers the question
  void mystate() {
    String check = ans1;
    String check2 = ans2;
    // print(check);

    len = Random().nextInt(9);
    ans1 = name[len];
    // checks if the last qn is same as this qn
    if (ans1 == check) {
      if (len <= 5)
        //int i = Random().nextInt(4);
        ans1 = name[len + 1];

      if (len >= 5) ans1 = name[len - 1];

      // print("Hello");
    }

    // print(ans1);
    len2 = Random().nextInt(9);
    ans2 = name[len2];
    if (ans2 == check2) {
      if (len2 <= 5) {
        //int i = Random().nextInt(4);
        ans2 = name[len2 + 1];
      }
      if (len2 >= 5) {
        ans2 = name[len2 - 1];
      }

      // print("Good");
    }
    // if same option is not needed then uncomment this below part
    if (ans1 == ans2) {
      if (len < 8) ans1 = name[len + 1];
      if (len >= 8) ans1 = name[len - 3];
      // print(ans1);
      // print("Bye");
    }

    // this decides where the ans should be ...in the left or right
    bool option = Random().nextBool();
    if (option == true) {
      qn = ans1;
      int index1 = name.indexOf(ans2);
      qncolor = customcolor[index1];
      int borderidex = Random().nextInt(6);
      border = bordercolor[borderidex];
    } else {
      qn = ans2;
      int index2 = name.indexOf(ans1);
      qncolor = customcolor[index2];
      int borderidex = Random().nextInt(6);
      border = bordercolor[borderidex];
    }
  }

  // checks if the ans is correct and increments the number based on it
  void correctwrong1() {
    int indexqn = customcolor.indexOf(qncolor);
    int indexans = name.indexOf(ans1);
    if (indexqn != indexans) {
      correct++;
      defaultanimationcolour = animatedcolourcorrect;
      defaulticon = corrrecticon;
      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          defaultanimationcolour = Colors.transparent;
        });
      });
    } else {
      wrong++;
      defaultanimationcolour = animatedcolourwrong;
      defaulticon = wrongicon;
      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          defaultanimationcolour = Colors.transparent;
        });
      });
    }
  }

  // checks if the ans is correct and increments the number based on it
  void correctwrong2() {
    int indexqn = customcolor.indexOf(qncolor);
    int indexans2 = name.indexOf(ans2);
    defaulticon = corrrecticon;
    if (indexqn != indexans2) {
      defaultanimationcolour = animatedcolourcorrect;
      correct++;
      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          defaultanimationcolour = Colors.transparent;
        });
      });
    } else {
      wrong++;
      defaulticon = wrongicon;
      defaultanimationcolour = animatedcolourwrong;
      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          defaultanimationcolour = Colors.transparent;
        });
      });
    }
  }
}
