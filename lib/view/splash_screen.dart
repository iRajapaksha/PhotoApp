import 'package:flutter/material.dart';
import 'package:photo_app/view/home.dart';
import 'package:photo_app/view/welcome_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat(reverse: true);
  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.easeIn);


  // void navigateToNextScreen(BuildContext context) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   bool showWelcomeScreen = preferences.getBool('showWelcomeScreen') ?? true;
  //   if (showWelcomeScreen) {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => WelcomeView()));
  //   } else {
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => Home()));
  //   }
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
     // navigateToNextScreen(context);
    });
  }    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 0, 114),
      body: FadeTransition(
        opacity: _animation,
        child: _splashScreen(),)
    );
  }

  Center _splashScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          Image.asset(
            'assets/icons/PhotoApp_Logo-removebg-preview.png',
          width: 150, 
          height: 150,),
          Text(
              'PhotoApp',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.0,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.7),
                    offset: const Offset(2, 2),
                    blurRadius:  10,
                  ),
                ],
              ),
            ),
            Text('0.0.1',style: TextStyle(
              color: Colors.grey
            ),)
        ],
      ),
    );
  }
}
