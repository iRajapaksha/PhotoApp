import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CaptionGenerator(),
    );
  }
}

class CaptionGenerator extends StatefulWidget {
  @override
  _CaptionGeneratorState createState() => _CaptionGeneratorState();
}

class _CaptionGeneratorState extends State<CaptionGenerator> {
  File? _image;
  String _caption = '';

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _generateCaption() async {
    if (_image == null) return;

    final request = http.MultipartRequest('POST', Uri.parse('http://127.0.0.1:5000/generate_caption'));
    request.files.add(await http.MultipartFile.fromPath('image', _image!.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final decodedResponse = json.decode(responseBody);
      setState(() {
        _caption = decodedResponse['caption'];
      });
    } else {
      print('Failed to generate caption');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Caption Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No image selected.')
                : SizedBox(
              width: 150, // Set the desired width
              height: 150, // Set the desired height
              child: Image.file(_image!),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _generateCaption,
              child: Text('Generate Caption'),
            ),
            SizedBox(height: 16),
            Text(
              _caption,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
