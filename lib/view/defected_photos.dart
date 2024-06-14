import 'dart:collection';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_app/models/photo.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:photo_app/image_paths.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Defects extends StatefulWidget {
  const Defects({super.key});

  @override
  State<Defects> createState() => _DefectsState();
}

class _DefectsState extends State<Defects> {
  List<Photo> photos = [];
  HashSet selectedItems = HashSet();
  List<String> images = imagePaths;
  String? _result;
  List<File> _imageFiles = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadImages();
    _uploadImages();
    getInitInfo();
  }

  void getInitInfo() {
    photos = Photo.getPhotos();
  }

  // Upload images to the Flask server
  Future<void> _uploadImages() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://127.0.0.1:5001/upload'), // Change the URL to match your server
    );

    // Add each image file to the request
    for (var imageFile in _imageFiles) {
      request.files.add(await http.MultipartFile.fromPath('files[]', imageFile.path));
    }

    // Send the request and handle the response
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var decodedData = json.decode(responseData);
      print(decodedData); // Output the response from the server
    } else {
      print('Upload failed with status: ${response.statusCode}');
    }
  }

  void _loadImages() {
  
  // List<String> relativePaths = imagePaths.map((path) {
  //   // Extract the file name from the absolute path
  //   String fileName = path.split('/').last;
  //   // Construct the relative path by appending the file name to the directory
  //   return 'assets/Test_Data/$fileName';
  // }).toList();

  setState(() {
    // Create File objects from relative paths
    _imageFiles = images.map((path) => File(path)).toList();
  });
}


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Expanded(child: _imageGroup()),
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
        // Container(
        //               height: 200,
        //               decoration: const BoxDecoration(
        //                   color: Color.fromARGB(255, 64, 255, 109)),
        //             ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: GridView.builder(
              itemCount: photos.length,
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
    return GridTile(
      child: Stack(alignment: Alignment.bottomRight, children: [
        Container(
          height: 130,
          width: 150,
          color: Colors.blueAccent,
          child: Image.asset(
            photos[index].filePath,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: InkWell(
            onTap: () {
              multiSelection(photos[index].filePath);
            },
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: selectedItems.contains(photos[index].filePath)
                    ? Colors.blue
                    : Colors.white,
                shape: BoxShape.circle,
              ),
              child: Visibility(
                  visible: selectedItems.contains(photos[index].filePath),
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

// Expanded _scrollSnapList(double screenWidth) {
//     return Expanded(
//       child: Center(
//         child: ScrollSnapList(
//           itemBuilder: _buildListItem,
//           itemCount: 10,
//           itemSize: screenWidth * 0.6,

//           dynamicItemSize: true,
//           duration: 10, onItemFocus: (int ) {  },
//         ),
//       ),
//     );
//   }

//   Widget _buildListItem(BuildContext context, int index) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final photo = photos[index];
//     final isFocused = index ==1;
//     return SizedBox(
//       width: screenWidth * 0.6,
//       height: screenHeight * 0.8,
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//           side: isFocused
//               ? const BorderSide(color: Colors.lightBlue, width: 3)
//               : BorderSide.none,
//         ),
//         elevation: isFocused ? 15 : 5,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: Image.asset(
//             photo.filePath,
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }
}
