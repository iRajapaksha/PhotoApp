import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_app/components/navBar.dart';
import 'package:photo_app/models/Photo.dart';

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

  HashSet selectedItems = new HashSet();
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
                  BoxDecoration(color: Color.fromARGB(255, 200, 200, 200)),
              height: 35,
              width: 500,
              child: Row(
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset("assets/icons/arrow_left.svg")),
                  SizedBox(
                    width: 8,
                  ),
                  Text("Gallery Manager"),
                ],
              ),
            ),
            TabBar(tabs: [
              Tab(
                text: "Duplicate",
              ),
              Tab(
                text: "Defected",
              ),
            ]),
            Expanded(
              child: TabBarView(children: [
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                        height: 500,
                        width: 300,
                        //decoration: BoxDecoration(color: Colors.amberAccent),

                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              decoration:
                                  BoxDecoration(color: Colors.amberAccent),
                            ),
                            SizedBox(
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
                            )
                          ],
                        ))
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 300,
                      width: 300,
                      //  decoration: BoxDecoration(color: Colors.blueAccent),
                    )
                  ],
                )
              ]),
            ),
            ElevatedButton(
                onPressed: () {}, child: Text("Clear the selected images")),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  void multiSelection(String path) {
    setState(() {
      if (selectedItems.contains(path)) {
      selectedItems.remove(path);
    } else
      selectedItems.add(path);
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
              child: Visibility(
                visible: selectedItems.contains(photos[index].filePath),
                child: Icon(Icons.check_rounded, color: Colors.black,)
                ),
              decoration: BoxDecoration(
                color: selectedItems.contains(photos[index].filePath) ? Colors.blue : Colors.white,
                shape: BoxShape.circle,
                
              ),
            ),
          ),
        )
      ]),
    );
  }
}
