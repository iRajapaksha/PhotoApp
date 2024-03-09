import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_app/components/nav_bar.dart';
import 'package:photo_app/models/caption.dart';
import 'package:photo_app/models/photo.dart';
import 'package:photo_app/view/share_on.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class TopSuggestionSelected extends StatefulWidget {
  final Photo selectedPhoto;
  const TopSuggestionSelected({super.key, required this.selectedPhoto});

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
              decoration: const BoxDecoration(
              color: Color.fromARGB(255, 200, 200, 200)),
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
                  const Text(
                    "Sharing content",
                    style: TextStyle(
                      color: Colors.black, // Change font color to white
                      fontSize: 16, // Optionally, adjust font size
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 300,
              //decoration: BoxDecoration(color: Colors.amberAccent),
              child: Image.asset(
                widget.selectedPhoto.filePath,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Select a Caption",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto', // Example: custom font family
                color: Colors.black,
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 160,
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
            Container(
              margin: const EdgeInsets.only(top: 10.0), // Adjust margin to move the box down
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              width: 350,
              decoration: BoxDecoration(
                color: Colors.black12, // Example: Box color
                borderRadius: BorderRadius.circular(10), // Example: Rounded corners
              ),
              child: Text(
                captions[selectedCaptionIndex].description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto', // Example: custom font family
                  color: Colors.black,
                  fontWeight: FontWeight.normal, // Example: normal font weight
                  fontStyle: FontStyle.italic, // Example: italic font style
                  letterSpacing: 1.0, // Example: spacing between letters
                  // Add more text style properties as needed
                ),
              ),
            ),




            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>
                          ShareOn(
                            selectedPhoto: widget.selectedPhoto,
                            selectedCaption: captions[selectedCaptionIndex],
                          )));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    minimumSize: const Size(120, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: const Text(
                  "Share",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ))
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
        elevation: 35,
        child: Center( // Center widget added here
          child: Text(
            caption.description,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
