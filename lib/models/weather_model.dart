class WeatherModel {
  final String city;
  final double temperature;
  final String description;
  final String icon;
  final int humidity;
  final double windSpeed;
  final int sunrise;
  final int sunset;

  WeatherModel({
    required this.city,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json["name"],
      temperature: json["main"]["temp"] - 273.15, // Convert from Kelvin to Celsius
      description: json["weather"][0]["description"],
      icon: json["weather"][0]["icon"],
      humidity: json["main"]["humidity"],
      windSpeed: json["wind"]["speed"].toDouble(),
      sunrise: json["sys"]["sunrise"],
      sunset: json["sys"]["sunset"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'city': city,
      'temperature': temperature,
      'description': description,
      'icon': icon,
      'humidity': humidity,
      'windSpeed': windSpeed,
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }
}
