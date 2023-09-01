// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
          body: Column(
            children: [
              Text(
                "São José do Rio Preto",
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                    ),
              ),
            Container(
              child: Image.asset('images/01_sunny_color.png'),
              width: 96,
              height: 96,
              margin: EdgeInsets.fromLTRB(0, 53, 0, 24),
            ),
              Text(
                "Ensolarado",
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                    ),
              ),
              Text(
                "33°",
                    style: TextStyle(
                      fontSize: 64,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      shadows: [Shadow(
                        color: Color.fromRGBO(0, 0, 0,0.25),
                        offset: Offset(4, 4),
                      )]
                    ),
              ),
            ],
          ),
      ),
    );
  }
}
