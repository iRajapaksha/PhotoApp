// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:photo_app/view/caption_selection.dart';
// import '../models/photo.dart';

// class GalleryView extends StatefulWidget {
//   const GalleryView({super.key});

//   @override
//   State<GalleryView> createState() => _GalleryViewState();
// }

// class _GalleryViewState extends State<GalleryView> {
//   List<Photo> photos = [];
//   int? selectedPhotoIndex;

//   @override
//   void initState() {
//     super.initState();
//     _getInitInfo();
//   }

//   void _getInitInfo() {
//     photos = Photo.getPhotos();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Gallery'),
//       ),
//       body: FutureBuilder<List<String>>(
//         future: _loadImages(context),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             List<String>? imagePaths = snapshot.data;
//             if (imagePaths == null || imagePaths.isEmpty) {
//               return const Center(child: Text('No images found.'));
//             }
//             return GridView.builder(
//               scrollDirection: Axis.horizontal,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 crossAxisSpacing: 4.0,
//                 mainAxisSpacing: 4.0,
//               ),
//               itemCount: imagePaths.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedPhotoIndex = index;
//                     });
//                     _showImagePreview(context, imagePaths[index]);
//                   },
//                   child: Image(image: AssetImage(imagePaths[index])),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }

//   Future<List<String>> _loadImages(BuildContext context) async {
//     final manifestContent = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
//     final Map<String, dynamic> manifestMap = json.decode(manifestContent);
//     return manifestMap.keys
//         .where((String key) => key.startsWith('assets/images/'))
//         .toList();
//   }

//   void _showImagePreview(BuildContext context, String imagePath) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ImagePreviewScreen(
//           imagePath: imagePath,
//           selectedPhotoIndex: selectedPhotoIndex,
//           photos: photos,
//         ),
//       ),
//     );
//   }
// }

// class ImagePreviewScreen extends StatelessWidget {
//   final String imagePath;
//   final int? selectedPhotoIndex;
//   final List<Photo> photos;

//   const ImagePreviewScreen({
//     super.key,
//     required this.imagePath,
//     required this.selectedPhotoIndex,
//     required this.photos,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image(image: AssetImage(imagePath)),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 SizedBox(
//                   height: 30,
//                   child: Container(), // Empty container takes up remaining space
//                 ),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: SizedBox(
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         if (selectedPhotoIndex != null && selectedPhotoIndex! < photos.length) {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => TopSuggestionSelected(selectedPhoto: photos[selectedPhotoIndex!]),
//                             ),
//                           );
//                         }
//                       },
//                       child: const Text('share'),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:photo_app/components/asset_thumbnail.dart';
import 'package:photo_app/components/heading.dart';
import 'package:photo_app/components/nav_bar.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({super.key});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  List<AssetEntity> assets = [];

  Future<void> _fetchAssets() async {
    assets = await PhotoManager.getAssetListRange(start: 0, end: 100000);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchAssets();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar(),
      endDrawer: endDrawer(context),
      body: Column(
        children: [
          heading(screenWidth, context, "Gallery"),
          Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: assets.length,
                itemBuilder: (_, index) {
                  return AssetThumbnail(
                    asset: assets[index],
                  );
                }),
          )
        ],
      ),
    );
  }
}
