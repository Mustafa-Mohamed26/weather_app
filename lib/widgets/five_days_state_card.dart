import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FiveDaysStateCard extends StatelessWidget {
  final DateTime date;
  final String icon;
  final String weatherMain;
  final String weatherDescription;
  final double temperature;

  const FiveDaysStateCard({
    super.key,
    required this.date,
    required this.icon,
    required this.weatherMain,
    required this.weatherDescription,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Image.network(
          "https://openweathermap.org/img/w/$icon.png",
          width: 50,
          height: 50,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.image_not_supported,
            size: 50,
            color: Colors.grey,
          ),
        ),
        title: Text(
          DateFormat('EEEE, MMM d').format(date),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("$weatherMain - $weatherDescription"),
        trailing: Text(
          "${temperature.toStringAsFixed(1)}°C",
          style: const TextStyle(fontSize: 32),
        ),
      ),
    );
  }
}
