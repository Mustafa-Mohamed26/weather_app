import 'package:flutter/material.dart';
import 'package:weather_app/models/current_weather_data.dart';
import 'package:weather_app/models/five_days_data.dart';
import 'package:weather_app/service/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  CurrentWeatherData? _currentWeatherData;
  FiveDaysData? _fiveDaysData;
  bool _isLoading = false;
  String? _errorMessage;

  CurrentWeatherData? get currentWeatherData => _currentWeatherData;
  FiveDaysData? get fiveDaysData => _fiveDaysData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final WeatherService _weatherService;

  WeatherProvider(this._weatherService);

  /// Fetches the current weather data and updates the provider state.
  ///
  /// This method sets the loading state to true and attempts to fetch
  /// the current weather data using the [_weatherService]. If successful,
  /// the [_currentWeatherData] is updated. If an error occurs, the
  /// [_errorMessage] is set with the error description. After the
  /// operation, the loading state is set to false and listeners are notified.
  Future<void> fetchCurrentWeather(String city) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentWeatherData = await _weatherService.fetchCurrentWeather(city);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Fetches the five days forecast data and updates the provider state.
  ///
  /// This method sets the loading state to true and attempts to fetch
  /// the five days forecast data using the [_weatherService]. If successful,
  /// the [_fiveDaysData] is updated. If an error occurs, the
  /// [_errorMessage] is set with the error description. After the
  /// operation, the loading state is set to false and listeners are notified.
  Future<void> fetchFiveDaysForecast(String city) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _fiveDaysData = await _weatherService.fetchFiveDaysForecast(city);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
