import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Providers/weather_provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  Provider.of<WeatherProvider>(context, listen: false)
                      .fetchCurrentWeather(value);
                }
              },
            ),
            SizedBox(height: 20),
            Consumer<WeatherProvider>(
              builder: (context, weatherProvider, child) {
                if (weatherProvider.isLoading) {
                  return CircularProgressIndicator();
                } else if (weatherProvider.errorMessage != null) {
                  return Text(
                    'Error: ${weatherProvider.errorMessage}',
                    style: TextStyle(color: Colors.red),
                  );
                } else if (weatherProvider.currentWeatherData != null) {
                  return Column(
                    children: [
                      Text(
                        'City: ${weatherProvider.currentWeatherData?.name ?? 'Unknown'}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Temperature: ${((weatherProvider.currentWeatherData?.mainWeather?.temp ?? 0) - 273.15).round()}°C',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Weather: ${weatherProvider.currentWeatherData?.weather?[0].description ?? 'Unknown'}',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Wind Speed: ${weatherProvider.currentWeatherData?.wind?.speed?.toString() ?? '0'} m/s',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  );
                } else {
                  return Text(
                      'Enter a city name to get the weather information.');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
