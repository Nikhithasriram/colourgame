import 'dart:math';
import 'package:first_app/widgets/loadingscreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Daily extends StatefulWidget {
  const Daily({Key? key}) : super(key: key);

  @override
  _DailyState createState() => _DailyState();
}

class _DailyState extends State<Daily> {
  void dispose() {
    Hive.box('daily').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox('daily'),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done)
          return DailyPage();
        else
          return Loadingscreen();
      },
    );
  }
}

class DailyPage extends StatefulWidget {
  const DailyPage({Key? key}) : super(key: key);

  @override
  _DailyPageState createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  int veryeasy = 0;
  int easy = 0;
  int moderate = 0;
  int hard = 0;
  late var points;
  @override
  void initState() {
    Hive.openBox('daily');
    var dailybox = Hive.box('daily');
    for (int i = 0; i < dailybox.length; i++) {
      if (dailybox.get(i) == 1) veryeasy++;
      if (dailybox.get(i) == 2) easy++;
      if (dailybox.get(i) == 3) moderate++;
      if (dailybox.get(i) == 4) hard++;
    }

    var scores = Hive.box('scores');

    if (scores.isNotEmpty)
      points = scores.getAt(0);
    else
      points = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.black,
        elevation: 0,
        title: Row(
          children: [
            Spacer(),
            Text(
              "Colour Game",
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                "Daily Challenge",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 40,
              ),
              Text("Very Easy",
                  style: TextStyle(
                    fontSize: 30,
                  )),
              SizedBox(
                height: 10,
              ),
              TweenAnimationBuilder<double>(
                curve: Curves.easeIn,
                tween: Tween(begin: 0.0, end: veryeasy.toDouble()),
                duration: Duration(seconds: 1),
                builder: (context, double value, _) {
                  return mypie(
                      Color.fromRGBO(196, 149, 240, 1), value, 5, veryeasy);
                },
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Play atleast 5 Very Easy level games to earn 10 points",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: GoogleFonts.nunitoSans().fontFamily,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(" Easy",
                  style: TextStyle(
                    fontSize: 30,
                  )),
              SizedBox(
                height: 10,
              ),
              TweenAnimationBuilder(
                  curve: Curves.easeIn,
                  tween: Tween(begin: 0.0, end: easy.toDouble()),
                  duration: Duration(seconds: 1),
                  builder: (context, double value, _) {
                    return mypie(
                        Color.fromRGBO(172, 253, 234, 1), value, 4, easy);
                  }),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Play atleast 4 Easy level games to earn 10 points",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: GoogleFonts.nunitoSans().fontFamily,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text("Moderate",
                  style: TextStyle(
                    fontSize: 30,
                  )),
              SizedBox(
                height: 10,
              ),
              TweenAnimationBuilder(
                  curve: Curves.easeIn,
                  duration: Duration(seconds: 1),
                  tween: Tween(begin: 0.0, end: moderate.toDouble()),
                  builder: (context, double value, _) {
                    return mypie(Color.fromRGBO(255, 131, 131, 1),
                        moderate.roundToDouble(), 3, moderate);
                  }),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Play atleast 3 Moderate level games to earn 10 points",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: GoogleFonts.nunitoSans().fontFamily,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text("Hard",
                  style: TextStyle(
                    fontSize: 30,
                  )),
              SizedBox(
                height: 10,
              ),
              TweenAnimationBuilder(
                curve: Curves.easeIn,
                duration: Duration(seconds: 1),
                tween: Tween(begin: 0.0, end: hard.toDouble()),
                builder: (context, double value, child) =>
                    mypie(Color.fromRGBO(255, 193, 84, 1), value, 2, hard),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Play atleast 2 Hard level games to earn 10 points",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: GoogleFonts.nunitoSans().fontFamily,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget mypie(Color mycolor, double value, int mymax, int score) {
    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[200],
          boxShadow: [
            BoxShadow(
                offset: Offset(4.0, 4.0),
                color: Colors.grey.shade400,
                spreadRadius: 1,
                blurRadius: 15.0),
            BoxShadow(
                offset: Offset(-4.0, -4.0),
                color: Colors.white,
                spreadRadius: 3,
                blurRadius: 15.0)
          ]),
      child: Center(
        child: Container(
          height: 260,
          width: 260,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Colors.grey.shade200,
                Colors.grey.shade200,
                Colors.grey.shade200,
                Colors.grey.shade300
              ],
            ),
          ),
          child: Center(
            child: Stack(
              children: [
                Center(
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade200,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(4.0, 4.0),
                              color: Colors.grey.shade400,
                              spreadRadius: 1,
                              blurRadius: 15.0),
                          BoxShadow(
                              offset: Offset(-4.0, -4.0),
                              color: Colors.white,
                              spreadRadius: 1,
                              blurRadius: 15.0)
                        ]),
                    child: Center(
                        child: Text(score.toString() + " / " + mymax.toString(),
                            style: TextStyle(
                              fontSize: 25,
                            ))),
                  ),
                ),
                Center(
                    child: CustomPaint(
                  painter:
                      MyArcPainter(colour: mycolor, value: value, max: mymax),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyArcPainter extends CustomPainter {
  final Color colour;
  final double value;
  final int max;
  MyArcPainter({required this.colour, required this.value, required this.max});
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: 103);

    final paint = Paint()
      ..color = colour
      ..style = PaintingStyle.stroke
      ..strokeWidth = 53
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, 3 * pi / 2, 2 * pi * value / max, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
