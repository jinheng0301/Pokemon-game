import 'package:flutter/material.dart';
import 'package:pokemon/screens/littleroot_page.dart';
import 'package:pokemon/screens/pokelab_page.dart';

void main() {
  runApp(const MyPokemon());
}

class MyPokemon extends StatelessWidget {
  const MyPokemon({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LittleRootPage(),
        LittleRootPage.id: (context) => LittleRootPage(),
        PokelabPage.id: (context) => PokelabPage(),
      },
    );
  }
}
