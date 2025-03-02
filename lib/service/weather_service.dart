import 'package:weather_app/api/api_repo.dart';
import 'package:weather_app/models/current_weather_data.dart';
import 'package:weather_app/models/five_days_data.dart';

class WeatherService {
  String? city;

  WeatherService({this.city});

  String baseUrl = "https://api.openweathermap.org/data/2.5";
  String apiKey = "appid=dbe5809c77179ecb5b4365ac169822a2";

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
