import 'package:flutter/material.dart';
import 'package:weather_app/core/service/weather_service.dart';
import 'package:weather_app/models/weather_forecast_model.dart';

class TodayForecastProvider with ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  List<WeatherForecast> _todayForecast = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<WeatherForecast> get todayForecast => _todayForecast;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchTodayForecast(String city) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); // Notify UI to show loading state

    try {
      _todayForecast = await _weatherService.fetchTodayForecast(city);
    } catch (e) {
      _errorMessage = "Failed to load today's forecast: ${e.toString()}";
    }

    _isLoading = false;
    notifyListeners(); // Ensure UI updates after error/loading state
  }
}
