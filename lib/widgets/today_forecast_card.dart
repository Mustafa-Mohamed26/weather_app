import 'package:flutter/material.dart';

class TodayForecastCard extends StatelessWidget {
  final String time;
  final String icon;
  final String weatherMain;
  final double temperature;

  const TodayForecastCard({
    super.key,
    required this.time,
    required this.icon,
    required this.weatherMain,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Image.network(
          "https://openweathermap.org/img/wn/$icon@2x.png",
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text("$time - $weatherMain"),
        subtitle: Text("${temperature.toStringAsFixed(1)}°C"),
      ),
    );
  }
}
