import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_app/view/home.dart';

class BackgroundTriangles extends StatelessWidget {
  const BackgroundTriangles({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: MediaQuery.of(context).size,
      painter: _BackgroundTrianglePainter(),
    );
  }
}

class _BackgroundTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueAccent
      ..style = PaintingStyle.fill;

    final double width = size.width;
    final double height = size.height;

    // Define coordinates for two triangles
    final List<List<Offset>> triangles = [
      [
        Offset(width * 0, height * 1),
        Offset(width * 0, height * 0),
        Offset(width * 1, height * 0),
      ],
    ];

    // Draw the triangles
    for (final triangle in triangles) {
      final path = Path()
        ..moveTo(triangle[0].dx, triangle[0].dy)
        ..lineTo(triangle[1].dx, triangle[1].dy)
        ..lineTo(triangle[2].dx, triangle[2].dy)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            // decoration: const BoxDecoration(
            //   gradient: RadialGradient(
            //     colors: [
            //       Color(0xFF1FA2FD),
            //       Color(0xFF0072ff),
            //     ],
            //     radius: 1,
            //     center: Alignment.topLeft,
            //   ),
            // ),
          ),
          const BackgroundTriangles(), // Add background triangles
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 120.0),
                // child: Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text(
                //       'Hi There!',
                //       style: TextStyle(
                //         fontSize: 28.0,
                //         color: Colors.black87,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ],
                // ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'WELCOME\nTO',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 30.0),
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
                    primary: Colors.white,
                    minimumSize: const Size(100, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: const BorderSide(color: Colors.black), // Add black margin
                    ),
                  ),
                  child: const Text(
                    'Get started',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
