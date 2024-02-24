import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photo_app/view/topSuggestionSelected.dart';
import '../models/Photo.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({Key? key}) : super(key: key);

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  List<Photo> photos = [];
  int? selectedPhotoIndex;

  @override
  void initState() {
    super.initState();
    _getInitInfo();
  }

  void _getInitInfo() {
    photos = Photo.getPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
      ),
      body: FutureBuilder<List<String>>(
        future: _loadImages(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<String>? imagePaths = snapshot.data;
            if (imagePaths == null || imagePaths.isEmpty) {
              return const Center(child: Text('No images found.'));
            }
            return GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: imagePaths.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPhotoIndex = index;
                    });
                    _showImagePreview(context, imagePaths[index]);
                  },
                  child: Image(image: AssetImage(imagePaths[index])),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<String>> _loadImages(BuildContext context) async {
    final manifestContent = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    return manifestMap.keys
        .where((String key) => key.startsWith('assets/images/'))
        .toList();
  }

  void _showImagePreview(BuildContext context, String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImagePreviewScreen(
          imagePath: imagePath,
          selectedPhotoIndex: selectedPhotoIndex,
          photos: photos,
        ),
      ),
    );
  }
}

class ImagePreviewScreen extends StatelessWidget {
  final String imagePath;
  final int? selectedPhotoIndex;
  final List<Photo> photos;

  const ImagePreviewScreen({
    Key? key,
    required this.imagePath,
    required this.selectedPhotoIndex,
    required this.photos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage(imagePath)),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 30,
                  child: Expanded(child: Container()), // Empty container takes up remaining space
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedPhotoIndex != null && selectedPhotoIndex! < photos.length) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TopSuggestionSelected(selectedPhoto: photos[selectedPhotoIndex!]),
                            ),
                          );
                        }
                      },
                      child: const Text('Share'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
