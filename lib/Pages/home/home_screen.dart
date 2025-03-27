// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Providers/weather_five_days_forecast_provider.dart';
import 'package:weather_app/Providers/weather_today_forecast_provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/widgets/current_state_card.dart';
import 'package:weather_app/widgets/five_days_state_card.dart';
import 'package:weather_app/widgets/today_forecast_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final weatherProvider =
          Provider.of<WeatherProvider>(context, listen: false);
      final weatherFiveDaysForCastProvider =
          Provider.of<WeatherFiveDaysForCastProvider>(context, listen: false);
      final todayForecastProvider =
          Provider.of<TodayForecastProvider>(context, listen: false);

      weatherProvider.fetchWeather("Alexandria");
      weatherFiveDaysForCastProvider.fetchWeather("Alexandria");
      todayForecastProvider.fetchTodayForecast("Alexandria");
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the WeatherProviderd
    final weatherProvider = context.watch<WeatherProvider>();
    final todayForecastProvider = context.watch<TodayForecastProvider>();

    // Ensure weather data is available
    final weather = weatherProvider.weather;
    final todayForecast = todayForecastProvider.todayForecast;

    // Get the current date and format it
    String formattedDate = DateFormat('MMMM d, yyyy').format(DateTime.now());

    final String city = weather?.city ?? "Unknown City";
    final String? iconCode = weather?.icon;

    // Construct weather icon URL safely
    final String weatherIconUrl = iconCode != null
        ? "https://openweathermap.org/img/wn/$iconCode@2x.png"
        : "";

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 8), // Consistent padding
        child: Container(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                city,
                style: const TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                formattedDate,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
          
              // Weather Icon (Covers the page)
              if (iconCode != null)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10), // Consistent padding
                    child: Center(
                      child: Image.network(
                        weatherIconUrl,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error, size: 100, color: Colors.red),
                      ),
                    ),
                  ),
                ),
          
              const SizedBox(height: 20),
          
              // Row of CurrentStateCards with equal padding
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10), // Equal padding
                child: Row(
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
              ),
          
              const SizedBox(height: 20),
          
              // Today's Forecast Section
              Row(
                children: [
                  const Text(
                    "Today's Forecast",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
          
              todayForecast.isNotEmpty
                  ? SizedBox(
                      height: 110, // Adjust height based on your card size
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16), // Consistent padding
                        itemCount: todayForecast.length,
                        itemBuilder: (context, index) {
                          final forecast = todayForecast[index];
                          final isFirst =
                              index == 0; // Check if it's the first item
          
                          return Padding(
                            padding:
                                const EdgeInsets.only(right: 10), // Equal spacing
                            child: TodayForecastCard(
                              time: DateFormat('hh:mm a').format(forecast.date),
                              icon: forecast.icon,
                              weatherMain: forecast.weatherMain,
                              temperature: forecast.temperature,
                              backgroundColor:
                                  isFirst ? Colors.orange : Colors.blueAccent,
                            ),
                          );
                        },
                      ),
                    )
                  : const Center(child: Text("No forecast data available")),
            ],
          ),
        ),
      ),
    );
  }
}
