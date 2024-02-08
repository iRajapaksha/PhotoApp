import 'package:flutter/material.dart';
import 'package:photo_app/view/galleryManager.dart';
import 'package:photo_app/view/topSuggestions.dart';
import 'package:photo_app/components/navBar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      endDrawer: endDrawer(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TopSuggestions()));
              },
              child: Text(
                "Top \nSuggetions",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  minimumSize: const Size(250, 150),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GalleryManager()),
                ); //
              },
              child: Text(
                "Gallery \nmanager",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  minimumSize: const Size(250, 150),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ],
        ),
      ),
    );
  }


}
