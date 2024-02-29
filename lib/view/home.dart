import 'package:flutter/material.dart';
import 'package:photo_app/view/gallery_manager.dart';
import 'package:photo_app/view/top_suggestions.dart';
import 'package:photo_app/components/nav_bar.dart';
import 'package:photo_app/view/gallery_view.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      endDrawer: endDrawer(context),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF67A4FF),
              Color(0xFF0053DF),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildMenuButton(
                context,
                "Top\nSuggestions",
                Icons.thumb_up, // Icon for Top Suggestions button
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
                Icons.image, // Icon for Gallery button
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
    );
  }

  Widget _buildMenuButton(
      BuildContext context, String text, IconData iconData, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                iconData,
                size: 70,
                color: Colors.lightBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
