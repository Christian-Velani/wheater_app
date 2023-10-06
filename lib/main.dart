// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(WheaterApp());
}

class WheaterApp extends StatelessWidget {
  Future<Map<String, dynamic>?> loadWeatherData(
      {required BuildContext context}) async {
    var queryParams = {
      "key": "81134a81c96740db958105843232808",
      "lang": "pt",
    };
    // Solicita permissão de localização
    LocationPermission permission = await Geolocator.requestPermission();

    // Se a permissão for negada, mostra uma mensagem de erro e fecha o aplicativo
    if (permission == LocationPermission.denied) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Erro'),
          content: Text('O usuário negou a permissão de localização.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                SystemNavigator.pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      return null;
    }
    Position location = await Geolocator.getCurrentPosition();
    print(location);

    queryParams['q'] = "${location.latitude},${location.longitude}";

    var url = Uri.https("api.weatherapi.com", "/v1/forecast.json", queryParams);

    var response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return json;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF255AF4),
        body: FutureBuilder<Map<String, dynamic>?>(
            future: loadWeatherData(context: context),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              var dados = snapshot.data!;
              var clima = ClimaAPI(
                  dados['current']['humidity'],
                  dados['current']['condition']['icon'],
                  dados['location']['name'],
                  dados['current']['temp_c'],
                  dados['current']['wind_kph'],
                  dados['current']['feelslike_c'],
                  dados['forecast']['forecastday'][0]['hour'],
                  dados['current']['condition']['text'],
                  DateTime.parse(dados['location']['localtime']).hour);

              return SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(clima.name, style: titleStyle),
                    Column(
                      children: [
                        Container(
                          width: 96,
                          height: 96,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 24),
                          child: Image.network('https:${clima.icone}'),
                        ),
                        Text(clima.climanome, style: titleStyle),
                        Text("${clima.temp_c}°C", style: temperatureStyle),
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
                              Text("${clima.humidity}%", style: iconStyle),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset('images/wind.png'),
                              Text("Wind", style: iconStyle),
                              Text("${clima.wind_kph}km/h", style: iconStyle),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset('images/feels_like.png'),
                              Text("Feels Like", style: iconStyle),
                              Text("${clima.feelslike_c}°C", style: iconStyle),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      // margin: EdgeInsets.only(top: 80),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: clima.forecast_hours_late.length,
                          itemBuilder: (context, index) {
                            return ForecastDay(
                              clima.forecast_hours_late[index]['time'],
                              clima.forecast_hours_late[index]['condition']
                                  ['icon'],
                              clima.forecast_hours_late[index]['temp_c'],
                            );
                          }),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class ForecastDay extends StatelessWidget {
  String time;
  String image;
  double temperature;
  String? hour;

  ForecastDay(
    this.time,
    this.image,
    this.temperature,
  ) {
    var data = DateTime.parse(time);
    hour = data.hour.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 39),
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(hour!, style: hourStyle),
          Image.network('https:${image}', width: 36, height: 36),
          Text("$temperature°", style: hourTemperatureStyle)
        ],
      ),
    );
  }
}

class ClimaAPI {
  String name;
  double temp_c;
  String icone;
  double wind_kph;
  int humidity;
  double feelslike_c;
  List forecast_hours;
  String climanome;
  int hour;
  List forecast_hours_late = [];

  ClimaAPI(this.humidity, this.icone, this.name, this.temp_c, this.wind_kph,
      this.feelslike_c, this.forecast_hours, this.climanome, this.hour) {
    for (int i = 0; i < forecast_hours.length; i++) {
      if (DateTime.parse(forecast_hours[i]['time']).hour > hour) {
        forecast_hours_late.add(forecast_hours[i]);
      }
    }
  }
}
