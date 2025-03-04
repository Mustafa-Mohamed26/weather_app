import 'package:weather_app/api/api_repo.dart';
import 'package:weather_app/models/current_weather_data.dart';
import 'package:weather_app/models/five_days_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  String? city;

  WeatherService({this.city});

  String baseUrl = "https://api.openweathermap.org/data/2.5";
  String apiKey = "dbe5809c77179ecb5b4365ac169822a2";

  /// Fetches current weather data for a given city.
  ///
  /// The city is given as part of the [WeatherService] constructor.
  ///
  /// Returns a [CurrentWeatherData] object if the request is successful.
  /// Otherwise, throws an exception.
  Future<CurrentWeatherData?> fetchCurrentWeather() async {
    final url = "$baseUrl/weather?q=$city&appid=$apiKey";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return CurrentWeatherData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load current weather data');
    }
  }

  /// Fetches the five days forecast data for a given city.
  ///
  /// The city is given as part of the [WeatherService] constructor.
  ///
  /// Returns a [FiveDaysData] object if the request is successful.
  /// Otherwise, throws an exception.
  Future<FiveDaysData?> fetchFiveDaysForecast() async {
    final url = '$baseUrl/forecast?q=$city&lang=en&appid=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return FiveDaysData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load five days forecast data');
    }
  }
}
