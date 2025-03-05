import 'package:flutter/material.dart';
import 'package:weather_app/service/weather_service.dart';
import '../models/weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  
  WeatherModel? _weather;
  List<WeatherModel> _fiveDayForecast = [];
  bool _isLoading = false;

  WeatherModel? get weather => _weather;
  List<WeatherModel> get fiveDayForecast => _fiveDayForecast;
  bool get isLoading => _isLoading;

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    notifyListeners();

    try {
      _weather = await _weatherService.fetchWeather(city);
    } catch (e) {
      _weather = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchFiveDayForecast(String city) async {
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
