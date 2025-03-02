// ignore_for_file: camel_case_types

class MainWeather {
  double? temp,
      fells_like,
      temp_min,
      temp_max,
      pressure,
      humidity,
      sea_level,
      grnd_level;
  MainWeather(
      {this.temp,
      this.fells_like,
      this.temp_min,
      this.temp_max,
      this.pressure,
      this.humidity,
      this.sea_level,
      this.grnd_level});

  factory MainWeather.fromJson(Map<String, dynamic> json) {
    return MainWeather(
      temp: json['temp'],
      fells_like: json['fells_like'],
      temp_min: json['temp_min'],
      temp_max: json['temp_max'],
      pressure: json['pressure'],
      humidity: json['humidity'],
      sea_level: json['sea_level'],
      grnd_level: json['grnd_level'],
    );
  }

  /// Converts the MainWeather instance into a JSON map where each key maps
  /// to the corresponding property of the weather data. This map can be used
  /// for serialization purposes.

  Map<String, dynamic> toJson() {
    return {
      'temp': temp,
      'fells_like': fells_like,
      'temp_min': temp_min,
      'temp_max': temp_max,
      'pressure': pressure,
      'humidity': humidity,
      'sea_level': sea_level,
      'grnd_level': grnd_level,
    };
  }
}
