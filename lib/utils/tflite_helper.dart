import 'package:tflite_flutter/tflite_flutter.dart';

class TFLiteHelper {
  late Interpreter interpreter;

  Future<void> loadModel() async {
    try {
      interpreter = await Interpreter.fromAsset('assets/resnet50.tflite');
      print('Model loaded successfully');
    } catch (e) {
      print('Failed to load model: $e');
    }
  }

  List<dynamic> runInference(List<dynamic> input) {
    // Define the output structure
    var output = List.filled(1 * 1000, 0).reshape([1, 1000]);

    // Run inference
    interpreter.run(input, output);

    return output;
  }

  void close() {
    interpreter.close();
  }
}
