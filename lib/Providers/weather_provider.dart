import 'package:flutter/material.dart';
import 'package:weather_app/core/service/weather_service.dart';
import '../models/weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();

  WeatherModel? _weather;
  bool _isLoading = false;

  WeatherModel? get weather => _weather;
  bool get isLoading => _isLoading;

  WeatherProvider();

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    notifyListeners();

    try {
      _weather = await _weatherService.fetchWeather(city);
    } catch (e) {
      _weather = null; // Clear weather data on failure
    }

    _isLoading = false;
    notifyListeners();
  }

  
}
