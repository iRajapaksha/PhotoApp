import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class AssetThumbnail extends StatelessWidget {
  final AssetEntity asset;
  const AssetThumbnail({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    //if(asset.type == AssetType.image)
    return FutureBuilder<Uint8List>(
      future: asset.thumbnailData.then((value) => value!),
      builder: (_, snapshot) {
        final bytes = snapshot.data;
        if (bytes == null) return const CircularProgressIndicator();
        return InkWell(
          onTap: (){
            
          },
          child: Image.memory(bytes, fit: BoxFit.cover,));
      },
    );
  }
}