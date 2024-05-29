import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


Container heading(double screenWidth, BuildContext context, String heading) {
    return Container(
          color: const Color.fromARGB(255, 128, 201, 255),
          height: 35,
          width: screenWidth,
          child: Row(
            children: [
              const SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset("assets/icons/arrow_left.svg"),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  heading,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        );
  }
