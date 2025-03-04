import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Pages/home_page.dart';
import 'package:weather_app/Providers/weather_provider.dart';
import 'package:weather_app/service/weather_service.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherProvider(WeatherService()),
      child: MaterialApp(
        title: "Weather App",
        home: HomePage(),
      ),
    );
  }
}
