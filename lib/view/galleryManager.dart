import 'package:flutter/material.dart';
import 'package:photo_app/components/navBar.dart';

class GalleryManager extends StatefulWidget {
  const GalleryManager({super.key});

  @override
  State<GalleryManager> createState() => _GalleryManagerState();
}

class _GalleryManagerState extends State<GalleryManager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      endDrawer: endDrawer(context),
    );
  }
}
