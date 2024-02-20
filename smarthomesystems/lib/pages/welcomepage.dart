import 'package:flutter/material.dart';
import 'login_page.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[300],
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 50.0),
              Image.asset(
                'lib/assets/images/logo.png',
                height: 300,
                width: 300,
              ),
              SizedBox(height: 16.0),
              Text(
                'TechNest',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 1, 0, 0),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              Text(
                "Welcome to the TechNest. This app will help you manage your home's smart control systems.",
                style: TextStyle(
                  fontSize: 16.0,
                  color: const Color.fromARGB(255, 2, 1, 1),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text('Start'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
