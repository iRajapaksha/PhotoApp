import 'package:flutter/material.dart';
import 'package:photo_app/view/home.dart';
import 'package:photo_app/view/options.dart';
import 'package:photo_app/view/contact_us.dart';
import 'package:photo_app/view/welcome_view.dart';

AppBar appBar() =>
    AppBar(automaticallyImplyLeading: false, title: const Text("PhotoApp"),backgroundColor:Color.fromRGBO(237, 246, 249,1 ) ,);

Drawer endDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: Color.fromRGBO(237, 246, 249,1 ),
    child: ListView(
      children: [
        DrawerHeader(
            child: Image.asset(
          "assets/icons/PhotoApp_Logo-removebg-preview.png",
          fit: BoxFit.contain,
        )),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WelcomeView()),
            ); // Ad
            // context
            // MaterialPageRoute(builder: (context) => Home()));
          },
          child: const ListTile(
            leading: Icon(Icons.home),
            title: Text("Home Page"),
          ),
        ),
        GestureDetector(
          onTap: () {
            showAboutDialog(
                context: context,
                applicationIcon: Image.asset(
                  "assets/icons/PhotoApp_Logo-removebg-preview.png",
                  width: 80,
                  height: 80,
                ),
                applicationName: 'PhotoApp',
                applicationVersion: '0.0.1',
              //  applicationLegalese: 'Developed by faculty of Engineering university of Ruhuna',
                children: [
                  AboutUs()
                ]);
          },
          child: const ListTile(
            leading: Icon(Icons.info_rounded),
            title: Text("About"),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Options()));
          },
          child: const ListTile(
            leading: Icon(Icons.settings),
            title: Text("Options"),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ContactUsApp()));
          },
          child: const ListTile(
            leading: Icon(Icons.contact_emergency),
            title: Text("Contact Us"),
          ),
        ),
      ],
    ),
  );

  
}
Widget AboutUs(){
    return const Text(
    'Welcome to Photo App, crafted by computer engineering students at the University of Ruhuna. We''ve designed this app using Flutter to simplify your photo management experience. Whether removing defected, blurred, or similar photos and generating suitable captions for photos in your gallery, Photo App has you covered.\n\n'
            'Our commitment lies in user satisfaction and technological excellence. We hope you enjoy using Photo App as much as we enjoyed creating it.\n\n'
            'Thank you for choosing Photo App!\n\n'
            'The Photo App Team\nUniversity of Ruhuna, Faculty of Engineering',
            style: TextStyle(fontSize: 16.0),
    );
  }