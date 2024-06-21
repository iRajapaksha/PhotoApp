import 'package:flutter/material.dart';
import 'package:photo_app/view/home.dart';
import 'package:photo_app/view/home_app_info.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/icons/blue-background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                  height: 300), 
              const HomeAppInfo(),
              const Spacer(),
              Center(
                  child: ElevatedButton(
                onPressed: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  await preferences.setBool('showWelcomeScreen', false);
                  _requestPermission(context);
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(screenWidth*0.95, screenHeight*0.07),
                  backgroundColor: const Color.fromARGB(
                      255, 255, 255, 255),
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        30.0), 
                  ),
                  elevation: 20.0,
                ).copyWith(
                  shadowColor:
                      MaterialStateProperty.all(Colors.black.withOpacity(1)),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ),
              const SizedBox(height: 60.0),
            ],
          ),
        ],
      ),
    );
  }
}

void _requestPermission(BuildContext context) {
  PhotoManager.requestPermissionExtend().then((PermissionState state) {
    if (state.isAuth) {
      // Permission granted, navigate to GalleryView
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => Home()),
      );
    } else {
      // Permission denied, show dialog and request permission again
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Permission Required'),
            content: const Text(
                'This app requires access to your gallery to proceed. Please grant the necessary permissions.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Deny'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Allow'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _requestPermission(context);
                },
              ),
            ],
          );
        },
      );
    }
  });
}
