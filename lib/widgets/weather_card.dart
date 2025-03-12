import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Providers/weather_provider.dart';

class WeatherCard extends StatefulWidget {
  final String city;

  const WeatherCard({super.key, required this.city});

  @override
  _WeatherCardState createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    await weatherProvider.fetchWeather(widget.city);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final weather = weatherProvider.weather;

    if (_isLoading || weather == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final String cityName = weather.city ?? "Unknown City";
    final String? iconCode = weather.icon;
    final String weatherIconUrl = iconCode != null
        ? "https://openweathermap.org/img/w/$iconCode.png"
        : "";

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              cityName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            if (iconCode != null)
              Image.network(
                weatherIconUrl,
                width: 60,
                height: 60,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error, size: 50, color: Colors.red),
              ),
            const SizedBox(height: 5),
            Text(
              "${weather.temperature}°C",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              weather.description ?? "",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
