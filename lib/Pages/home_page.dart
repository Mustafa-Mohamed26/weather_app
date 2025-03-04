import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Providers/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // Get the current date and format it
    String formattedDate = DateFormat(' MMMM d, yyyy').format(DateTime.now());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "The Name of the City",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.blueAccent,
              Colors.white,
            ],
            center: Alignment(0.9, -0.9), 
            radius: 0.8, 
            stops: [0.2, 1.0],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              SizedBox(height: 10),
              Text(
                formattedDate, // Display formatted date
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 40),
              Icon(Icons.sunny, size: 300),
              SizedBox(width: 10),
              Row(
                children: [],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:intl/intl.dart'; // Import intl package
// import '../providers/weather_provider.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final weatherProvider = Provider.of<WeatherProvider>(context);

//     // Get the current date and format it
//     String formattedDate = DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now());

//     return Scaffold(
//       appBar: AppBar(title: Text("Weather App")),
//       body: Center(
//         child: weatherProvider.isLoading
//             ? CircularProgressIndicator()
//             : weatherProvider.weather == null
//                 ? Text("Enter a city to get weather info")
//                 : Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         weatherProvider.weather?.city ?? "Unknown City",
//                         style: TextStyle(fontSize: 30),
//                       ),
//                       SizedBox(height: 8), // Add some spacing
//                       Text(
//                         formattedDate, // Display formatted date
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         "${weatherProvider.weather?.temperature?.toStringAsFixed(1) ?? '--'}°C",
//                         style: TextStyle(fontSize: 50),
//                       ),
//                       Text(weatherProvider.weather?.description ?? "No description"),
//                       if (weatherProvider.weather?.icon != null)
//                         Image.network(
//                           "https://openweathermap.org/img/wn/${weatherProvider.weather!.icon}@2x.png",
//                         ),
//                       Text("Humidity: ${weatherProvider.weather?.humidity ?? '--'}%"),
//                       Text("Wind: ${weatherProvider.weather?.windSpeed ?? '--'} m/s"),
//                     ],
//                   ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           weatherProvider.fetchWeather("Alexandria");
//         },
//         child: Icon(Icons.search),
//       ),
//     );
//   }
// }
