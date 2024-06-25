import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:photo_app/utils/image_preprocess.dart';
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

  List<double> runInference(List<List<List<double>>> input) {
    var output = List.filled(2048, 0.0).reshape([1, 2048]);
    interpreter.run([input], output);
    return output[0];
  }

  

  void close() {
    interpreter.close();
  }
}

Future<List<List<double>>> processAndSendImages(List<File> imageFiles) async {
  TFLiteHelper tfliteHelper = TFLiteHelper();
  await tfliteHelper.loadModel();

  List<List<double>> featureVectors = [];
  for (File imageFile in imageFiles) {
    List<List<List<double>>> input = preprocessImage(imageFile);
    List<double> featureVector = tfliteHelper.runInference(input);
    featureVectors.add(featureVector);
  }

  tfliteHelper.close();
  return featureVectors;
}

// Future<void> sendFeatureVectors(List<List<double>> featureVectors) async {
//   var url = Uri.parse('http://<your_server_ip>:5000/find_similar_images');
//   var headers = {"Content-Type": "application/json"};
//   var body = jsonEncode({"feature_vectors": featureVectors});

//   var response = await http.post(url, headers: headers, body: body);

//   if (response.statusCode == 200) {
//     var data = jsonDecode(response.body);
//     setState(() {
//       _similarImages = List<List<int>>.from(data['similar_images']);
//     });
//   } else {
//     print('Failed to find similar images: ${response.statusCode}');
//   }
// }
