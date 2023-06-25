import 'package:flutter/material.dart';
import 'dart:ui';


class MyBackground extends StatelessWidget {
  const MyBackground({Key? key}) : super(key: key);
  final Color yellowgame = const Color.fromRGBO(255, 229, 95, 1);
  final Color purplegame = const Color.fromRGBO(253, 154, 255, 1);
  final Color bluegame = const Color.fromRGBO(79, 149, 255, 0.69);
  final Color greengame = const Color.fromRGBO(107, 226, 219, 0.58);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            left: -70,
            child: Container(
              child: ClipOval(
                child: Container(
                  height: 270,
                  width: 270,
                  color: purplegame,
                ),
              ),
            ),
          ),
          Positioned(
            top: -30,
            right: -60,
            child: Container(
              child: ClipOval(
                child: Container(
                  height: 190,
                  width: 190,
                  color: yellowgame,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 150,
            left: 60,
            child: ClipOval(
              child: Container(
                height: 120,
                width: 120,
                color: bluegame,
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            right: -50,
            child: Container(
              child: ClipOval(
                child: Container(
                  height: 230,
                  width: 230,
                  color: greengame,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              height: 530,
              width: 350,
              child: Glasslook(),
            ),
          ),
        ],
      ),
    );
  }
}

// the frosted glass look is created in this function
class Glasslook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(1)),
                    gradient: LinearGradient(begin: Alignment.topLeft, colors: [
                      Colors.white.withOpacity(0.4),
                      Colors.white.withOpacity(0.3)
                    ], stops: [
                      0.5,
                      0.1
                    ])),
              ),
            ),
          )
        ],
      ),
    );
  }
}
