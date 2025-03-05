
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  static const String baseUrl = "https://api.openweathermap.org/data/2.5";
  static const String apiKey = "dbe5809c77179ecb5b4365ac169822a2";

  Future<WeatherModel> fetchWeather(String city) async {
    final response = await http.get(Uri.parse("$baseUrl/weather?q=$city&appid=$apiKey"));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch weather data");
    }
  }

  Future<List<WeatherModel>> fetchFiveDayForecast(String city) async {
    final response = await http.get(Uri.parse("$baseUrl/forecast?q=$city&appid=$apiKey"));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> forecastList = data['list'];

      // Extract only one entry per day (choosing midday forecasts)
      List<WeatherModel> dailyForecasts = forecastList
          .where((entry) => entry['dt_txt'].contains("12:00:00")) // Midday filter
          .map((json) => WeatherModel.fromJson(json))
          .toList();

      return dailyForecasts;
    } else {
      throw Exception("Failed to fetch 5-day forecast data");
    }
  }
}
