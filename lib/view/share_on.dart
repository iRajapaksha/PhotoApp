import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_app/components/nav_bar.dart';
import 'package:photo_app/models/caption.dart';
import 'package:photo_app/models/photo.dart';

class ShareOn extends StatelessWidget {
  final Photo selectedPhoto;
  final Caption selectedCaption;
  const ShareOn(
      {super.key, required this.selectedPhoto, required this.selectedCaption});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      endDrawer: endDrawer(context),
      body: Column(
        children: [
          Container(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 200, 200, 200)),
            height: 35,
            width: 500,
            child: Row(
              children: [
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset("assets/icons/arrow_left.svg")),
                const SizedBox(
                  width: 8,
                ),
                const Text("Top Suggestions"),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 300,
            width: 300,
            decoration: const BoxDecoration(
                color: Colors.blue,
            ),
            child: Image.asset(
              selectedPhoto.filePath,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: 370,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey,
            ),
            child: Text(
              selectedCaption.description,
              style: const TextStyle(),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 160,
            width: 250,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 181, 181, 181),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.facebook),
                    Icon(Icons.email),
                    Icon(Icons.call),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.facebook),
                    Icon(Icons.email),
                    Icon(Icons.call),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
