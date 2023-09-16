// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'style.dart';

void main() {
  runApp(WheaterApp());
}

class WheaterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF255AF4),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("São José do Rio Preto", style: titleStyle),
              Column(
                children: [
                  Container(
                    child: Image.asset('images/01_sunny_color.png'),
                    width: 96,
                    height: 96,
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 24),
                  ),
                  Text("Ensolarado", style: titleStyle),
                  Text("33°", style: temperatureStyle),
                ],
              ),
              Container(
                // margin: EdgeInsets.only(top: 71),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Image.asset('images/humidity.png'),
                        Text("Humidity", style: iconStyle),
                        Text("52%", style: iconStyle),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset('images/wind.png'),
                        Text("Wind", style: iconStyle),
                        Text("19km/h", style: iconStyle),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset('images/feels_like.png'),
                        Text("Feels Like", style: iconStyle),
                        Text("24", style: iconStyle),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 100,
                // margin: EdgeInsets.only(top: 80),
                child: Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ForecastDay("Now", "nublado", 19),
                      ForecastDay("10 AM", "nublado", 19),
                      ForecastDay("11 AM", "sol_nublado", 18),
                      ForecastDay("12 AM", "sol_nublado", 18),
                      ForecastDay("13 PM", "chuva", 14),
                      ForecastDay("14 PM", "nublado", 19),
                      ForecastDay("15 PM", "nublado", 19),
                      ForecastDay("16 PM", "nublado", 19),
                      ForecastDay("17 PM", "nublado", 19),
                      ForecastDay("18 PM", "nublado", 19),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ForecastDay extends StatelessWidget {
  String hour;
  String image;
  double temperature;

  ForecastDay(this.hour, this.image, this.temperature);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 39),
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(hour, style: hourStyle),
          Image.asset('images/$image.png', width: 36, height: 36),
          Text("$temperature°", style: hourTemperatureStyle)
        ],
      ),
    );
  }
}
