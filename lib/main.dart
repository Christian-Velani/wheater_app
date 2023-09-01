// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(WheaterApp());
}

class WheaterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Color(0xFF255AF4),
          body: Text(
            "São José do Rio Preto",
          style: TextStyle(
            fontSize: 36,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
