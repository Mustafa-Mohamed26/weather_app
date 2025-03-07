import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/db_helper.dart';
import 'package:weather_app/core/service/weather_service.dart';
import '../models/weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();

  WeatherModel? _weather;
  bool _isLoading = false;

  WeatherModel? get weather => _weather;
  bool get isLoading => _isLoading;

  WeatherProvider() {
    _loadWeatherFromDB(); // Load stored weather on startup
  }

  Future<void> _loadWeatherFromDB() async {
    _weather = await WeatherDatabase.instance.getWeather();
    notifyListeners();
  }
  
  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    notifyListeners();

    try {
      _weather = await _weatherService.fetchWeather(city);
      // await WeatherDatabase.instance.deleteWeather(); // Clear old data
      // await WeatherDatabase.instance.insertWeather(_weather!); // Save new data
    } catch (e) {
      _weather = await WeatherDatabase.instance.getWeather(); // Load from database if fetch fails
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
