import 'package:flutter/material.dart';
import 'package:photo_app/view/splash_screen.dart';
import 'package:photo_app/utils/tflite_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final TFLiteHelper tfliteHelper = TFLiteHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tfliteHelper.loadModel();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tfliteHelper.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
