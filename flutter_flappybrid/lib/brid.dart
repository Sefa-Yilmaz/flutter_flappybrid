import 'package:flutter/material.dart';

class MyBrid extends StatelessWidget {
  const MyBrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width * 0.15,
      child: Image.asset('image/flappy_bird.png'),
    );
  }
}
