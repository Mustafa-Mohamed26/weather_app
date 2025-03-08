import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/models/weather_forecast_model.dart';
import 'dart:convert';

import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  static const String baseUrl = "https://api.openweathermap.org/data/2.5";
  static const String apiKey = "dbe5809c77179ecb5b4365ac169822a2";

  Future<WeatherModel> fetchWeather(String city) async {
    final response =
        await http.get(Uri.parse("$baseUrl/weather?q=$city&appid=$apiKey"));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch weather data");
    }
  }

  Future<List<WeatherForecast>> fetchFiveDayForecast(String city) async {
    final url = Uri.parse("$baseUrl/forecast?q=$city&appid=$apiKey");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> list = data["list"];

        return list.map((item) => WeatherForecast.fromJson(item)).toList();
      } else {
        throw Exception("Failed to load weather data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<WeatherForecast>> fetchTodayForecast(String city) async {
    final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> list = data["list"];

        // Get current UTC time
        DateTime nowUtc = DateTime.now().toUtc();
        DateTime nextDayUtc = nowUtc.add(Duration(hours: 24));

        // Get the next 24-hour forecasts 
        List<WeatherForecast> todayForecasts = list
            .where((item) {
              DateTime forecastTime = DateTime.parse(item["dt_txt"]).toUtc();
              return forecastTime.isAfter(nowUtc) &&
                  forecastTime.isBefore(nextDayUtc);
            })
            .map((item) => WeatherForecast.fromJson(item))
            .toList();

        return todayForecasts;
      } else {
        throw Exception("Failed to load weather data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
