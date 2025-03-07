import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Providers/weather_five_days_forcast_povider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/widgets/current_state_card.dart';
import 'package:weather_app/widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the WeatherProvider
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final weatherFiveDaysForCastProvider =
        Provider.of<WeatherFiveDaysForCastProvider>(context);

    // Get the current date and format it
    String formattedDate = DateFormat('MMMM d, yyyy').format(DateTime.now());

    // Ensure weather data is available
    final weather = weatherProvider.weather;
    final fiveDayForecast = weatherFiveDaysForCastProvider.fiveDayForecast;

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

            const SizedBox(height: 20),

            // Five-Day Forecast Section
            const Text(
              "5-Day Forecast",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: fiveDayForecast.isNotEmpty
                  ? ListView.builder(
                      itemCount: fiveDayForecast.length,
                      itemBuilder: (context, index) {
                        final forecast = fiveDayForecast[index];

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            leading: Image.network(
                              "https://openweathermap.org/img/w/${forecast.icon}.png",
                              width: 50,
                              height: 50,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.image_not_supported,
                                      size: 50, color: Colors.grey),
                            ),
                            title: Text(
                              DateFormat('EEEE, MMM d').format(forecast.date),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                                "${forecast.weatherMain} - ${forecast.weatherDescription}"),
                            trailing: Text(
                              "${forecast.temperature.toStringAsFixed(1)}°C",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(child: Text("No forecast data available")),
            ),
          ],
        ),
      ),
    );
  }
}
