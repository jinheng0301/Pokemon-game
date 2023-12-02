import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pokemon/characters/boy.dart';
import 'package:pokemon/characters/oak.dart';
import 'package:pokemon/components/buttons.dart';
import 'package:pokemon/lists/dialogue_index.dart';
import 'package:pokemon/lists/no_man_lands_littleroot.dart';
import 'package:pokemon/maps/littleroot_town.dart';
import 'package:pokemon/maps/pokelab.dart';
import 'package:pokemon/screens/pokelab_page.dart';

class LittleRootPage extends StatefulWidget {
  static const String id = 'littleroot_page';

  @override
  State<LittleRootPage> createState() => _HomePageState();
}

class _HomePageState extends State<LittleRootPage> {
  // littleroot
  double mapX = 0.9;
  double mapY = 0.2;

  // pokelab
  double labMapX = 0;
  double labMapY = 0;

  // game stuff
  String currentLocation = 'littleroot';
  double step = 0.25;

  // boy character
  int boySpriteCount = 0; // 0 for standing 1-2 for walking
  String boyDirection = 'Right';

  // professor Oak
  String oakDirection = 'Front';
  double initialOakX = 0;
  double initialOakY = 0;
  double oakX = 0;
  double oakY = 0;
  bool chatStarted = false;
  int countPressingA = -1;

  _HomePageState() {
    // Initialize the initial position of Professor Oak
    initialOakX = 0; // Set your desired initial X coordinate
    initialOakY = 0; // Set your desired initial Y coordinate
    oakX = initialOakX;
    oakY = initialOakY;
  }

  void moveToPokelab() {
    Navigator.pushNamed(context, PokelabPage.id);
  }

  void moveLeft() {
    boyDirection = 'Left';

    if (currentLocation == 'littleroot') {
      if (canMoveTo(boyDirection, noManLandsLittleroot, mapX, mapY)) {
        setState(() {
          mapX += step;
          oakX = initialOakX + mapX;
          // Update Professor Oak's position based on the boy's movement
        });
      }
    }
    // checkProfTalk();
    animateWalk();
  }

  void moveRight() {
    boyDirection = 'Right';
    if (currentLocation == 'littleroot') {
      if (canMoveTo(boyDirection, noManLandsLittleroot, mapX, mapY)) {
        setState(() {
          mapX -= step;
          oakX = initialOakX + mapX;
        });
      }
    }
    // checkProfTalk();
    animateWalk();
  }

  void moveUp() {
    boyDirection = 'Up';
    if (currentLocation == 'littleroot') {
      if (canMoveTo(boyDirection, noManLandsLittleroot, mapX, mapY)) {
        setState(() {
          mapY += step;
          oakY = initialOakY + mapY;
        });
        // checkProfTalk();
      }

      // enter pokelab
      // if you are standing this door(this coordinate), it will change to pokelab
      if (double.parse(mapX.toString()) == 0.4 &&
          double.parse(mapY.toString()) == -0.8) {
        // setState(() {
        //   currentLocation = 'pokelab';
        //   labMapX = 0;
        //   labMapY = -2.7;
        // });

        // Call the moveToPokelab function to navigate to the PokelabPage
        moveToPokelab();
      }
    }
    animateWalk();
  }

  void moveDown() {
    boyDirection = 'Down';
    if (currentLocation == 'littleroot') {
      if (canMoveTo(boyDirection, noManLandsLittleroot, mapX, mapY)) {
        setState(() {
          mapY -= step;
          oakY = initialOakY + mapY;
        });
        // checkProfTalk();
      }
    }
    animateWalk();
  }

  void animateWalk() {
    print('x: ${mapX.toString()}, y: ${mapY.toString()}');

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
      if ((noManLandsLittleroot[i][0] - (x + stepX)).abs() < 0.01 &&
          (noManLandsLittleroot[i][1] - (y + stepY)).abs() < 0.01) {
        return false;
      }
    }

    return true;
  }

  // void profTalk() async {
  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         content: Center(
  //           child: Text(dialogues[currentDialogueIndex]),
  //         ),
  //       );
  //     },
  //   );
  // }

  // void checkProfTalk() {
  //   // Check if the boy is close to Professor Oak and initiate dialogue
  //   if (currentLocation == 'littleroot') {
  //     double boyX = mapX;
  //     double boyY = mapY;

  //     // Use the actual coordinates of Professor Oak
  //     double oakDistance = ((oakX - boyX).abs() + (oakY - boyY).abs());

  //     // Adjust the threshold based on your requirements
  //     double dialogueThreshold = 0.2;

  //     if (oakDistance < dialogueThreshold) {
  //       if (!chatStarted) {
  //         setState(() {
  //           chatStarted = true;
  //         });
  //         profTalk();
  //       }
  //     } else {
  //       setState(() {
  //         chatStarted = false;
  //       });
  //     }
  //   }
  // }

  void pressedA() {
    if (currentDialogueIndex < dialogues.length - 1) {
      setState(() {
        currentDialogueIndex++;
        chatStarted = true;
      });
      // profTalk();
    }
  }

  void pressedB() {
    if (currentDialogueIndex > 0) {
      setState(() {
        currentDialogueIndex--;
        chatStarted = true;
      });
      // profTalk();
    }
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
                  LittleRootTown(
                    currentMap: currentLocation,
                    x: mapX,
                    y: mapY,
                  ),
                  Pokelab(
                    currentMap: currentLocation,
                    x: labMapX,
                    y: labMapY,
                  ),
                  Container(
                    alignment: Alignment(0, 0),
                    child: MyBoy(
                      location: currentLocation,
                      boySpriteCount: boySpriteCount,
                      direction: boyDirection,
                    ),
                  ),
                  Container(
                    alignment: Alignment(0, 0),
                    child: ProfOak(
                      x: oakX,
                      y: oakY,
                      location: currentLocation,
                      oakDirection: oakDirection,
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
                    // if (chatStarted)
                    //   ChatBubble(
                    //     text: professorDialogue,
                    //   ),
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
                                  function: pressedB,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                MyButton(
                                  text: '⇉',
                                  function: pressedA,
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
