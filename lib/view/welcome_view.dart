import 'package:flutter/material.dart';
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

    final List<List<Offset>> triangles = [
      [
        Offset(width * 0, height * 1),
        Offset(width * 0, height * 0),
        Offset(width * 0.5, height * 0.5),
      ],

      [
        Offset(width * 0.5, height * 0),
        Offset(width * 0, height * 0),
        Offset(width * 0, height * 1),
      ],

      [
        Offset(width * 1, height * 0.5),
        Offset(width * 0, height * 1),
        Offset(width * 0, height * 0),
      ]

    ];

    final List<double> opacities = [0.4, 0.5, 0.2]; // Define opacity levels for each triangle

    for (int i = 0; i < triangles.length; i++) {
      final triangle = triangles[i];
      final path = Path()
        ..moveTo(triangle[0].dx, triangle[0].dy)
        ..lineTo(triangle[1].dx, triangle[1].dy)
        ..lineTo(triangle[2].dx, triangle[2].dy)
        ..close();

      final paint = Paint()
        ..color = Colors.blue.withOpacity(opacities[i]); // Set opacity for each triangle
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
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/icons/PhotoApp_LogoN.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // const BackgroundTriangles(key: Key('background_triangles')),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100.0), // Added SizedBox to push the text lower
              Text(
                'PhotoApp',
                style: TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.0,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.7),
                      offset: const Offset(2, 2),
                      blurRadius:  10,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Center( // Center widget added to center the button horizontally
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),

                    );
                  },
                  style: ElevatedButton.styleFrom(

                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 40.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 15.0,
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60.0),
            ],
          ),

        ],
      ),
    );
  }
}
