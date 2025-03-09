// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Providers/weather_five_days_forecast_provider.dart';
import 'package:weather_app/Providers/weather_today_forecast_provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/widgets/custom_app_bar.dart';
import 'package:weather_app/widgets/five_days_state_card.dart';
import 'package:weather_app/widgets/today_forecast_card.dart';

class ForecastReportScreen extends StatefulWidget {
  const ForecastReportScreen({super.key});

  @override
  _ForecastReportScreenState createState() => _ForecastReportScreenState();
}

class _ForecastReportScreenState extends State<ForecastReportScreen> {
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
    final weatherFiveDaysForCastProvider =
        context.watch<WeatherFiveDaysForCastProvider>();
    final todayForecastProvider = context.watch<TodayForecastProvider>();

    final fiveDayForecast = weatherFiveDaysForCastProvider.fiveDayForecast;
    final todayForecast = todayForecastProvider.todayForecast;

    return Scaffold(
      appBar: CustomAppBar(
        title: "Forecast report",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Today's Forecast",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                : const Center(
                    child: Text("No forecast data available"),
                  ),
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                              return FiveDaysStateCard(
                                date: forecast.date,
                                icon: forecast.icon,
                                weatherMain: forecast.weatherMain,
                                weatherDescription: forecast.weatherDescription,
                                temperature: forecast.temperature,
                              );
                            },
                          )
                        : const Center(
                            child: Text("No forecast data available")),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
