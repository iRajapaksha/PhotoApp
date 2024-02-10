import 'package:flutter/material.dart';
import 'package:photo_app/components/navBar.dart';
import 'package:photo_app/models/Photo.dart';
import 'package:photo_app/view/topSuggestionSelected.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class TopSuggestions extends StatefulWidget {
  const TopSuggestions({super.key});

  @override
  State<TopSuggestions> createState() => _TopSuggestionsState();
}

class _TopSuggestionsState extends State<TopSuggestions> {
  List<Photo> photos = [];

  void _getInitInfo() {
    photos = Photo.getPhotos();
  }

  @override
  Widget build(BuildContext context) {
    _getInitInfo();
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
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Text("Top Suggestions"),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 300,
            child: Center(
              child: ScrollSnapList(
                itemBuilder: _buildListItem,
                itemCount: photos.length,
                itemSize: 200,
                onItemFocus: (index) {},
                dynamicItemSize: true,
                duration: 10,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TopSuggestionSelected()));
            },
            child: Text(
              "Select",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                minimumSize: const Size(150, 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: Text("Taken On : "),
          ),
          ListTile(
            title: Text("File Info : "),
          )
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    Photo photo = photos[index];
    return SizedBox(
      width: 200,
      height: 300,
      child: Card(
        elevation: 12,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            photo.filePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
