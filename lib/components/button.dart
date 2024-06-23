import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function onPressed;
  final String title;
  const Button({super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        elevation: 5,
        backgroundColor: Colors.white,
        fixedSize:  Size(screenWidth*0.95, screenHeight*0.07),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ).copyWith(
                  shadowColor:
                      MaterialStateProperty.all(Colors.black.withOpacity(1)),
                ),
      child: Text(
        title,
        style: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 20,
        ),
      ),
    );
  }
}
