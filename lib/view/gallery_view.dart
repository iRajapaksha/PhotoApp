import 'package:flutter/material.dart';
import 'package:photo_app/components/asset_thumbnail.dart';
import 'package:photo_app/components/heading.dart';
import 'package:photo_app/components/nav_bar.dart';
import 'package:photo_app/view/caption_selection.dart';
import 'package:photo_manager/photo_manager.dart';
import '../models/photo.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({super.key});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  List<AssetEntity> assets = [];
  List<Photo> photos = []; // Initialize photos list

  double screenWidth = 0; // Define screenWidth variable

  Future<void> _fetchAssets() async {
    final allAssets =
        await PhotoManager.getAssetListRange(start: 0, end: 100000);
    setState(() {
      assets =
          allAssets.where((asset) => asset.type == AssetType.image).toList();
    });
  }

  void initState() {
    super.initState();
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
