import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photo_app/components/heading.dart';
import 'package:photo_app/components/nav_bar.dart';
import 'package:photo_app/models/photo.dart';
import 'package:photo_app/view/defected_photos.dart';
import 'package:photo_app/view/duplicate_photos.dart';
import 'package:photo_app/view/similar_photos.dart';

class GalleryManager extends StatefulWidget {
  final List<String> assetPaths ;
  const GalleryManager({super.key, required this.assetPaths});

  @override
  State<GalleryManager> createState() => _GalleryManagerState();
}

class _GalleryManagerState extends State<GalleryManager> {
  List<Photo> photos = [];

  HashSet selectedItems = HashSet();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: appBar(),
        endDrawer: endDrawer(context),
        body: Column(
          children: [
            heading(screenWidth, context, 'Gallery Manager'),
            const TabBar(
              indicatorColor: Colors.white, // Change the indicator color here
              labelColor:
                  Colors.blueAccent, // Change the selected tab text color here
              tabs: [
                
                Tab(
                  text: "Defected",
                ),
                Tab(
                  text: "Similar",
                ),
              ],
            ),
            Expanded(
              child: TabBarView(children: [
                Defects(),
                Similars(assetPaths: widget.assetPaths),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
