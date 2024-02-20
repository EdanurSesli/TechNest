import 'package:flutter/material.dart';

class SensorsPage extends StatefulWidget {
  @override
  _SensorsPageState createState() => _SensorsPageState();
}

class _SensorsPageState extends State<SensorsPage> {
  bool smokeDetected = false;
  bool gasLeakDetected = false;
  bool fireDepartmentNotified = false;
  Set<String> alertedTypes = {}; // Track alerted types

  void _callFireDepartment() {
    fireDepartmentNotified = true;
    print('Notifying Fire Department...');
  }

  void _handleUserResponse(bool isUserInformed, bool isSmoke) {
    if (!isUserInformed) {
      _callEmergency(
        context,
        'Security alert: ${isSmoke ? 'Smoke' : 'Gas'} detected. Contact authorities?',
        _callFireDepartment,
        true, // This flag is set to true to indicate that user has been informed
      );
    }
  }

  void _callEmergency(
    BuildContext context,
    String message,
    Function() onEmergencyCall,
    bool userInformed, // Flag for user response
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Emergency'),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () {
                onEmergencyCall();
                if (!userInformed) {
                  // Only pop the dialog if user was not informed
                  Navigator.of(context).pop();
                }
              },
              child: Text('Notify Fire Department'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showUserNotification(
    String message,
    Function(bool) onUserResponse,
  ) async {
    if (!alertedTypes.contains('user')) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Notification'),
            content: Text(message),
            actions: [
              ElevatedButton(
                onPressed: () {
                  onUserResponse(true);
                  setState(() {
                    alertedTypes.add('user');
                  });
                  Navigator.of(context).pop();
                },
                child: Text('Yes'),
              ),
              ElevatedButton(
                onPressed: () {
                  onUserResponse(false);
                  _callEmergency(
                    context,
                    'Security alert: Smoke detected. Contact authorities?',
                    _callFireDepartment,
                    false, // Set userInformed flag as false
                  );
                  Navigator.of(context).pop();
                },
                child: Text('No'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensors', textAlign: TextAlign.start),
        automaticallyImplyLeading: false,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSmokeDetectionControl(),
            SizedBox(height: 16.0),
            _buildGasLeakDetectionControl(),
          ],
        ),
      ),
    );
  }

  Widget _buildSmokeDetectionControl() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Smoke Detection',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          if (smokeDetected)
            Column(
              children: [
                Text('Smoke Detected!'),
                SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: fireDepartmentNotified
                      ? null
                      : () => _confirmSmokeLeak(true),
                  child: Text('Notify Fire Department'),
                  style: fireDepartmentNotified
                      ? ElevatedButton.styleFrom(primary: Colors.grey)
                      : null,
                ),
                SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () => _showUserNotification(
                    'Security alert: Smoke detected. Contact authorities?',
                    (isUserInformed) =>
                        _handleUserResponse(isUserInformed, true),
                  ),
                  child: Text('Test User Notification'),
                ),
              ],
            )
          else
            ElevatedButton(
              onPressed: () => _confirmSmokeLeak(true),
              child: Text('Test Smoke Detection'),
            ),
        ],
      ),
    );
  }

  Widget _buildGasLeakDetectionControl() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gas Leak Detection',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          if (gasLeakDetected)
            Column(
              children: [
                Text('Gas Leak Detected!'),
                SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: fireDepartmentNotified
                      ? null
                      : () => _confirmSmokeLeak(false),
                  child: Text('Notify Fire Department'),
                  style: fireDepartmentNotified
                      ? ElevatedButton.styleFrom(primary: Colors.grey)
                      : null,
                ),
                SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () => _showUserNotification(
                    'Security alert: Gas leak detected. Contact the authorities?',
                    (isUserInformed) =>
                        _handleUserResponse(isUserInformed, false),
                  ),
                  child: Text('Test User Notification'),
                ),
              ],
            )
          else
            ElevatedButton(
              onPressed: () => _confirmSmokeLeak(false),
              child: Text('Test Gas Leak Detection'),
            ),
        ],
      ),
    );
  }

  void _confirmSmokeLeak(bool isSmoke) {
    if (!alertedTypes.contains(isSmoke ? 'smoke' : 'gas')) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('${isSmoke ? 'Smoke' : 'Gas'} Leak Detected!'),
            content: Text(
              'Security alert: ${isSmoke ? 'Smoke' : 'Gas'} leak detected. Contact the authorities?',
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    alertedTypes.add(isSmoke ? 'smoke' : 'gas');
                    if (isSmoke) smokeDetected = true;
                    if (!isSmoke) gasLeakDetected = true;
                  });
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Yes'),
              ),
              ElevatedButton(
                onPressed: () {
                  _callEmergency(
                    context,
                    '${isSmoke ? 'Smoke' : 'Gas'} Leak Detected! Notify Fire Department?',
                    _callFireDepartment,
                    false, // Set userInformed flag as false
                  );
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('No'),
              ),
            ],
          );
        },
      );
    }
  }

  void main() {
    runApp(MaterialApp(
      home: SensorsPage(),
    ));
  }
}
