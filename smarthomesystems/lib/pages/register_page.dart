import 'package:flutter/material.dart';
import 'package:technest/components/my_button.dart';
import 'package:technest/components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  void registerUser() {
    // Kullanıcı bilgilerini al
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String address = addressController.text;

    showSuccessSnackBar();
    navigateToLoginPage();
  }

  void showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('Your registration has been completed. You can now log in!'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void navigateToLoginPage() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextField(
              controller: firstNameController,
              hintText: 'First Name',
              obscureText: false,
            ),
            SizedBox(height: 20),
            MyTextField(
              controller: lastNameController,
              hintText: 'Last Name',
              obscureText: false,
            ),
            SizedBox(height: 20),
            MyTextField(
              controller: emailController,
              hintText: 'Email',
              obscureText: false,
            ),
            SizedBox(height: 20),
            MyTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),
            SizedBox(height: 20),
            MyTextField(
              controller: addressController,
              hintText: 'Address',
              obscureText: false,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: registerUser,
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
