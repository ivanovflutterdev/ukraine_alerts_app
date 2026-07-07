import 'package:flutter/material.dart';
import 'package:ukraine_alerts_app/features/alerts/presentation/screens/alerts_map_screen.dart';
import 'package:ukraine_alerts_app/features/alerts/presentation/screens/region_alerts_screen.dart';
import 'package:ukraine_alerts_app/features/alerts/presentation/widgets/home_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.yellow],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeButton(
                  title: 'Alerts Map',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const AlertsMapScreen(),
                      ),
                    );
                  },
                  icon: Icons.map_outlined,
                ),
                const SizedBox(height: 20),
                HomeButton(
                  title: 'Region Alerts',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const RegionAlertsScreen(),
                      ),
                    );
                  },
                  icon: Icons.location_city,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
