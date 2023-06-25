import 'package:flutter/material.dart';

final Color progressblue = const Color.fromRGBO(215, 101, 255, 1);
final Color progresspurple = const Color.fromRGBO(23, 3, 255, 0.81);
late String qn;
late String ans1;
late String ans2;
final List<Color> customcolor = [
  Colors.orange,
  Colors.pink.shade300,
  Colors.purple,
  Colors.red,
  Colors.yellow,
  Colors.lightGreen,
  Colors.lightBlue,
  Colors.black,
  Colors.brown,
  Colors.grey.shade600,
  //Colors.yellow.shade50,
];

final List<Color> bordercolor = [
  Colors.green.shade100,
  Colors.lightBlue.shade100,
  Colors.purpleAccent.shade100,
  Colors.amber.shade100,
  Colors.deepOrange.shade100,
  Colors.pink.shade100,
  Colors.red.shade100,
];

final List<String> name = [
  "Orange",
  "Pink",
  "Purple",
  "Red",
  "Yellow",
  "Green",
  "Blue",
  "Black",
  "Brown",
  "Grey"
];

Color animatedcolourcorrect = Colors.greenAccent;
Color animatedcolourwrong = Colors.redAccent;
Color defaultanimationcolour = Colors.transparent;

Color pointscolor = Color.fromRGBO(228, 186, 253, 1);
