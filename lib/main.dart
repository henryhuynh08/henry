import 'package:capstone/bulblight/readlight.dart';
import 'package:capstone/rbg_led/rbg_led.dart';
import 'package:capstone/temperature/weatherforecast.dart';
import 'package:flutter/material.dart';
import 'package:capstone/bulblight/mainlight.dart';
import 'package:capstone/temperature/roomTemperature.dart';
import 'package:capstone/homepage/homepage.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => const CapstoneProj(),
      '/mainlight': (context) => const MainLight(),
      '/readlight': (context) => const ReadingLight(),
      '/roomtemperature': (context) => const RoomTemperature(),
      '/weatherforecast': (context) => const WeatherUpdate(),
      '/rgbLed': (context) => const RGBLed(),
    },
  ));
}
