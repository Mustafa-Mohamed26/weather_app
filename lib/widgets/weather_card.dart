import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final String city;
  final String icon;
  final int temperature;
  final String description;

  const WeatherCard({
    super.key,
    required this.city,
    required this.icon,
    required this.temperature,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              city,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            if (icon.isNotEmpty)
              Image.network(
                "https://openweathermap.org/img/w/$icon.png",
                width: 60,
                height: 60,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 50, color: Colors.red),
              ),
            const SizedBox(height: 5),
            Text(
              "$temperature°C",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              description,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}