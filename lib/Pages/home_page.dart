import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Weather App")),
      body: Center(
        child: weatherProvider.isLoading
            ? CircularProgressIndicator()
            : weatherProvider.weather == null
                ? Text("Enter a city to get weather info")
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        weatherProvider.weather?.city ?? "Unknown City",
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        "${weatherProvider.weather?.temperature?.toStringAsFixed(1) ?? '--'}°C",
                        style: TextStyle(fontSize: 50),
                      ),
                      Text(weatherProvider.weather?.description ?? "No description"),
                      if (weatherProvider.weather?.icon != null)
                        Image.network(
                          "https://openweathermap.org/img/wn/${weatherProvider.weather!.icon}@2x.png",
                        ),
                      Text("Humidity: ${weatherProvider.weather?.humidity ?? '--'}%"),
                      Text("Wind: ${weatherProvider.weather?.windSpeed ?? '--'} m/s"),
                    ],
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          weatherProvider.fetchWeather("Cairo");
        },
        child: Icon(Icons.search),
      ),
    );
  }
}
