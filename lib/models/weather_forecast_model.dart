// This file contains the model class for the weather forecast data.
// The class is used to represent a single forecast entry in the 5-day weather forecast.
class WeatherForecast {
  final DateTime date;
  final double temperature;
  final int humidity;
  final String weatherMain;
  final String weatherDescription;
  final String icon;

  WeatherForecast({
    required this.date,
    required this.temperature,
    required this.humidity,
    required this.weatherMain,
    required this.weatherDescription,
    required this.icon,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      date: DateTime.parse(json["dt_txt"]), // Convert string to DateTime
      temperature: (json["main"]["temp"] - 273.15), // Convert from Kelvin to Celsius
      humidity: json["main"]["humidity"],
      weatherMain: json["weather"][0]["main"],
      weatherDescription: json["weather"][0]["description"],
      icon: json["weather"][0]["icon"],
    );
  }
}
