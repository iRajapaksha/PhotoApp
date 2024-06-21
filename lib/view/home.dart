import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_app/image_paths.dart';
import 'package:photo_app/view/gallery_manager.dart';
import 'package:photo_app/view/home_app_info.dart';
import 'package:photo_app/view/top_suggestions.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_app/components/nav_bar.dart';
import 'package:photo_app/view/gallery_view.dart';
import 'package:photo_app/Backend/image_search.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> assetPaths = [];
  List<File> imageFiles = [];
  double progress = 0.0;

  Future<void> _fetchAssets() async {
    final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
      type: RequestType.image,
    );

    if (paths.isNotEmpty) {
      final List<AssetEntity> assets = await paths[0].getAssetListRange(
        start: 0,
        end: 100000, // Adjust the range based on your requirement
      );

      final List<String> pathsList = [];
      final List<File> files = [];
      int totalAssets = assets.length;
      for (int i = 0; i < totalAssets; i++) {
        final AssetEntity asset = assets[i];
        final File? file = await asset.file;
        if (file != null) {
          files.add(file);
          pathsList.add(file.path);
        }
        // Update progress
        setState(() {
          progress = (i + 1) / totalAssets;
        });
      }

      setState(() {
        assetPaths = pathsList;
        imageFiles = files;
        print(assetPaths[0]);
      });
    }
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
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBar(),
      endDrawer: endDrawer(context),
      body:
          // Not working for the emulator but works for the device
          //=============================================================================
          // assetPaths.isEmpty && progress < 1.0
          //     ? Center(
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             CircularProgressIndicator(
          //               value: progress,
          //             ),
          //             SizedBox(height: 20),
          //             Text('${(progress * 100).toStringAsFixed(0)}%'),
          //           ],
          //         ),
          //       )
          //     :
              //============================================================================
              Stack(
                  children: [
                    // Background image
                    // Positioned.fill(
                    //   child: Image.asset(
                    //     'assets/icons/background.jpg',
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          width: screenWidth * 0.9,
                          height: screenHeight * 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const HomeAppInfo(),
                              _buildMenuButton(
                                context,
                                "Top Suggestions",
                                Icons.thumb_up,
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const TopSuggestions(),
                                    ),
                                  );
                                },
                              ),
                              _buildMenuButton(
                                context,
                                "Gallery Manager",
                                Icons.photo_album,
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GalleryManager(
                                          assetPaths: assetPaths),
                                    ),
                                  );
                                },
                              ),
                              _buildMenuButton(
                                context,
                                "PicScout",
                                Icons.search,
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SearchPage(),
                                    ),
                                  );
                                },
                              ),
                              _buildMenuButton(
                                context,
                                "Gallery",
                                Icons.image,
                                () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) =>
                                          GalleryView(assetPaths: assetPaths, imageFiles: imageFiles)));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  void onPressedGallery(BuildContext context) {
    PhotoManager.requestPermissionExtend().then((PermissionState state) {
      if (state.isAuth) {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (_) => GalleryView(assetPaths: assetPaths, imageFiles: imageFiles,)),
        );
      }
    });
  }

  Widget _buildMenuButton(BuildContext context, String text, IconData iconData,
      VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          shadowColor: Colors.black,
          elevation: 15,
          minimumSize: const Size(100, 45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: const BorderSide(color: Colors.black), // Add black margin
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Icon(
              iconData,
              size: 30,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
