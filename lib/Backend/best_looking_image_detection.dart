import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImagePickerScreen(),
    );
  }
}

class ImagePickerScreen extends StatefulWidget {
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  List<File> _images = [];
  List<String> _imageNames = [];
  List<String> _resultImages = [];

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _images = pickedFiles.map((file) => File(file.path)).toList();
        _imageNames = pickedFiles.map((file) => basename(file.path)).toList();
      });
    }
  }

  Future<void> _uploadImages() async {
    var uri = Uri.parse('http://127.0.0.1:5000/upload'); // Change to your Flask server URL
    var request = http.MultipartRequest('POST', uri);

    for (var image in _images) {
      var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
      var length = await image.length();
      var multipartFile = http.MultipartFile('files', stream, length, filename: basename(image.path));
      request.files.add(multipartFile);
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await http.Response.fromStream(response);
      var decodedData = jsonDecode(responseData.body);
      setState(() {
        _resultImages = List<String>.from(decodedData['images_surpassing_thresholds']);
      });
    } else {
      print('Upload failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _pickImages,
            child: Text('Pick Images'),
          ),
          ElevatedButton(
            onPressed: _uploadImages,
            child: Text('Display Best Looking Images'),
          ),
          Expanded(
            child: ListView(
              children: [
                Text('Selected Images:', style: TextStyle(fontWeight: FontWeight.bold)),
                ..._imageNames.map((name) => Text(name)).toList(),
                if (_resultImages.isNotEmpty)
                  Text('Best Looking Images:', style: TextStyle(fontWeight: FontWeight.bold)),
                ..._resultImages.map((name) => Text(name)).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
