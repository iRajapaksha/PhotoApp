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
              "Top\n Suggestions",
              Icons.thumb_up, // Icon for Top Suggestions button
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TopSuggestions()),
                );
              },
            ),
            _buildMenuButton(
              context,
              "Gallery\n Manager",
              Icons.photo_album, // Icon for Gallery Manager button
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GalleryManager()),
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

  Widget _buildMenuButton(BuildContext context, String text, IconData iconData,
      VoidCallback onPressed) {
    return Container(
      width: 350,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [Colors.blue.shade600, Colors.blue.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.4, 0.7],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    // Example: bold font weight
                    fontStyle: FontStyle.italic,
                    // Example: italic font style
                    fontFamily: 'Roboto',
                    // Example: custom font family
                    letterSpacing: 1.5, // Example: spacing between letters
                    // Add more text style properties as needed
                  ),
                ),
                Icon(
                  iconData,
                  size: 80, // Adjust the size of the icon as needed
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}