import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:io';
import 'package:image/image.dart' as img;

Future<List<File>> _fetchGalleryAssets() async {
  List<String> assetPaths = [];
  List<File> imageFiles = [];

  // Fetch the list of asset paths
  final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
    type: RequestType.image,
    filterOption: FilterOptionGroup(
      containsPathModified: true,
      orders: [OrderOption(type: OrderOptionType.createDate, asc: false)],
    ),
  );

  // Find the path entity for the "Gallery" album
  AssetPathEntity? galleryPath;
  for (var path in paths) {
    if (path.name.toLowerCase() == "gallery") {
      galleryPath = path;
      break;
    }
  }

  if (galleryPath != null) {
    final int assetCount = await galleryPath.assetCountAsync;
    final List<AssetEntity> assets = await galleryPath.getAssetListRange(
      start: 0,
      end: assetCount,
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
    }
    assetPaths = pathsList;
    imageFiles = files;
    print(assetPaths[0]);

    return imageFiles;
  } else {
    print("Gallery album not found");
    return imageFiles;
  }
}

Future<List<File>> _scanForGalleryImages() async {
  // Get the external storage directory
  final directory = Directory(
      '/storage/emulated/0/DCIM'); // Change to 'Pictures' if necessary

  List<File> imageFiles = [];

  // Check if the directory exists
  if (await directory.exists()) {
    // Recursively scan the directory for image files
    await for (FileSystemEntity entity in directory.list(recursive: true)) {
      if (entity is File &&
          (entity.path.endsWith('.jpg') || entity.path.endsWith('.png'))) {
        imageFiles.add(entity);
      }
    }
  } else {
    print("Directory does not exist");
  }

  return imageFiles;
}


List<List<List<double>>> preprocessImage(File imageFile) {
  // Load image from file
  img.Image image = img.decodeImage(imageFile.readAsBytesSync())!;

  // Resize image to 224x224
  img.Image resizedImage = img.copyResize(image, width: 224, height: 224);

  // Normalize pixel values
  List<List<List<double>>> input = List.generate(
    224,
    (i) => List.generate(
      224,
      (j) {
        int pixel = resizedImage.getPixel(j, i) as int;
        double r = ((pixel >> 16) & 0xFF) / 255.0;  // Extract red
        double g = ((pixel >> 8) & 0xFF) / 255.0;   // Extract green
        double b = (pixel & 0xFF) / 255.0;          // Extract blue
        return [r, g, b];
      },
    ),
  );

  return input;
}