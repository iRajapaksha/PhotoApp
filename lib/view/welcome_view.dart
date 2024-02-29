import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_app/view/home.dart';


class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color(0xFF1FA2FD),
              Color(0xFF0072ff),
            ],
            radius: 1,
            center: Alignment.topLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 120.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi There!',
                    style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'WELCOME TO',
                      style: TextStyle(
                        fontSize: 35.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 50.0),
                    const Text(
                      'PhotoApp',
                      style: TextStyle(
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10.0), // Add some space before the image
                    // Insert Splash widget here
                    Column(
                      children: [
                        Center(
                          child: Transform.scale(
                            scale: 3, // Adjust the scale factor as needed for zoom
                            child: Lottie.asset(
                              "assets/animation/Animation - 1709192474910.json",
                              height: 300, // Adjust the height as needed
                            ),
                          ),
                        ),
                      ],

                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the home view page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // renamed to primary
                  minimumSize: const Size(180, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), // added rounded corners
                  ),
                ),
                child: const Text(
                  'Get started',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
