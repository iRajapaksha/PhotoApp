import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    getInitInfo();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: appBar(),
        endDrawer: endDrawer(context),
        body: Column(
          children: [
            Container(
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 200, 200, 200)),
              height: 35,
              width: 500,
              child: Row(
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset("assets/icons/arrow_left.svg")),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text("Gallery Manager"),
                ],
              ),
            ),
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
                Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                        height: 450,
                        width: 280,
                        //decoration: BoxDecoration(color: Colors.amberAccent),

                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              decoration:
                                  const BoxDecoration(color: Colors.amberAccent),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            _duplicatePhotos()
                          ],
                        ))
                  ],
                ),
                _defectedPhotos()
              ]),
            ),
            ElevatedButton(
                onPressed: () {},
                child: Text("Delete ${selectedItems.length} images")),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  Expanded _duplicatePhotos() {
    return Expanded(
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
                      //decoration: BoxDecoration(color: Colors.blueAccent),
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
                  )
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
          height: 90,
          width: 90,
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