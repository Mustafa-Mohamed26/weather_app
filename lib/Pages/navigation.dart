import 'package:flutter/material.dart';
import 'package:weather_app/Pages/home/forecast_report_screen.dart';
import 'package:weather_app/Pages/home/home_screen.dart';
import 'package:weather_app/Pages/home/search_screen.dart';
import 'package:weather_app/Pages/home/setting_screen.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    ForecastReportScreen(),
    SettingScreen(),
    SearchScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.blue, // Color for selected icon
        unselectedItemColor: Colors.grey, // Color for unselected icons
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
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
    );
  }
}
