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
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side: Day name + Date
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('EEEE').format(date), // Day name
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DateFormat('MMM d').format(date), // Month and day
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),

            // Center: Temperature
            Text(
              "${temperature.toStringAsFixed(1)}°C",
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),

            // Right side: Bigger Weather Icon
            Image.network(
              "https://openweathermap.org/img/w/$icon.png",
              width: 80, // Increased width
              height: 80, // Increased height
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.image_not_supported,
                size: 80, // Match icon size
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
