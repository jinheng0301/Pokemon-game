import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pokemon/characters/boy.dart';
import 'package:pokemon/components/buttons.dart';
import 'package:pokemon/lists/no_man_lands_lab.dart';
import 'package:pokemon/maps/littleroot_town.dart';
import 'package:pokemon/maps/pokelab.dart';
import 'package:pokemon/screens/littleroot_page.dart';

class PokelabPage extends StatefulWidget {
  static const String id = 'pokelab_page';

  @override
  State<PokelabPage> createState() => _PokelabPageState();
}

class _PokelabPageState extends State<PokelabPage> {
  // game stuff
  String currentLocation = 'pokelab';
  double step = 0.25;

  // littleroot
  double mapX = 0.4;
  double mapY = -1.05;

  // pokelab
  double labMapX = 0;
  double labMapY = 0;

  // boy character
  int boySpriteCount = 0;
  String boyDirection = 'Up';

  void moveToLittleRoot() {
    Navigator.pushNamed(context, LittleRootPage.id);
  }

  void moveLeft() {
    boyDirection = 'Left';

    if (currentLocation == 'pokelab') {
      if (canMoveTo(boyDirection, noMansLandLab, mapX, mapY)) {
        setState(() {
          labMapX += step;
        });
      }
    }

    animateWalk();
  }

  void moveRight() {
    boyDirection = 'Right';

    if (currentLocation == 'pokelab') {
      if (canMoveTo(boyDirection, noMansLandLab, mapX, mapY)) {
        setState(() {
          labMapX -= step;
        });
      }
    }

    animateWalk();
  }

  void moveUp() {
    boyDirection = 'Up';

    if (currentLocation == 'pokelab') {
      if (canMoveTo(boyDirection, noMansLandLab, mapX, mapY)) {
        setState(() {
          labMapY += step;
        });
      }
    }

    animateWalk();
  }

  void moveDown() {
    boyDirection = 'Down';

    if (currentLocation == 'pokelab') {
      if (canMoveTo(boyDirection, noMansLandLab, mapX, mapY)) {
        setState(() {
          labMapY -= step;
        });
      }

      // return to littleroot
      // if you are standing this door(this coordinate), it will change to pokelab
      if (double.parse(labMapX.toString()) == 0.0 &&
          double.parse(labMapY.toString()) == -2.75) {
        // setState(() {
        //   currentLocation = 'littleroot';
        //   mapX = 0;
        //   mapY = -2.7;
        // });

        // Call the moveToLittleRoot function to navigate back to LittleRootPage
        moveToLittleRoot();
      }
    }

    animateWalk();
  }

  void animateWalk() {
    print('x: ${labMapX.toString()}, y: ${labMapY.toString()}');

    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        boySpriteCount++;
      });

      if (boySpriteCount == 4) {
        boySpriteCount = 0;
        timer.cancel();
      }
    });
  }

  bool canMoveTo(String direction, var noMansLand, double x, double y) {
    double stepX = 0.0;
    double stepY = 0.0;

    print('direction: $direction, x: $x, y: $y');
    print('stepX: $stepX, stepY: $stepY');

    if (direction == 'Left') {
      stepX = step;
      stepY = 0;
    } else if (direction == 'Right') {
      stepX = -step;
      stepY = 0;
    } else if (direction == 'Up') {
      stepX = 0;
      stepY = step;
    } else if (direction == 'Down') {
      stepX = 0;
      stepY = -step;
    }

    for (int i = 0; i < noMansLand.length; i++) {
      if ((noMansLandLab[i][0] - (x + stepX)).abs() < 0.01 &&
          (noMansLandLab[i][1] - (y + stepY)).abs() < 0.01) {
        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              color: Colors.black,
              child: Stack(
                children: [
                  Pokelab(
                    currentMap: currentLocation,
                    x: labMapX,
                    y: labMapY,
                  ),
                  LittleRootTown(
                    currentMap: currentLocation,
                    x: mapX,
                    y: mapY,
                  ),
                  Container(
                    alignment: Alignment(0, 0),
                    child: MyBoy(
                      location: currentLocation,
                      boySpriteCount: boySpriteCount,
                      direction: boyDirection,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[800],
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'G A M E B O Y',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                            ),
                            MyButton(
                              text: '←',
                              function: moveLeft,
                            ),
                            Container(
                              height: 50,
                              width: 50,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            MyButton(
                              text: '↑',
                              function: moveUp,
                            ),
                            Container(
                              height: 50,
                              width: 50,
                            ),
                            MyButton(
                              text: '↓',
                              function: moveDown,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                            ),
                            MyButton(
                              text: '→',
                              function: moveRight,
                            ),
                            Container(
                              height: 50,
                              width: 50,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                ),
                                MyButton(
                                  text: '⇇',
                                  // function: pressedB,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                MyButton(
                                  text: '⇉',
                                  // function: pressedA,
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '⇇ and ⇉ are the return and forward button for the dialogues',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Created by JinHeng',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
