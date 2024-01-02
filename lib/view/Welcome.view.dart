import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'WELCOME TO',
              style: TextStyle(
                fontSize: 40,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8), // Adding some space between the texts
            const Text(
              'PhotoApp',
              style: TextStyle(
                fontSize: 64, // Adjust the font size as needed
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 300), // Adding space between the title and the button
            ElevatedButton(
              onPressed: () {
                // Add your navigation logic here
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Set the background color to blue
                minimumSize: const Size(200, 50), // Set the minimum width and height
              ),
              child: const Text(
                'Get started',
                style: TextStyle(
                  color: Colors.white, // Set the text color to white
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
