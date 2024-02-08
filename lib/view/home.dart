import 'package:flutter/material.dart';
import 'package:photo_app/view/galleryManager.dart';
import 'package:photo_app/view/topSuggestions.dart';



class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      endDrawer: _endDrawer(),
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

  AppBar _appbar() => AppBar(
    automaticallyImplyLeading: false,
    title: Text("PhotoApp"));
  
  Drawer _endDrawer() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Text("App logo")),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home Page"),
          ),
          ListTile(
            leading: Icon(Icons.info_rounded),
            title: Text("About"),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
          ),
          ListTile(
            leading: Icon(Icons.contact_emergency),
            title: Text("Contact Us"),
          ),
        ],
      ),
    );
  }

}
