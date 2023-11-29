import 'package:flutter/material.dart';

class ProfOak extends StatelessWidget {
  double x;
  double y;
  String location;
  String oakDirection;

  ProfOak({
    required this.x,
    required this.y,
    required this.location,
    required this.oakDirection,
  });

  @override
  Widget build(BuildContext context) {
    if (location == 'littleroot') {
      return Container(
        height: 20,
        width: MediaQuery.of(context).size.width * 0.75,
        alignment: Alignment(x, y),
        child: Image.asset(
          'images/oak$oakDirection.jpg',
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Container();
    }
  }
}
