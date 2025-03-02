import 'package:get/get.dart';
import 'package:weather_app/models/current_weather_data.dart';
import 'package:weather_app/models/five_days_data.dart';
import 'package:weather_app/service/weather_service.dart';

class HomeController extends GetxController {
  String? city;
  String? searchText;

  CurrentWeatherData currentWeatherData = CurrentWeatherData();
  List<CurrentWeatherData> dataList = [];
  List<FiveDaysData> fiveDaysData = [];

  HomeController({required this.city});

  @override
/// Initializes the controller, setting up the initial state and fetching 
/// weather data for the top five cities. Calls the superclass's `onInit` 
/// method after initialization is complete.

  void onInit() {
    initState();
    getTopFiveCities();
    super.onInit();
  }

  /// Fetches current weather data for the current city and updates the state. 
  /// Useful when the user selects a different city from the search list.
  void updateWeather() {
    initState();
  }

  /// Initializes the state of the controller by fetching current weather and
  /// five-day forecast data for the current city. Used when the controller is
  /// first initialized and when the user selects a different city from the
  /// search list.
  void initState() {
    getCurrentWeatherData();
    getFiveDaysData();
  }

  /// Fetches current weather data for the current city and updates the state.
  /// Calls [WeatherService.getCurrentWeatherData] and sets the current weather
  /// data to the received data. If there is an error, it will still update the
  /// state.
  void getCurrentWeatherData() {
    WeatherService(city: '$city').getCurrentWeatherData(
        onSuccess: (data) {
          currentWeatherData = data;
          update();
        },
        onError: (error) => {
          update(),
        });
  }

  /// Fetches current weather data for the top five cities and updates the state.
  /// The cities are currently hard-coded to: zagazig, cairo, alexandria, ismailia,
  /// and fayoum. Calls [WeatherService.getCurrentWeatherData] for each city and
  /// adds the received data to the state's `dataList` list. If there is an error,
  /// it will still update the state.
  void getTopFiveCities() {
    List<String> cities = [
      'zagazig',
      'cairo',
      'alexandria',
      'ismailia',
      'fayoum'
    ];
    cities.forEach((c) {
      WeatherService(city: '$c').getCurrentWeatherData(onSuccess: (data) {
        dataList.add(data);
        update();
      }, onError: (error) {
        update();
      });
    });
  }

  /// Fetches the five-day forecast for the current city and updates the state.
  /// Calls [WeatherService.getFiveDaysThreeHoursForCastData] and sets the
  /// five-day forecast data to the received data. If there is an error, it will
  /// still update the state.
  void getFiveDaysData() {
    WeatherService(city: '$city').getFiveDaysThreeHoursForCastData(
        onSuccess: (data) {
          fiveDaysData = data;
          update();
        }, onError: (error) {
      update();
    });
  }
}