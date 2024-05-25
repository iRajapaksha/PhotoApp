import 'package:flutter/material.dart';
import 'package:photo_app/components/asset_thumbnail.dart';
import 'package:photo_app/components/heading.dart';
import 'package:photo_app/components/nav_bar.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryView extends StatefulWidget {
  final List<String> assetPaths ;
  const GalleryView({super.key, required this.assetPaths});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  List<AssetEntity> assets = [];
 // List<Photo> photos = []; // Initialize photos list

  //double screenWidth = 0; // Define screenWidth variable

  // Future<void> _fetchAssets() async {
  //   final allAssets =
  //       await PhotoManager.getAssetListRange(start: 0, end: 100000);
  //   setState(() {
  //     assets =
  //         allAssets.where((asset) => asset.type == AssetType.image).toList();
  //   });
  // }

  Future<void> _fetchAssets() async {
    assets = await PhotoManager.getAssetListRange(start: 0, end: 100000);
    setState(() {});
  }

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
                crossAxisCount: 3,
              ),
              itemCount: assets.length,
              itemBuilder: (_, index) {
                return AssetThumbnail(
                  asset: assets[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
