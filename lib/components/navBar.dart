import 'package:flutter/material.dart';
import 'package:photo_app/view/home.dart';

AppBar appBar() =>
    AppBar(automaticallyImplyLeading: false, title: Text("PhotoApp"));

Drawer endDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      children: [
      DrawerHeader(child: Image.asset("assets/icons/logo.png", fit: BoxFit.cover,)),
        GestureDetector(
          onTap: () {
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );// Ad
            // context
            // MaterialPageRoute(builder: (context) => Home()));
          },
          child: const ListTile(
            leading: Icon(Icons.home),
            title: Text("Home Page"),
          ),
        ),
        const ListTile(
          leading: Icon(Icons.info_rounded),
          title: Text("About"),
        ),
        const ListTile(
          leading: Icon(Icons.settings),
          title: Text("Settings"),
        ),
        const ListTile(
          leading: Icon(Icons.contact_emergency),
          title: Text("Contact Us"),
        ),
      ],
    ),
  );
}
