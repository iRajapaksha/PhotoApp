import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UploadPage(),
    );
  }
}

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFiles;
  String? _result;

  Future<void> _pickImages() async {
    final List<XFile>? selectedImages = await _picker.pickMultiImage();
    setState(() {
      _imageFiles = selectedImages;
    });
  }

  Future<void> _uploadImages() async {
    if (_imageFiles == null || _imageFiles!.isEmpty) {
      setState(() {
        _result = "No images selected.";
      });
      return;
    }

    var request = http.MultipartRequest('POST', Uri.parse('http://127.0.0.1:5000/upload'));

    for (var imageFile in _imageFiles!) {
      request.files.add(await http.MultipartFile.fromPath('files[]', imageFile.path));
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var decodedData = json.decode(responseData);
      setState(() {
        _result = decodedData.toString();
      });
    } else {
      setState(() {
        _result = "Upload failed with status: ${response.statusCode}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload and Blur Detection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickImages,
              child: Text('Select Images'),
            ),
            ElevatedButton(
              onPressed: _uploadImages,
              child: Text('Upload Images'),
            ),
            SizedBox(height: 20),
            if (_result != null) Text(_result!),
          ],
        ),
      ),
    );
  }
}
