import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_app/components/navBar.dart';
import 'package:photo_app/models/Caption.dart';
import 'package:photo_app/models/Photo.dart';
import 'package:photo_app/view/shareOn.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class TopSuggestionSelected extends StatefulWidget {
  final Photo selectedPhoto;
  const TopSuggestionSelected({Key? key, required this.selectedPhoto}) : super(key: key);

  @override
  State<TopSuggestionSelected> createState() => _TopSuggestionSelectedState();
}

class _TopSuggestionSelectedState extends State<TopSuggestionSelected> {
  int selectedCaptionIndex = 0;
  List<Caption> captions = [];

  void _getInfo() {
    captions = Caption.getCaptions();
  }

  @override
  Widget build(BuildContext context) {
    _getInfo();
    return Scaffold(
      appBar: appBar(),
      endDrawer: endDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Color.fromARGB(255, 200, 200, 200)),
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
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 300,
              //decoration: BoxDecoration(color: Colors.amberAccent),
              child: Image.asset(
                widget.selectedPhoto.filePath,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Select a Caption",
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 150,
              child: ScrollSnapList(
                itemBuilder: _buildListItem,
                itemCount: captions.length,
                itemSize: 60,
                onItemFocus: (index) {
                  setState(() {
                    selectedCaptionIndex = index;
                  });
                },
                dynamicItemSize: true,
                scrollDirection: Axis.vertical,
              ),
            ),
            Text(captions[selectedCaptionIndex].description),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ShareOn(
                        selectedPhoto : widget.selectedPhoto,
                        selectedCaption: captions[selectedCaptionIndex],
                      )));
                },
                child: Text(
                  "Share",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    minimumSize: const Size(120, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))))
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    Caption caption = captions[index];
    return SizedBox(
      height: 60,
      width: 80,
      child: Card(
        elevation: 20,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Text(
            caption.description,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
