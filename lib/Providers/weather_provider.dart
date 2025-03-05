import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
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

  /// Fetches current weather data for the given city.
  ///
  /// Sets [_isLoading] to true before the request, and false after.
  ///
  /// Calls [notifyListeners] at the beginning and end of the function.
  ///
  /// If the request fails, sets [_weather] to null.
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

  /// Fetches five-day forecast data for the given city.
  //
  /// Sets [_isLoading] to true before the request, and false after.
  //
  /// Calls [notifyListeners] at the beginning and end of the function.
  //
  /// If the request fails, sets [_fiveDayForecast] to an empty list.
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

  // 🔹 Fetch weather by GPS
  Future<void> getCurrentLocationWeather() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        print("Location permission denied.");
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        String cityName = placemarks.first.locality ?? "Unknown";
        await fetchWeather(cityName);
      }
    } catch (e) {
      print("Error getting location: $e");
    }
  }
}
