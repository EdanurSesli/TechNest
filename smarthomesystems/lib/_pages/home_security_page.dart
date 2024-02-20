import 'package:flutter/material.dart';

class HomeSecurityPage extends StatefulWidget {
  @override
  _SecurityPageState createState() => _SecurityPageState();
}

class _SecurityPageState extends State<HomeSecurityPage> {
  Map<String, bool> roomCameras = {
    'Living Room': false,
    'Bedroom': false,
    'Kitchen': false,
    'Bathroom': false,
    'Balcony': false,
  };
  bool doorCamera = false;
  bool doorLocked = true;
  bool holidayMode = false;
  bool motionDetected = false;
  bool windowMotionDetected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security', textAlign: TextAlign.start),
        automaticallyImplyLeading: false,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCameraControl('Door Camera', doorCamera, (value) {
              setState(() {
                doorCamera = value;
              });
            }),
            SizedBox(height: 16.0),
            for (String room in roomCameras.keys)
              _buildCameraControl('$room Camera', roomCameras[room]!, (value) {
                setState(() {
                  roomCameras[room] = value;
                });
              }),
            SizedBox(height: 16.0),
            _buildDoorLockControl(),
            SizedBox(height: 16.0),
            _buildHolidayModeControl(),
            SizedBox(height: 16.0),
            _buildMotionDetectionControl(),
            SizedBox(height: 16.0),
            _buildWindowMotionDetectionControl(),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraControl(
      String cameraName, bool isOn, Function(bool) onCameraChanged) {
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
            'Camera Control - $cameraName',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Active'),
              Switch(
                value: isOn,
                onChanged: (value) {
                  onCameraChanged(value);
                },
              ),
              ElevatedButton(
                onPressed: () {
                  _openCameraView(cameraName);
                },
                child: Text('Open Camera View'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _openCameraView(String cameraName) {
    print('Opening Camera View for $cameraName');
  }

  Widget _buildDoorLockControl() {
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
            'Door Lock',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Locked'),
              Switch(
                value: doorLocked,
                onChanged: (value) {
                  setState(() {
                    doorLocked = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHolidayModeControl() {
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
            'Holiday Mode',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Active'),
              Switch(
                value: holidayMode,
                onChanged: (value) {
                  setState(() {
                    holidayMode = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMotionDetectionControl() {
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
            'Motion Detection',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          if (motionDetected)
            Column(
              children: [
                Text('Motion Detected!'),
                SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () {
                    _callPolice();
                  },
                  child: Text('Call Police'),
                ),
                SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () {
                    _showUserNotification(
                        'Security alert: Motion detected. Contact authorities?',
                        _handleUserResponse);
                  },
                  child: Text('Test User Notification'),
                ),
              ],
            )
          else
            ElevatedButton(
              onPressed: () {
                _askUserAboutMotionDetection();
              },
              child: Text('Test Motion Detection'),
            ),
        ],
      ),
    );
  }

  Widget _buildWindowMotionDetectionControl() {
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
            'Window Motion Detection',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          if (windowMotionDetected)
            Column(
              children: [
                Text('Window Motion Detected!'),
                SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () {
                    _callPolice();
                  },
                  child: Text('Call Police'),
                ),
                SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () {
                    _showUserNotification(
                        'Security alert: Window motion detected. Contact the authorities?',
                        _handleUserResponse);
                  },
                  child: Text('Test User Notification'),
                ),
              ],
            )
          else
            ElevatedButton(
              onPressed: () {
                _askUserAboutWindowMotionDetection();
              },
              child: Text('Test Window Motion Detection'),
            ),
        ],
      ),
    );
  }

  void _callPolice() {
    print('Calling Police...');
  }

  Future<void> _askUserAboutMotionDetection() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Motion Detected!'),
          content:
              Text('Security alert: Motion detected. Contact the authorities?'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  motionDetected = true;
                });
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                _callPolice();
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _askUserAboutWindowMotionDetection() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Window Motion Detected!'),
          content: Text(
              'Security alert: Window motion detected. Contact the authorities?'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  windowMotionDetected = true;
                });
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                _callPolice();
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  void _handleUserResponse(bool isUserInformed) {
    if (!isUserInformed) {
      _callPolice();
    }
  }

  Future<void> _showUserNotification(
      String message, Function(bool) onUserResponse) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notification'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                onUserResponse(true);
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                onUserResponse(false);
                _callPolice();
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
