import 'package:flutter/material.dart';

class ContactUsApp extends StatelessWidget {
  const ContactUsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact Us',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ContactUsPage(),
    );
  }
}

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 0.5,
            color: Colors.white30,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'PhotoApp',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const ListTile(
                    leading: Icon(Icons.location_on, color: Colors.blue),
                    title: Text(
                      '123 Main Street, City, Country',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const ListTile(
                    leading: Icon(Icons.phone, color: Colors.blue),
                    title: Text(
                      '+1234567890',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const ListTile(
                    leading: Icon(Icons.email, color: Colors.blue),
                    title: Text(
                      'contact@photoapp.com',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const ContactUsApp());
}
