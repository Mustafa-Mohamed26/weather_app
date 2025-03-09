import 'package:flutter/material.dart';
import 'package:weather_app/widgets/custom_app_bar.dart';
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Pick location"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text("Find the area or city that you want to know the detailed weather info at this time"),
      ),
    );
  }
}
