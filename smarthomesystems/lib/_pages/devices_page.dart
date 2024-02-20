import 'package:flutter/material.dart';

class DevicesPage extends StatefulWidget {
  @override
  _DevicesPageState createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  Map<String, bool> lightsState = {
    'Living Room': false,
    'Bedroom': false,
    'Kitchen': false,
    'Bathroom': false,
    'Balcony': false,
  };

  Map<String, bool> acState = {
    'Living Room': false,
    'Bedroom': false,
    'Kitchen': false,
    'Bathroom': false,
    'Balcony': false,
  };

  Map<String, bool> curtainsState = {
    'Living Room': false,
    'Bedroom': false,
    'Kitchen': false,
    'Bathroom': false,
    'Balcony': false,
  };

  Map<String, bool> socketState = {
    'Living Room Socket 1': false,
    'Living Room Socket 2': false,
    'Bedroom Socket 1': false,
    'Bedroom Socket 2': false,
    'Kitchen Socket 1': false,
    'Kitchen Socket 2': false,
    'Bathroom Socket 1': false,
    'Bathroom Socket 2': false,
    'Balcony Socket 1': false,
    'Balcony Socket 2': false,
  };

  bool tvState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devices', textAlign: TextAlign.start),
        automaticallyImplyLeading: false,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildDeviceCategory('Lights', lightsState, (room, isOn) {
                setState(() {
                  lightsState[room] = isOn;
                });
              }),
              SizedBox(height: 16.0),
              _buildDeviceCategory('Air Conditioners', acState, (room, isOn) {
                setState(() {
                  acState[room] = isOn;
                });
              }),
              SizedBox(height: 16.0),
              _buildDeviceCategory('Curtains', curtainsState, (room, isOn) {
                setState(() {
                  curtainsState[room] = isOn;
                });
              }),
              SizedBox(height: 16.0),
              _buildDeviceCategory('Sockets', socketState, (room, isOn) {
                setState(() {
                  socketState[room] = isOn;
                });
              }),
              SizedBox(height: 16.0),
              _buildSingleDeviceCategory('TV', tvState, (isOn) {
                setState(() {
                  tvState = isOn;
                });
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceCategory(String title, Map<String, bool> deviceState,
      Function(String, bool) onDeviceChanged) {
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
            title,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          for (String room in deviceState.keys)
            _buildDeviceControl(room, deviceState[room]!, (isOn) {
              onDeviceChanged(room, isOn);
            }),
        ],
      ),
    );
  }

  Widget _buildSingleDeviceCategory(
      String title, bool deviceState, Function(bool) onDeviceChanged) {
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
            title,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          _buildDeviceControl(title, deviceState, onDeviceChanged),
        ],
      ),
    );
  }

  Widget _buildDeviceControl(
      String deviceName, bool isOn, Function(bool) onDeviceChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(deviceName),
        Switch(
          value: isOn,
          onChanged: (value) {
            onDeviceChanged(value);
          },
        ),
      ],
    );
  }
}
