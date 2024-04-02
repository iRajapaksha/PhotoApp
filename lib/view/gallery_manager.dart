import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photo_app/components/heading.dart';
import 'package:photo_app/components/nav_bar.dart';
import 'package:photo_app/models/photo.dart';

class GalleryManager extends StatefulWidget {
  const GalleryManager({super.key});

  @override
  State<GalleryManager> createState() => _GalleryManagerState();
}

class _GalleryManagerState extends State<GalleryManager> {
  List<Photo> photos = [];


  void getInitInfo() {
    photos = Photo.getPhotos();
  }

  HashSet selectedItems =  HashSet();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    getInitInfo();
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
              labelColor: Colors.blueAccent, // Change the selected tab text color here
              tabs: [
                Tab(
                  text: "Duplicate",
                ),
                Tab(
                  text: "Defected",
                ),
              ],
            ),

            Expanded(
              child: TabBarView(children: [
                _duplicatePhotos(),
                _defectedPhotos()
              ]),
            ),
            
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  Column _duplicatePhotos() {
    return Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      height: 450,
                      width: 280,
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            decoration:
                                const BoxDecoration(color: Color.fromARGB(255, 64, 255, 109)),
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
                        ElevatedButton(
                onPressed: () {},
                child: Text("Delete ${selectedItems.length} images")),
                        ],
                      ))
                ],
              );
  }



  Column _defectedPhotos() {
    return Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 300,
                    width: 300,
                    child: MasonryGridView.builder(
                              itemCount: photos.length,
                              gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3
                                ),
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 5,
                                itemBuilder: (context, index) {
                                  return photoContainer(context, index);
                                }),
                  ),
                  ElevatedButton(
                onPressed: () {},
                child: Text("Delete ${selectedItems.length} images")),
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
}