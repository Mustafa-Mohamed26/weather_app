import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/widgets/current_state_card.dart';
import 'package:weather_app/widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the WeatherProvider
    final weatherProvider = Provider.of<WeatherProvider>(context);

    // Get the current date and format it
    String formattedDate = DateFormat('MMMM d, yyyy').format(DateTime.now());

    // Ensure weather data is available
    final weather = weatherProvider.weather;
    final String city = weather?.city ?? "Unknown City";
    final String? iconCode = weather?.icon;

    // Construct weather icon URL safely
    final String weatherIconUrl = iconCode != null
        ? "https://openweathermap.org/img/wn/$iconCode@2x.png"
        : "";

    return Scaffold(
      appBar: const CustomAppBar(title: "Current Weather"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              city,
              style: const TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              formattedDate,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),

            // Weather Icon (Only display if URL is available)
            if (iconCode != null)
              Center(
                child: Image.network(
                  weatherIconUrl,
                  width: 200,
                  height: 150,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error, size: 100, color: Colors.red),
                ),
              ),

            const SizedBox(height: 20),

            // Row of CurrentStateCards with dynamic values
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CurrentStateCard(
                    title: "Temp",
                    value: weather?.temperature != null
                        ? "${weather!.temperature.toInt()}°C"
                        : "--",
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CurrentStateCard(
                    title: "Wind",
                    value: weather?.windSpeed != null
                        ? "${weather!.windSpeed} km/h"
                        : "--",
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CurrentStateCard(
                    title: "Humidity",
                    value: weather?.humidity != null
                        ? "${weather!.humidity}%"
                        : "--",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
