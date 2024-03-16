import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_app/components/heading.dart';
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
  TextEditingController textController = TextEditingController();
  bool _isEditing = false;
  String editedCaption = '';
  String caption = '';
  int selectedCaptionIndex = 0;
  List<Caption> captions = [];

  void _getInfo() {
    captions = Caption.getCaptions();
    caption = captions[selectedCaptionIndex].description;
    //editedCaption = textController.text;
  }

  @override
  void dispose() {
    // Dispose the text editing controller when the widget is disposed
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    _getInfo();
    return Scaffold(
      appBar: appBar(),
      endDrawer: endDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            heading(screenWidth, context, 'Sharing content'),
            const SizedBox(
              height: 15,
            ),
            _imageContainer(),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Select a Caption",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            _scrollSnapList(screenHeight),
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(12.0),
              width: screenWidth * 0.95,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _isEditing
                      ? Expanded(
                          child: TextField(
                            controller: textController,
                            onChanged: (value) {
                              setState(() {
                                editedCaption = value;
                                caption = editedCaption;
                              });
                            },
                          ),
                        )
                      : Text(caption),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isEditing = !_isEditing;
                        if (!_isEditing) {
                          caption = textController.text;
                        }
                      });
                    },
                    child: Icon(
                      _isEditing ? Icons.check : Icons.edit,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShareOn(
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

  SizedBox _scrollSnapList(double screenHeight) {
    return SizedBox(
      height: 160,
      child: ScrollSnapList(
        itemBuilder: _buildListItem,
        itemCount: captions.length,
        itemSize: screenHeight * 0.07,
        onItemFocus: (index) {
          setState(() {
            selectedCaptionIndex = index;
          });
        },
        dynamicItemSize: true,
        scrollDirection: Axis.vertical,
      ),
    );
  }

  SizedBox _imageContainer() {
    return SizedBox(
      height: 300,
      child: Image.asset(
        widget.selectedPhoto.filePath,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    Caption caption = captions[index];
    bool isFocused = index == selectedCaptionIndex;
    return SizedBox(
      height: screenHeight * 0.07,
      width: screenWidth * 0.8,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
                color: isFocused ? Colors.lightBlue : Colors.transparent,
                width: 3)),
        elevation: isFocused ? 15 : 5,
        child: Center(
          // Center widget added here
          child: Text(
            caption.description,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
