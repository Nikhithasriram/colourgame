import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:first_app/widgets/loadingscreen.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({Key? key}) : super(key: key);

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  @override
  void dispose() {
    Hive.box('graphs').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox('graphs'),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done)
          return Values();
        else
          return Loadingscreen();
      },
    );
  }
}

class Values extends StatefulWidget {
  const Values({Key? key}) : super(key: key);

  @override
  _ValuesState createState() => _ValuesState();
}

class _ValuesState extends State<Values> {
  final box = Hive.box('graphs');
  final length = Hive.box('graphs').length;

  // var check = Hive.box('graphs').get(4);
  final Color piepurple = const Color.fromRGBO(196, 149, 240, 1);
  final Color pieorange = const Color.fromRGBO(255, 193, 84, 1);
  final Color piered = const Color.fromRGBO(255, 131, 131, 1);
  final Color piegreen = const Color.fromRGBO(172, 253, 234, 1);

  var mainhig;
  var higveryeasy;
  var higeasy;
  var higmoderate;
  var highard;

  var lenghtveryeasy;
  var lengtheasy;
  var lengthmoderate;
  var lengthard;

  var lowveryeasy;
  var loweasy;
  var lowmoderate;
  var lowhard;

  final linearmain = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(161, 255, 255, 1),
        Color.fromRGBO(198, 39, 254, 0.67)
      ]);
  final linearside = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(44, 217, 255, 1),
        Color.fromRGBO(107, 207, 194, 0.71),
        Color.fromRGBO(99, 239, 155, 0.65),
      ]);
  // var veryeasy;
  List veryeasy = [];
  List easy = [];
  List moderate = [];
  List hard = [];

  late var points;

  // var minveryeasy;
  // var mineasy;
  // var minmoderate;
  // var minhard;

  @override
  void initState() {
    if (length >= 1) {
      for (int i = 0; i < length; i++) {
        var obj = box.get(i);

        var game = box.get(i).game;

        switch (game) {
          case 1:
            veryeasy.add(obj);
            break;
          case 2:
            easy.add(obj);
            break;
          case 3:
            moderate.add(obj);
            break;
          case 4:
            hard.add(obj);
            break;
        }
      }

      higveryeasy = sortscores(veryeasy).last;
      higeasy = sortscores(easy).last;
      higmoderate = sortscores(moderate).last;
      highard = sortscores(hard).last;

      // minveryeasy = sortscores(veryeasy).first;
      // mineasy = sortscores(easy).first;
      // minmoderate = sortscores(moderate).first;
      // minhard = sortscores(hard).first;

      lenghtveryeasy = veryeasy.length;
      lengtheasy = easy.length;
      lengthmoderate = moderate.length;
      lengthard = hard.length;

      List highscores = [higveryeasy, higeasy, higmoderate, highard];
      highscores.sort();
      mainhig = highscores.last;
    } else {
      veryeasy = [];
      easy = [];
      moderate = [];
      hard = [];
    }

    var scores = Hive.box('scores');

    if (scores.isNotEmpty)
      points = scores.getAt(0);
    else
      points = 0;

    super.initState();
  }

  List<int> sortscores(List maxlist) {
    if (maxlist.length >= 1) {
      List<int> scores = [];
      for (int i = 0; i < maxlist.length; i++) {
        var obj = maxlist[i];
        var correct = obj.correct;
        var wrong = obj.wrong;
        scores.add(correct - wrong);
      }

      scores.sort();
      return scores;
    } else {
      return [0];
    }
  }

  List<int> onlyscores(List maxlist) {
    if (maxlist.length >= 1) {
      List<int> scores = [];
      for (int i = 0; i < maxlist.length; i++) {
        var obj = maxlist[i];
        var correct = obj.correct;
        var wrong = obj.wrong;
        scores.add(correct - wrong);
      }
      return scores;
    } else {
      return [0];
    }
  }

  List<FlSpot> spotscores(List list) {
    List myscores = onlyscores(list);
    List<FlSpot> flspots = [];

    for (int i = 0; i < myscores.length; i++) {
      int scoreint = myscores[i];
      double scoresdouble = scoreint.toDouble();
      int sc = i + 1;
      if (scoresdouble < 0) scoresdouble = 0;
      flspots.add((FlSpot(sc.toDouble(), scoresdouble)));
    }
    return flspots;
  }

  @override
  Widget build(BuildContext context) {
    if (length >= 1) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
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
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                child: Center(
                  child: Text(
                    "Check Your Progress",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Center(
                  child: Text(
                    "Games Played In Each Level",
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: GoogleFonts.nunitoSans().fontFamily,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                height: 270,
                width: 270,
                child: piechart(),
              ),
              SizedBox(
                height: 60,
              ),
              Row(
                children: [
                  Spacer(),
                  indicator1(piepurple),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Very Easy",
                    style: TextStyle(fontSize: 19),
                  ),
                  Spacer(),
                  indicator1(piegreen),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Easy",
                    style: TextStyle(fontSize: 19),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Spacer(),
                  indicator1(piered),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Modarate",
                    style: TextStyle(fontSize: 19),
                  ),
                  Spacer(),
                  indicator1(pieorange),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Hard",
                    style: TextStyle(fontSize: 19),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Your Highest Scores",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              scores(linearmain, 116.0, 187.0, "In All Levels", mainhig),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Spacer(),
                  scores(linearside, 116.0, 146.0, "Very Easy", higveryeasy),
                  Spacer(),
                  scores(linearside, 116.0, 146.0, "Easy", higeasy),
                  Spacer()
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Spacer(),
                  scores(linearside, 116.0, 146.0, "Moderate", higmoderate),
                  Spacer(),
                  scores(linearside, 116.0, 146.0, "Hard", highard),
                  Spacer()
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Progress In Each Level",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              veryeasygraph(),
              easygraph(),
              moderategraph(),
              hardgraph(),
              Text(
                "  Scores below zero are cosidered zero for easy understanding  ",
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: Container(
            child: Text(
              "Play Games to check Your Progress",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      );
    }
  }

  Widget veryeasygraph() {
    if (veryeasy.length >= 1) {
      // print(veryeasy.length);
      return Container(
        child: Column(
          children: [
            Text(
              "Very Easy",
              style: TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.w500,
                fontFamily: GoogleFonts.nunitoSans().fontFamily,
              ),
            ),
            SizedBox(
              height: 19,
            ),
            ClayContainer(
              depth: 20, spread: 20,
              borderRadius: 20,
              color: Color(0xFFF2F2F2),
              // height: 250,
              width: 360,
              // decoration:
              //     BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: AspectRatio(
                aspectRatio: 3 / 2,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: linegraph(
                      1,
                      lenghtveryeasy,
                      0,
                      higveryeasy,
                      // [FlSpot(2.0, 3.0)],
                      spotscores(veryeasy),
                      [Colors.purple, Colors.purple.shade100]),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      );
    } else {
      return Container(
        height: 1,
      );
    }
  }

  Widget easygraph() {
    if (easy.length >= 1) {
      return Container(
        child: Column(
          children: [
            Text(
              "Easy",
              style: TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.w500,
                fontFamily: GoogleFonts.nunitoSans().fontFamily,
              ),
            ),
            SizedBox(
              height: 19,
            ),
            ClayContainer(
              depth: 20, spread: 20,
              borderRadius: 20,
              color: Color(0xFFF2F2F2),
              // height: 250,
              width: 360,
              // decoration:
              //     BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: AspectRatio(
                aspectRatio: 3 / 2,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: linegraph(
                      1,
                      lengtheasy,
                      0,
                      higeasy,
                      // [FlSpot(2.0, 3.0)],
                      spotscores(easy),
                      [Colors.blue, Colors.blue.shade100]),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      );
    } else {
      return Container(
        height: 1,
      );
    }
  }

  Widget moderategraph() {
    if (moderate.length >= 1) {
      return Container(
        child: Column(
          children: [
            Text(
              "Moderate",
              style: TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.w500,
                fontFamily: GoogleFonts.nunitoSans().fontFamily,
              ),
            ),
            SizedBox(
              height: 19,
            ),
            ClayContainer(
              depth: 20, spread: 20,
              borderRadius: 20,
              color: Color(0xFFF2F2F2),
              // height: 250,
              width: 360,
              // decoration:
              //     BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: AspectRatio(
                  aspectRatio: 3 / 2,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: linegraph(
                        1,
                        lengthmoderate,
                        0,
                        higmoderate,
                        // [FlSpot(2.0, 3.0), FlSpot(3.0, 4.0)],
                        spotscores(moderate),
                        [Colors.red, Colors.pink.shade100]),
                  )),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      );
    } else {
      return Container(
        height: 1,
      );
    }
  }

  Widget hardgraph() {
    if (hard.length >= 1) {
      return Container(
        child: Column(
          children: [
            Text(
              "Hard",
              style: TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.w500,
                fontFamily: GoogleFonts.nunitoSans().fontFamily,
              ),
            ),
            SizedBox(
              height: 19,
            ),
            ClayContainer(
              depth: 20, spread: 20,
              borderRadius: 20,
              color: Color(0xFFF2F2F2),
              // height: 250,
              width: 360,
              // decoration:
              //     BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: AspectRatio(
                  aspectRatio: 3 / 2,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: linegraph(
                        1,
                        lengthard,
                        0,
                        highard,
                        // [FlSpot(2.0, 3.0)],
                        spotscores(hard),
                        [Colors.yellow, Colors.orange]),
                  )),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      );
    } else {
      return Container(
        height: 1,
      );
    }
  }

  Widget indicator1(colorIn) {
    return ClipOval(
      child: Container(
        color: colorIn,
        height: 20,
        width: 20,
      ),
    );
  }

  Widget scores(linGrad, hei, wid, level, score) {
    return Container(
        // color: linGrad,
        height: hei,
        width: wid,
        // borderRadius: 20,
        decoration: BoxDecoration(
            gradient: linGrad, borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              level,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              score.toString(),
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: GoogleFonts.nunitoSans().fontFamily,
                  fontWeight: FontWeight.w500),
            ),
          ],
        )));
  }

  Widget piechart() {
    double radius = 170;

    return PieChart(
      PieChartData(
        centerSpaceRadius: 0,
        borderData: FlBorderData(show: false),
        sectionsSpace: 0,
        sections: [
          PieChartSectionData(
              value: veryeasy.length.toDouble(),
              color: piepurple,
              showTitle: false,
              radius: radius),
          PieChartSectionData(
              value: easy.length.toDouble(),
              color: piegreen,
              showTitle: false,
              radius: radius),
          PieChartSectionData(
              value: moderate.length.toDouble(),
              color: piered,
              showTitle: false,
              radius: radius),
          PieChartSectionData(
              value: hard.length.toDouble(),
              color: pieorange,
              showTitle: false,
              radius: radius),
        ],
      ),
      swapAnimationCurve: Curves.easeIn,
      swapAnimationDuration: Duration(milliseconds: 20),
    );
  }

  Widget linegraph(int minxside, int maxxside, int minyside, int maxyside,
      List<FlSpot> myspots, List<Color> myGrad) {
    return LineChart(LineChartData(
        borderData: FlBorderData(
            show: true,
            border: Border(
                top: BorderSide.none,
                right: BorderSide.none,
                bottom: BorderSide(),
                left: BorderSide())),
        titlesData: FlTitlesData(
            rightTitles: SideTitles(showTitles: false),
            topTitles: SideTitles(showTitles: false)),
        minX: minxside.toDouble(),
        maxX: maxxside.toDouble() + 1.0,
        minY: minyside.toDouble(),
        maxY: maxyside.toDouble(),
        gridData: FlGridData(show: false),
        axisTitleData: FlAxisTitleData(
            show: true,
            leftTitle: AxisTitle(
                margin: -18,
                showTitle: true,
                titleText: "Scores",
                textStyle: TextStyle(fontSize: 20)),
            bottomTitle: AxisTitle(
                margin: 19,
                showTitle: true,
                titleText: "Games Played",
                textStyle: TextStyle(fontSize: 20))),
        lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: Colors.white, tooltipRoundedRadius: 10)),
        lineBarsData: [
          LineChartBarData(
            colors: myGrad,
            isStrokeCapRound: true,
            barWidth: 3.5,
            dotData: FlDotData(show: false),
            // isCurved: true,
            spots: myspots,
          ),
        ]));
  }
}
