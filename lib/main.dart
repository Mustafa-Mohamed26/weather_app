import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Pages/navigation.dart';
import 'package:weather_app/Providers/theme_provider.dart';
import 'package:weather_app/Providers/weather_five_days_forecast_provider.dart';
import 'package:weather_app/Providers/weather_today_forecast_provider.dart';
import 'package:weather_app/providers/weather_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WeatherProvider()),
        ChangeNotifierProvider(create: (context) => WeatherFiveDaysForCastProvider()),
        ChangeNotifierProvider(create: (context) => TodayForecastProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: WeatherApp(),
    ),
  );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});
  @override
  Widget build(BuildContext context) {
    //final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // // set up for the Dark mode
      // theme: ThemeData.light(),
      // darkTheme: ThemeData.dark(),
      // themeMode: themeProvider.themeMode,
      theme: ThemeData.dark(),
      home: Navigation(),
    );
  }
}
