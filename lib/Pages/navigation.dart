import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Pages/home/forecast_report_screen.dart';
import 'package:weather_app/Pages/home/home_screen.dart';
import 'package:weather_app/Pages/home/search_screen.dart';
import 'package:weather_app/Pages/home/setting_screen.dart';
import 'package:weather_app/Providers/weather_provider.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const SearchScreen(),
    const ForecastReportScreen(),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherProvider(), // Provide WeatherProvider here
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex, // Current index of the IndexedStack
          children: _pages, // List of pages
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex:
              _selectedIndex, // Current index of the BottomNavigationBar
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedItemColor: Colors.blue, // Color for selected icon
          unselectedItemColor: Colors.grey, // Color for unselected icons
          iconSize: 30, // Size of the icons
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud),
              label: 'Forecast',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
