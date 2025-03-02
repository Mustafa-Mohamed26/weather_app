import 'package:weather_app/models/clouds.dart';
import 'package:weather_app/models/coord.dart';
import 'package:weather_app/models/main_weather.dart';
import 'package:weather_app/models/sys.dart';
import 'package:weather_app/models/weather.dart';

class CurrentWeatherData {
  Coord? coord;
  List<Weather>? weather;
  String? base;
  MainWeather? mainWeather;
  int? visibility;
  Clouds? clouds;
  int? dt;
  Sys? sys;
  int? timezone;
  int? id;
  String? name;
  int? cod;

  CurrentWeatherData(
      {this.coord,
      this.weather,
      this.base,
      this.mainWeather,
      this.visibility,
      this.clouds,
      this.dt,
      this.sys,
      this.timezone,
      this.id,
      this.name,
      this.cod});

  /// Converts the current weather data to a JSON-encodable map.
  ///
  /// This can be used to send the current weather data to a server, or to
  /// convert it to a JSON string for storage or display.
  ///
  /// The keys of the returned map are the same as the fields in the
  /// [CurrentWeatherData] constructor, and the values are the same as the
  /// values of the corresponding fields.
  Map<String, dynamic> toJson() {
    return {
      'coord': coord,
      'weather': weather,
      'base': base,
      'main': mainWeather,
      'visibility': visibility,
      'clouds': clouds,
      'dt': dt,
      'sys': sys,
      'timezone': timezone,
      'id': id,
      'name': name,
      'cod': cod,
    };
  }

  factory CurrentWeatherData.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherData(
      coord: json['coord'] != null ? Coord.fromJson(json['coord']) : null,
      weather: json['weather'] != null
          ? (json['weather'] as List).map((i) => Weather.fromJson(i)).toList()
          : null,
      base: json['base'],
      mainWeather:
          json['main'] != null ? MainWeather.fromJson(json['main']) : null,
      visibility: json['visibility'],
      clouds: json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null,
      dt: json['dt'],
      sys: json['sys'] != null ? Sys.fromJson(json['sys']) : null,
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
    );
  }
}
