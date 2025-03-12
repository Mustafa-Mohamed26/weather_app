import 'package:flutter/material.dart';
import 'package:weather_app/widgets/weather_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: WeatherCard(city: "Cairo"),
      ),
    );
  }
}
