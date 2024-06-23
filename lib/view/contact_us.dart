import 'package:flutter/material.dart';
import 'package:photo_app/components/nav_bar.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        endDrawer: endDrawer(context),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/icons/background.jpg'),
                      fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.5),
                    border: Border.all(
                        color: const Color.fromRGBO(144, 224, 239, 1)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'PhotoApp',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 16.0),
                        const ListTile(
                          leading: Icon(Icons.location_on,
                              color: Color.fromARGB(255, 255, 255, 255)),
                          title: Text(
                            '123 Main Street, City, Country',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        const ListTile(
                          leading: Icon(Icons.phone,
                              color: Color.fromARGB(255, 255, 255, 255)),
                          title: Text(
                            '+1234567890',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        const ListTile(
                          leading: Icon(Icons.email,
                              color: Color.fromARGB(255, 255, 255, 255)),
                          title: Text(
                            'contact@photoapp.com',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
