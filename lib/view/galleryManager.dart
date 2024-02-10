import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_app/components/navBar.dart';

class GalleryManager extends StatefulWidget {
  const GalleryManager({super.key});

  @override
  State<GalleryManager> createState() => _GalleryManagerState();
}

class _GalleryManagerState extends State<GalleryManager> {
  @override
  Widget build(BuildContext context) {
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
            TabBar(
              tabs: [
                Tab(text: "Duplicate",),
                Tab(text: "Defected",),
              ]),
              Expanded(
                child: TabBarView(children: [
                  Column(
                    children: [
                    SizedBox(height: 50,),
                      Container(
                        height: 500,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent
                        ),
                      )

                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: 50,),
                        Container(
                        height: 500,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent
                        ),
                      )
                    ],
                  )
                ]),
              ),
              ElevatedButton(
                onPressed: (){},
                child: Text("Clear the selected images")),
                SizedBox(height: 100,),
          ],
          
        ),
        
      ),
    );
  }
}
