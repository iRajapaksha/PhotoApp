import 'package:flutter/material.dart';
import 'package:photo_app/view/splash_screen.dart';
import 'package:photo_app/view/welcome_view.dart';


void main() {
  runApp(const App());
}
class App extends StatelessWidget{
      const App({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

