import 'package:flutter/material.dart';
import 'package:ukraine_alerts_app/features/alerts/presentation/screens/home_screen.dart';

void main () {
  runApp(const UkraineAlertsApp());
}

class UkraineAlertsApp extends StatelessWidget {
  const UkraineAlertsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ukraine Alerts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
