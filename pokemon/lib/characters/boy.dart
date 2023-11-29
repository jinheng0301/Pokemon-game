import 'package:flutter/material.dart';

class MyBoy extends StatelessWidget {
  int boySpriteCount;
  String direction = '';
  String location = '';

  MyBoy({
    required this.boySpriteCount,
    required this.direction,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      child: Image.asset(
        //'images/boy' + direction + boySpriteCount.toString() + '.jpg'
        'images/boy$direction$boySpriteCount.jpg',
        fit: BoxFit.cover, // it will gonna fill out the rest of space
      ),
    );
  }
}
