import 'package:flutter/material.dart';
import 'package:first_app/utils/colors.dart';
import 'package:hive/hive.dart';

class MyPoints extends StatefulWidget {
  final scores;
  final increasetime;
  const MyPoints({Key? key, this.scores, this.increasetime}) : super(key: key);

  @override
  State<MyPoints> createState() => _MyPointsState();
}

class _MyPointsState extends State<MyPoints> {
  @override
  Widget build(BuildContext context) {
    int points = widget.scores;
    var incresetime = widget.increasetime;

    void decreasepoints() {
      var scores = Hive.box('scores');
      var hivescore = scores.getAt(0);
      scores.clear();
      scores.add(hivescore - 10);

      incresetime();
    }

    void nopoints(BuildContext context) {
      var snackbar = SnackBar(
        content: Text(
          "Not Enough Coins",
          style: TextStyle(fontSize: 20),
        ),
        padding: EdgeInsets.all(20),
        backgroundColor: Colors.red.shade200,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context)..showSnackBar(snackbar);
    }

    return Container(
      height: 72,
      width: 267,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      child: Center(
        child: Row(
          children: [
            Spacer(),
            Text(
              "Coins: $points",
              style: TextStyle(fontSize: 20),
            ),
            Spacer(),
            Container(
              height: 46,
              width: 120,
              decoration: BoxDecoration(
                  color: pointscolor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Builder(builder: (context) {
                return InkWell(
                  onTap: () {
                    if (points >= 10)
                      decreasepoints();
                    else
                      nopoints(context);
                  },
                  child: Center(
                    child: Row(
                      children: [
                        Spacer(),
                        Icon(Icons.access_time_outlined),
                        Text(
                          "+10s",
                          style: TextStyle(fontSize: 20),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                );
              }),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
