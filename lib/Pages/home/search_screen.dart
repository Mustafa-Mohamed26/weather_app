import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Providers/weather_provider.dart';
import 'package:weather_app/widgets/current_state_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _searchedCity;

  final List<String> randomCities = ["New York", "London", "Tokyo", "Sydney"];

  @override
  void initState() {
    super.initState();
    // Use Future.delayed to defer the call to fetch weather data
    Future.delayed(Duration.zero, _fetchRandomCitiesWeather);
  }

  Future<void> _fetchRandomCitiesWeather() async {
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    for (String city in randomCities) {
      await weatherProvider.fetchWeather(city);
    }
  }

  Future<void> _searchCity(String city) async {
    if (city.isEmpty) return;

    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    await weatherProvider.fetchWeather(city);
    setState(() {
      _searchedCity = city;
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = context.watch<WeatherProvider>();
    final weather = weatherProvider.weather;

    // Get the current date and format it
    String formattedDate = DateFormat('MMMM d, yyyy').format(DateTime.now());

    final String city = weather?.city ?? _searchedCity ?? "Unknown City";
    final String? iconCode = weather?.icon;

    // Construct weather icon URL safely
    final String weatherIconUrl = iconCode != null
        ? "https://openweathermap.org/img/wn/$iconCode@2x.png"
        : "";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Weather"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Enter city name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _searchCity(_searchController.text.trim());
                  },
                ),
              ),
              onSubmitted: (value) {
                _searchCity(value.trim());
              },
            ),
            const SizedBox(height: 20),

            // GridView for Random Cities
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 cards per row
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 2, // Adjust card height
                ),
                itemCount: randomCities.length,
                itemBuilder: (context, index) {
                  final city = randomCities[index];
                  final cityWeather = weatherProvider.weather;

                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            city,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (cityWeather != null)
                            Column(
                              children: [
                                Text(
                                  "Temp: ${cityWeather.temperature?.toInt() ?? '--'}°C",
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Wind: ${cityWeather.windSpeed ?? '--'} km/h",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            )
                          else
                            const Text(
                              "No data",
                              style: TextStyle(color: Colors.red),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Weather Data Display
            if (weatherProvider.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (weather != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    city,
                    style: const TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    formattedDate,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),

                  // Weather Icon
                  if (iconCode != null)
                    Image.network(
                      weatherIconUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, size: 100, color: Colors.red),
                    ),
                  const SizedBox(height: 20),

                  // Current Weather Details
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: CurrentStateCard(
                            title: "Temp",
                            value: weather.temperature != null
                                ? "${weather.temperature!.toInt()}°C"
                                : "--",
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CurrentStateCard(
                            title: "Wind",
                            value: weather.windSpeed != null
                                ? "${weather.windSpeed} km/h"
                                : "--",
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CurrentStateCard(
                            title: "Humidity",
                            value: weather.humidity != null
                                ? "${weather.humidity}%"
                                : "--",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            else
              const Center(
                child: Text(
                  "No data available. Please search for a city.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
