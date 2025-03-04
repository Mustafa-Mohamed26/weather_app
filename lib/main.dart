import 'package:flutter/material.dart';
import 'package:weather_app/Pages/home_page.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Weather App",
      home: HomePage(),
    );
  }
}
