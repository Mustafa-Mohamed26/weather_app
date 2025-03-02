import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final TextEditingController _controller = TextEditingController();
  String country = "Egypt";
  String temperature = "-";
  String weather = "-";
  String humidity = "-";
  IconData weatherIcon = Icons.wb_sunny;
  String apiKey = "dbe5809c77179ecb5b4365ac169822a2";

  List<Map<String, String>> countries = [
    {"name": "Egypt", "flag": "🇪🇬"},
    {"name": "United States", "flag": "🇺🇸"},
    {"name": "United Kingdom", "flag": "🇬🇧"},
    {"name": "France", "flag": "🇫🇷"},
    {"name": "Germany", "flag": "🇩🇪"},
    {"name": "Japan", "flag": "🇯🇵"},
    {"name": "India", "flag": "🇮🇳"},
  ];

  Future<void> fetchWeather(String country) async {
    final url =
        "https://api.openweathermap.org/data/2.5/weather?q=$country&appid=$apiKey&units=metric";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        temperature = "${data['main']['temp']} °C";
        weather = data['weather'][0]['main'];
        humidity = "${data['main']['humidity']}%";
        weatherIcon = getWeatherIcon(weather);
      });
    } else {
      setState(() {
        temperature = "Not Found";
        weather = "-";
        humidity = "-";
        weatherIcon = Icons.help_outline;
      });
    }
  }

  IconData getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case "clear":
        return Icons.wb_sunny;
      case "clouds":
        return Icons.cloud;
      case "rain":
        return Icons.beach_access;
      case "thunderstorm":
        return Icons.flash_on;
      case "snow":
        return Icons.ac_unit;
      case "mist":
        return Icons.blur_on;
      default:
        return Icons.help_outline;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather(country);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Weather App")),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: "Enter Country",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    country = _controller.text;
                  });
                  fetchWeather(country);
                },
                child: Text("Get Weather"),
              ),
              SizedBox(height: 20),
              Text("Country: $country", style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Icon(weatherIcon, size: 100, color: Colors.blue),
              SizedBox(height: 10),
              Text("Temperature: $temperature", style: TextStyle(fontSize: 20)),
              Text("Condition: $weather", style: TextStyle(fontSize: 20)),
              Text("Humidity: $humidity", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: countries.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text(countries[index]['flag']!,
                          style: TextStyle(fontSize: 24)),
                      title: Text(countries[index]['name']!,
                          style: TextStyle(fontSize: 18)),
                      onTap: () {
                        setState(() {
                          country = countries[index]['name']!;
                        });
                        fetchWeather(country);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
