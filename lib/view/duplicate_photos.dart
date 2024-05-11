import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:photo_app/models/photo.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class Duplicates extends StatefulWidget {
  const Duplicates({super.key});

  @override
  State<Duplicates> createState() => _DuplicatesState();
}

class _DuplicatesState extends State<Duplicates> {
  List<Photo> photos = [];
  HashSet selectedItems = HashSet();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInitInfo();
  }

  void getInitInfo() {
    photos = Photo.getPhotos();
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
    Container(
                  height: 200,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 64, 255, 109)),
                ),
      const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: GridView.builder(
                      itemCount: photos.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
          child: Image.asset(photos[index].filePath,fit: BoxFit.cover,),
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
                color: selectedItems.contains(photos[index].filePath) ? Colors.blue : Colors.white,
                shape: BoxShape.circle,

              ),
              child: Visibility(
                  visible: selectedItems.contains(photos[index].filePath),
                  child: const Icon(Icons.check_rounded, color: Colors.black,)
              ),
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
