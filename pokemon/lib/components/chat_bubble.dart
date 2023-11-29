import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  String text = '';
  final function;

  ChatBubble({
    required this.text,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      height: 30,
      width: 10,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
    );
  }
}
