import 'package:flutter/material.dart';
import 'package:photo_app/view/galleryManager.dart';
import 'package:photo_app/view/topSuggestions.dart';
import 'package:photo_app/components/navBar.dart';
import 'package:photo_app/view/galleryView.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      endDrawer: endDrawer(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildMenuButton(
              context,
              "Top Suggestions",
              Icons.thumb_up, // Icon for Top Suggestions button
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TopSuggestions()),
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
                  MaterialPageRoute(builder: (context) => const GalleryManager()),
                );
              },
            ),
            _buildMenuButton(
              context,
              "Gallery",
              Icons.image, // Icon for Gallery button
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GalleryView()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String text, IconData iconData, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.blueAccent,
        minimumSize: const Size(350, 200),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 80, // Adjust the size of the icon as needed
            color: Colors.white38,
          ),
          const SizedBox(height: 15), // Add some spacing between the icon and text
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
