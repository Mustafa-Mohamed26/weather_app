import 'dart:collection';

import 'package:flutter/material.dart';

class TodayForecastCard extends StatelessWidget {
  final String time;
  final String icon;
  final String weatherMain;
  final double temperature;
  final Color backgroundColor;

  const TodayForecastCard({
    super.key,
    required this.time,
    required this.icon,
    required this.weatherMain,
    required this.temperature,
    this.backgroundColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160, // Reduced width
      height: 80, // Reduced height
      margin: const EdgeInsets.symmetric(horizontal: 6), // Adjusted margin
      padding: const EdgeInsets.all(8), // Reduced padding
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.network(
            "https://openweathermap.org/img/wn/$icon@2x.png",
            width: 70, // Smaller icon
            height: 60,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 4), // Reduced spacing
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                time,
                style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),           ),
              const SizedBox(height: 2),
              Text(
                "${temperature.toStringAsFixed(1)}°C",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
