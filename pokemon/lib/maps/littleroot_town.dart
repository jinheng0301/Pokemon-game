import 'package:flutter/material.dart';

class LittleRootTown extends StatelessWidget {
  double x = 0.0;
  double y = 0.0;
  String currentMap = '';

  LittleRootTown({
    required this.currentMap,
    required this.x,
    required this.y,
  });

  @override
  Widget build(BuildContext context) {
    if (currentMap == 'littleroot') {
      // when we have multiple maps, it will check what the map is right now
      // if the is littleroot, it will return to this container
      return Container(
        alignment: Alignment(x, y),
        child: Image.asset(
          'images/town1.jpg',
          width: MediaQuery.of(context).size.width * 0.75,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Container();
    }
  }
}
