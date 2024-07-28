import 'dart:collection';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_app/models/photo.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:photo_app/image_paths.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;

class Defects extends StatefulWidget {
  const Defects({super.key});

  @override
  State<Defects> createState() => _DefectsState();
}

class _DefectsState extends State<Defects> {
  List<Photo> photos = [];
  HashSet selectedItems = HashSet();
  List<String> images = imagePaths;
  List<File> _imageFiles = [];
  List<String> blurImages = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadImages();
    _uploadImages();
    getInitInfo();
  }

  void getInitInfo() {
    photos = Photo.getPhotos();
  }

  Future<void> _uploadImages() async {
    if (images.isEmpty) {
      print('No images to upload');
      return;
    }

    var uri = Uri.parse('http://192.168.1.32:5001/upload');
    var request = http.Request('POST', uri);
    request.headers['Content-Type'] = 'application/json';
    request.body = jsonEncode({
      'image_paths': images,
    });

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        final data = json.decode(responseData.body);

        setState(() {
          blurImages = List<String>.from(
              data['blur_images'].map((img) => img['image_path']));
          _isLoading = false;
        });

        print(blurImages);

      } else {
        print('Failed to upload images. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _loadImages() {
    setState(() {
      _imageFiles = images.map((path) => File(path)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _imageGroup(),
          ),
          ElevatedButton(
              onPressed: () {},
              child: Text("Delete ${selectedItems.length} images")),
        ],
      ),
    );
  }

  Column _imageGroup() {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: GridView.builder(
              itemCount: blurImages.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (context, index) {
                return photoContainer(context, index);
              }),
        ),
      ],
    );
  }

  void multiSelection(String path) {
    setState(() {
      if (selectedItems.contains(path)) {
        selectedItems.remove(path);
      } else {
        selectedItems.add(path);
      }
    });
  }

  GridTile photoContainer(BuildContext context, int index) {
    String baseDir =
        'F:/Campus/5th semester/EE5454 Software Project/PhotoApp/PhotoApp/';
    List<String> relativePaths =
        blurImages.map((path) => p.relative(path, from: baseDir)).toList();

    return GridTile(
      child: Stack(alignment: Alignment.bottomRight, children: [
        Container(
          height: 130,
          width: 150,
          color: Colors.blueAccent,
          child: Image.asset(
            relativePaths[index],
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: InkWell(
            onTap: () {
              multiSelection(blurImages[index]);
            },
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: selectedItems.contains(blurImages[index])
                    ? Colors.blue
                    : Colors.white,
                shape: BoxShape.circle,
              ),
              child: Visibility(
                  visible: selectedItems.contains(blurImages[index]),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.black,
                  )),
            ),
          ),
        )
      ]),
    );
  }
}
