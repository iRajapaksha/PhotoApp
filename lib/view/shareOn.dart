import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_app/components/navBar.dart';
import 'package:photo_app/models/Caption.dart';
import 'package:photo_app/models/Photo.dart';

class ShareOn extends StatelessWidget {
  final Photo selectedPhoto;
  final Caption selectedCaption;
  const ShareOn(
      {super.key, required this.selectedPhoto, required this.selectedCaption});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Text("Top Suggestions"),
            
              ],
            ),
          ),
          SizedBox(height: 50,),
          Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.amberAccent
                  ),
                ),
                SizedBox(height: 50,),
          Container(
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 181, 181, 181),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          
                          Icon(Icons.facebook),
                          Icon(Icons.email),
                          Icon(Icons.call),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: [
                          Icon(Icons.facebook),
                          Icon(Icons.email),
                          Icon(Icons.call),
                        ],
                      )
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
