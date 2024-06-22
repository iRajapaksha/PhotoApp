import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:photo_app/components/button.dart';
import 'package:photo_app/components/heading.dart';
import 'package:photo_app/components/nav_bar.dart';
import 'package:photo_app/models/photo.dart';
import 'package:photo_app/view/caption_selection.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:http/http.dart' as http;
import 'package:photo_app/image_paths.dart';
import 'package:path/path.dart' as p;

class TopSuggestions extends StatefulWidget {
  const TopSuggestions({super.key});

  @override
  State<TopSuggestions> createState() => _TopSuggestionsState();
}

class _TopSuggestionsState extends State<TopSuggestions> {
  int selectedPhotoIndex = 0;
  late List<Photo> photos;
  final List<String> _imagePaths = imagePaths;
  List<String> _bestLookingImages = [];

  Future<void> _uploadImages() async {
    if (_imagePaths.isEmpty) {
      print('No images to upload');
      return;
    }

    var uri = Uri.parse('http://172.20.10.2:5002/upload');
    var request = http.Request('POST', uri);
    request.headers['Content-Type'] = 'application/json';
    request.body = jsonEncode({
      'image_paths': _imagePaths,
    });

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        final data = json.decode(responseData.body);

        setState(() {
          _bestLookingImages =
              List<String>.from(data['images_surpassing_thresholds']);
        });

        print(_bestLookingImages);
      } else {
        print('Failed to upload images. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _getInitInfo();
    _uploadImages();
  }

  void _getInitInfo() {
    photos = Photo.getPhotos();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: appBar(),
        endDrawer: endDrawer(context),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/icons/wallpaper.jpg'), // Update the path to your background image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                heading(screenWidth, context, 'Top Suggestions'),
                const SizedBox(height: 30),
                _scrollSnapList(screenWidth),
                const SizedBox(height: 10),
                _imageDescription(),
                const SizedBox(height: 10),
                Button(
                  onPressed: () {
                    onPressed(context);
                  },
                  title: 'Select',
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                )
              ],
            ),
          ],
        ));
  }

  Column _imageDescription() {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          title: Text(
            "Taken On: ${photos[selectedPhotoIndex].dateTime}",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          title: Text(
            "File Info: ${photos[selectedPhotoIndex].fileName}",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Roboto',
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> onPressed(BuildContext context) {
    String baseDir =
        'F:/Campus/5th semester/EE5454 Software Project/PhotoApp/PhotoApp/';
    List<String> relativePaths = _bestLookingImages
        .map((path) => p.relative(path, from: baseDir))
        .toList();
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TopSuggestionSelected(
          selectedPhoto: relativePaths[selectedPhotoIndex],
        ),
      ),
    );
  }

  Expanded _scrollSnapList(double screenWidth) {
    return Expanded(
      child: Center(
        child: ScrollSnapList(
          itemBuilder: _buildListItem,
          itemCount: _bestLookingImages.length,
          itemSize: screenWidth * 0.6,
          onItemFocus: (index) {
            setState(() {
              selectedPhotoIndex = index;
            });
          },
          dynamicItemSize: true,
          duration: 10,
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    String baseDir =
        'F:/Campus/5th semester/EE5454 Software Project/PhotoApp/PhotoApp/';
    List<String> relativePaths = _bestLookingImages
        .map((path) => p.relative(path, from: baseDir))
        .toList();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final photo = relativePaths[index];
    final isFocused = index == selectedPhotoIndex;
    return SizedBox(
      width: screenWidth * 0.6,
      height: screenHeight * 0.8,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: isFocused
              ? const BorderSide(color: Colors.lightBlue, width: 3)
              : BorderSide.none,
        ),
        elevation: isFocused ? 15 : 5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            photo,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
