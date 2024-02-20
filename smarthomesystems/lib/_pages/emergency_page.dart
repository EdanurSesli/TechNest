import 'package:flutter/material.dart';

class EmergencyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency', textAlign: TextAlign.start),
        automaticallyImplyLeading: false,
        centerTitle: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning,
              color: Colors.red,
              size: 100.0,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _callEmergencyCenter(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              ),
              child: Text(
                'Call Emergency Center',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _callEmergencyCenter(BuildContext context) {
    print('Calling the Emergency Center...');
  }
}

void main() {
  runApp(MaterialApp(
    home: EmergencyPage(),
  ));
}
