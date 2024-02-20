import 'package:flutter/material.dart';
import 'package:photo_app/view/home.dart';

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
            const SizedBox(height: 8),
            const Text(
              'PhotoApp',
              style: TextStyle(
                fontSize: 64,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),
            // Adjusted the height for better spacing
            ElevatedButton(
              onPressed: () {
                // Navigate to the home view page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Renamed backgroundColor to primary
                minimumSize: const Size(200, 50),
              ),
              child: const Text(
                'Get started',
                style: TextStyle(
                  color: Colors.white,
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
