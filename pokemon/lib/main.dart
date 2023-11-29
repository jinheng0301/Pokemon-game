import 'package:flutter/material.dart';
import 'package:pokemon/screens/littleroot_page.dart';

void main() {
  runApp(const MyPokemon());
}

class MyPokemon extends StatelessWidget {
  const MyPokemon({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LittleRootPage(),
    );
  }
}