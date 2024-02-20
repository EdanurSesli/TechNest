import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyHealthApp());
}

class MyHealthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Check',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HealthPage(),
    );
  }
}

class HealthPage extends StatefulWidget {
  @override
  _HealthPageState createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  TextEditingController heartRateController = TextEditingController();
  TextEditingController oxygenLevelController = TextEditingController();
  TextEditingController systolicPressureController = TextEditingController();
  TextEditingController diastolicPressureController = TextEditingController();

  String notificationMessage = '';
  bool isGoodAnswered = false;
  int countdown = 45;

  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Check', textAlign: TextAlign.start),
        automaticallyImplyLeading: false,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildTextField('Heart Rate (bpm)', heartRateController),
            buildTextField('Oxygen Level (%)', oxygenLevelController),
            buildTextField('Systolic Pressure', systolicPressureController),
            buildTextField('Diastolic Pressure', diastolicPressureController),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => checkHealth(),
              child: Text('Check Health Status'),
            ),
            SizedBox(height: 16),
            Text(
              notificationMessage,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
    );
  }

  void checkHealth() {
    if (areFieldsFilled()) {
      int heartRate = int.tryParse(heartRateController.text) ?? 0;
      int oxygenLevel = int.tryParse(oxygenLevelController.text) ?? 0;
      int systolicPressure = int.tryParse(systolicPressureController.text) ?? 0;
      int diastolicPressure =
          int.tryParse(diastolicPressureController.text) ?? 0;

      if (heartRate < 60 ||
          heartRate > 100 ||
          oxygenLevel < 92 ||
          oxygenLevel > 99 ||
          systolicPressure < 120 ||
          systolicPressure > 130 ||
          diastolicPressure < 70 ||
          diastolicPressure > 90) {
        showNotification("In a risky range!");
        askGood();
      } else {
        showGoodNotification();
      }
    } else {
      showNotification("Please fill in all health data.");
    }
  }

  bool areFieldsFilled() {
    return heartRateController.text.isNotEmpty &&
        oxygenLevelController.text.isNotEmpty &&
        systolicPressureController.text.isNotEmpty &&
        diastolicPressureController.text.isNotEmpty;
  }

  void showNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void showGoodNotification() {
    int localCountdown = countdown;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Are you feeling well?'),
              content: Column(
                children: [
                  Text('You have reported feeling well.'),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        isGoodAnswered = true;
                      });
                      _timer?.cancel();
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    _timer?.cancel(); // Ekledim: Daha önceki zamanlayıcıyı iptal et
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (localCountdown == 0) {
        timer.cancel();
        Navigator.pop(context);
        if (!isGoodAnswered) {
          notifyEmergency();
        }
      } else {
        setState(() {
          localCountdown--;
        });
      }
    });
  }

  void askGood() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you feeling well?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  isGoodAnswered = true;
                });
                showGoodNotification();
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                showNotification("Emergency teams have been notified!");
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );

    _timer = Timer(Duration(seconds: 45), () {
      if (!isGoodAnswered) {
        Navigator.of(context).pop();
        showNotification("Emergency teams have been notified!");
      }
    });
  }

  void notifyEmergency() {
    showNotification("Emergency teams have been notified!");
  }

  @override
  void dispose() {
    _timer?.cancel();
    heartRateController.dispose();
    oxygenLevelController.dispose();
    systolicPressureController.dispose();
    diastolicPressureController.dispose();
    super.dispose();
  }
}
