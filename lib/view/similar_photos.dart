import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:photo_app/models/photo.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:photo_app/image_paths.dart';
import 'package:path/path.dart' as p;
import 'package:image/image.dart' as img;

class Similars extends StatefulWidget {
  final List<String> assetPaths;
  const Similars({super.key, required this.assetPaths});

  @override
  State<Similars> createState() => _SimilarsState();
}

class _SimilarsState extends State<Similars> {
  List<Photo> photos = [];

  List<String> images = imagePaths;

  List<List<String>> _similarImages = [];

  HashSet selectedItems = HashSet();
  int selectedPhotosetIndex = 0;

  Future<void> findSimilarImages(List<String> images) async {
    const url = 'http://10.50.20.134:5000/find_similar_images';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'images': images}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _similarImages = List<List<String>>.from(
            data['similar_images'].map((group) => List<String>.from(group)),
          );
        });
        debugPrint('Similar Images: $_similarImages');
      } else {
        try {
          final errorMessage = json.decode(response.body)['error'];
          debugPrint('Error: $errorMessage');
        } catch (e) {
          debugPrint('Error: ${response.reasonPhrase}, Body: ${response.body}');
        }
      }
    } catch (e) {
      debugPrint('Network Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    findSimilarImages(images);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Expanded(child: _scrollSnapList(screenWidth)),
          ElevatedButton(
              onPressed: () {
                // Handle delete action
              },
              child: Text("Delete ${selectedItems.length} images")),
        ],
      ),
    );
  }

  Widget _scrollSnapList(double screenWidth) {
    return Center(
      child: ScrollSnapList(
        itemBuilder: _buildListItem,
        itemCount: _similarImages.length,
        itemSize: screenWidth * 0.6,
        onItemFocus: (index) {
          setState(() {
            selectedPhotosetIndex = index;
          });
        },
        dynamicItemSize: true,
        duration: 10,
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isFocused = index == selectedPhotosetIndex;

    return SizedBox(
      width: screenWidth * 0.6,
      height: screenHeight * 0.8,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: isFocused
              ? const BorderSide(color: Colors.lightBlue, width: 3)
              : BorderSide.none,
        ),
        elevation: isFocused ? 15 : 5,
        child: _imageGroup(_similarImages[index]),
      ),
    );
  }

  Widget _imageGroup(List<String> imagePaths) {
    return Expanded(
      child: GridView.builder(
        itemCount: imagePaths.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemBuilder: (context, index) {
          return photoContainer(context, imagePaths, index);
        },
      ),
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

  Widget photoContainer(
      BuildContext context, List<String> imagePaths, int index) {
    String baseDir =
        'F:/Campus/5th semester/EE5454 Software Project/PhotoApp/PhotoApp/';
    List<String> relativePaths =
        imagePaths.map((path) => p.relative(path, from: baseDir)).toList();

    // Print relative paths
    for (String path in relativePaths) {
      print(path);
    } // Debug log
    return GridTile(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
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
                multiSelection(imagePaths[index]);
              },
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: selectedItems.contains(imagePaths[index])
                      ? Colors.blue
                      : Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Visibility(
                  visible: selectedItems.contains(imagePaths[index]),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}



// created this method  to get the test data list as a list of strings
// lib/image_paths.dart
// run => dart lib/image_paths.dart
// ===========================================================================================
// import 'dart:io';

// void main() {
//   final Directory dir = Directory('F:/Campus/5th semester/EE5454 Software Project/PhotoApp/PhotoApp/assets/Test_Data');
//   if (!dir.existsSync()) {
//     print('Directory does not exist.');
//     return;
//   }

//   final List<String> files = dir
//       .listSync()
//       .where((item) => item is File)
//       .map((item) => (item as File).absolute.path.replaceAll(r'\', '/'))
//       .toList();

//   final StringBuffer buffer = StringBuffer()
//     ..writeln('final List<String> imagePaths = [');
//   for (String file in files) {
//     buffer.writeln(" '$file',");
//   }
//   buffer.writeln('];');

//   final File output = File('lib/image_paths.dart');
//   output.writeAsStringSync(buffer.toString());
//   print('Generated image_paths.dart with ${files.length} assets.');
// }

// ===========================================================================================


