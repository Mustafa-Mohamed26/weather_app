import 'package:flutter/material.dart';

class CurrentStateCard extends StatelessWidget {
  final String title;
  final String value;
  const CurrentStateCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
        //width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }
}
