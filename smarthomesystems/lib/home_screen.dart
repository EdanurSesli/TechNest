import 'package:flutter/material.dart';
import 'package:technest/_pages/sensors_page.dart';
import '_pages/health_page.dart';
import '_pages/sensors_page.dart';
import '_pages/emergency_page.dart';
import '_pages/home_security_page.dart';
import '_pages/devices_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HealthPage(),
    SensorsPage(),
    EmergencyPage(),
    HomeSecurityPage(),
    DevicesPage()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Health',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sensors_sharp),
              label: 'Sensors',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emergency_share_outlined),
              label: 'Emergency',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.security),
              label: 'Security',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.devices),
              label: 'Devices',
            ),
          ],
        ),
      ),
    );
  }
}
