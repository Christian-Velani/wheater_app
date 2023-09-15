// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

void main() {
  runApp(WheaterApp());
}

const titleStyle = TextStyle(fontSize: 36, color: Colors.white);

const temperatureStyle = TextStyle(
  fontSize: 64,
  color: Colors.white,
  fontWeight: FontWeight.w500,
  shadows: [ Shadow( color: Color.fromRGBO(0, 0, 0, 0.25), offset: Offset(4, 4))],
);

const iconStyle = TextStyle(
  fontSize: 14,
  color: Colors.white,
  fontWeight: FontWeight.w500
);

class WheaterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF255AF4),
        body: SafeArea(
          child: Column(
            children: [
              Text("São José do Rio Preto", style: titleStyle),
              Container(
                child: Image.asset('images/01_sunny_color.png'),
                width: 96,
                height: 96,
                margin: EdgeInsets.fromLTRB(0, 53, 0, 24),
              ),
              Text("Ensolarado", style: titleStyle),
              Text("33°", style: temperatureStyle),
              Container(
                  margin: EdgeInsets.only(top: 71),
                  child: Column(children: [
                    Image.asset('images/humidity.png'),
                    Text("Humidity", style: iconStyle),
                    Text("52%",  style: iconStyle),
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}
