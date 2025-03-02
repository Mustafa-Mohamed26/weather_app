import 'package:weather_app/api/api_repo.dart';
import 'package:weather_app/models/current_weather_data.dart';
import 'package:weather_app/models/five_days_data.dart';

class WeatherService {
  String? city;

  WeatherService({this.city});

  String baseUrl = "https://api.openweathermap.org/data/2.5";
  String apiKey = "appid=dbe5809c77179ecb5b4365ac169822a2";

/// Fetches current weather data for the specified city.
/// 
/// This method constructs a request URL using the base URL and API key, then
/// retrieves the current weather data from the API. The data is processed and
/// returned as a `CurrentWeatherData` object through the `onSuccess` callback.
/// 
/// - [beforeSend]: A callback function that is invoked just before the request
///   is sent. Can be used for showing loading indicators.
/// - [onSuccess]: A callback function that is invoked when the request is
///   successful. Receives a `CurrentWeatherData` object containing the weather
///   information.
/// - [onError]: A callback function that is invoked if the request fails.
///   Receives an error object with details about the failure.

  void getCurrentWeatherData({
    Function()? beforeSend,
    Function(CurrentWeatherData currentWeatherData)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    final url = "$baseUrl/weather?q=$city&$apiKey";
    ApiRepository(url: url, payload: null).getData(
      beforeSend: () => beforeSend!(),
      onSuccess: (data) => onSuccess!(CurrentWeatherData.fromJson(data)),
      onError: (error) => onError!(error),
    );
  }

  /// Fetches five-day weather forecast data for the specified city.
  /// 
  /// This method constructs a request URL using the base URL, city, and API key,
  /// then retrieves the five-day forecast data from the API. The data is processed
  /// and returned as a list of `FiveDaysData` objects through the `onSuccess`
  /// callback.
  /// 
  /// - [beforeSend]: A callback function that is invoked just before the request
  ///   is sent. Can be used for showing loading indicators.
  /// - [onSuccess]: A callback function that is invoked when the request is
  ///   successful. Receives a list of `FiveDaysData` objects containing the
  ///   weather information.
  /// - [onError]: A callback function that is invoked if the request fails.
  ///   Receives an error object with details about the failure.
  void getFiveDaysThreeHoursForCastData({
    Function()? beforeSend,
    Function(List<FiveDaysData> fiveDayData)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    final url = '$baseUrl/forecast?q=$city&lang=en&$apiKey';

    ApiRepository(
      url: '$url',
    ).getData(
        beforeSend: () => {},
        onSuccess: (data) => {
          onSuccess!((data['list'] as List)
                    .map((t) => FiveDaysData.fromJson(t))
                    .toList()),
            },
        onError: (error) => {
              onError!(error),
            });
  }
}
