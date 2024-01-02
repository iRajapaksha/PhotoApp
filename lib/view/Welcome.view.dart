import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'WELCOME TO',
              style: TextStyle(
                fontSize:40,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 0), // Adding some space between the texts
            Text(
              'PhotoApp',
              style: TextStyle(
                fontSize: 64, // Adjust the font size as needed
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
