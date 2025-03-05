
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  static const String baseUrl = "https://api.openweathermap.org/data/2.5";
  static const String apiKey = "dbe5809c77179ecb5b4365ac169822a2";

  /// Fetches current weather data for a given city.
  ///
  /// Throws an [Exception] if the request fails.
  ///
  /// The [city] parameter should be a string containing the name of the city,
  /// e.g. "London" or "New York".
  Future<WeatherModel> fetchWeather(String city) async {
    final response = await http.get(Uri.parse("$baseUrl/weather?q=$city&appid=$apiKey"));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch weather data");
    }
  }


  /// Fetches a 5-day weather forecast for a given city.
  ///
  /// This method retrieves weather forecast data from the OpenWeatherMap API,
  /// filtering for midday entries to provide a single forecast per day.
  ///
  /// The [city] parameter should be a string containing the name of the city,
  /// e.g. "London" or "New York".
  ///
  /// Returns a [Future] that resolves to a list of [WeatherModel] objects,
  /// each representing a daily forecast.
  ///
  /// Throws an [Exception] if the request fails.

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
