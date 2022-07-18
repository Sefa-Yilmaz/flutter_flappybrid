import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_flappybrid/barriers.dart';
import 'package:flutter_flappybrid/brid.dart';
import 'package:flutter_flappybrid/scores.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double kus = 0;
  double zaman = 0;
  double yukseklik = 0;
  double baslangicYuksekligi = kus;
  bool oyunBasladi = false;
  static double bariyerXbir = 1;
  double bariyerXiki = bariyerXbir + 2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (oyunBasladi) {
          jump();
        } else {
          startgame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Stack(children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 0),
                    alignment: Alignment(0, kus),
                    color: Colors.blue,
                    child: const MyBrid(),
                  ),
                  Container(
                    alignment: const Alignment(0, -0.3),
                    child: oyunBasladi
                        ? const SizedBox.shrink()
                        : const Text(
                            "OYNAMAK İÇİN DOKUNUN",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(bariyerXbir, 1.1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(size: 165.0),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(bariyerXbir, -1.1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(size: 165.0),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(bariyerXiki, 1.1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(size: 100.0),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(bariyerXiki, -1.1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(size: 250.0),
                  ),
                ])),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: const ScoresWidget(),
              ),
            )
          ],
        ),
      ),
    );
  }

  void jump() {
    setState(() {
      zaman = 0;
      baslangicYuksekligi = kus;
    });
  }

  void startgame() {
    oyunBasladi = true;
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      bariyerXbir += 0.01;
      bariyerXiki += 0.01;
      zaman += 0.05;
      yukseklik = -4.9 * zaman * zaman + 2.8 * zaman;
      setState(() {
        kus = baslangicYuksekligi - yukseklik;

        bariyerXbir -= 0.05;
        bariyerXiki -= 0.05;
      });
      setState(() {
        if (bariyerXbir < -2) {
          bariyerXbir += 3.5;
        } else {
          bariyerXbir -= 0.05;
        }
      });

      setState(() {
        if (bariyerXiki < -2) {
          bariyerXiki += 3.5;
        } else {
          bariyerXiki -= 0.05;
        }
      });
      if (kus > 1) {
        timer.cancel();
        oyunBasladi = false;
      }
    });
  }
}
