import 'package:flutter/material.dart';
import 'package:weather_app/core/service/weather_service.dart';
import 'package:weather_app/models/weather_forecast_model.dart';


class WeatherFiveDaysForCastProvider with ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<WeatherForecast> _fiveDayForecast = [];
  List<WeatherForecast> get fiveDayForecast => _fiveDayForecast;

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    notifyListeners();

    try {
      _fiveDayForecast = await _weatherService.fetchFiveDayForecast(city);
    } catch (e) {
      _fiveDayForecast = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
