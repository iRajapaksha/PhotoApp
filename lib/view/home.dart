import 'package:flutter/material.dart';
import 'package:photo_app/view/gallery_manager.dart';
import 'package:photo_app/view/top_suggestions.dart';
import 'package:photo_app/components/nav_bar.dart';
import 'package:photo_app/view/gallery_view.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key); // Remove the redundant 'key' parameter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      endDrawer: endDrawer(context),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.blueAccent
                ),
                width: 450,
                height: 400, // Adjust height here
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildMenuButton(
                      context,
                      "Top Suggestions",
                      Icons.thumb_up,
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TopSuggestions(),
                          ),
                        );
                      },
                    ),
                    _buildMenuButton(
                      context,
                      "Gallery Manager",
                      Icons.photo_album, // Icon for Gallery Manager button
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GalleryManager(),
                          ),
                        );
                      },
                    ),
                    _buildMenuButton(
                      context,
                      "Gallery",
                      Icons.image,
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GalleryView(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String text, IconData iconData, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          minimumSize: const Size(100, 100),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(color: Colors.black), // Add black margin
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Icon(
              iconData,
              size: 30,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

}
