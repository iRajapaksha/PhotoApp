import 'package:flutter/material.dart';
import 'package:photo_app/components/button.dart';
import 'package:photo_app/components/heading.dart';
import 'package:photo_app/components/nav_bar.dart';
import 'package:photo_app/models/photo.dart';
import 'package:photo_app/view/caption_selection.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class TopSuggestions extends StatefulWidget {
  const TopSuggestions({super.key});

  @override
  State<TopSuggestions> createState() => _TopSuggestionsState();
}

class _TopSuggestionsState extends State<TopSuggestions> {
  int selectedPhotoIndex = 0;
  late List<Photo> photos;

  @override
  void initState() {
    super.initState();
    _getInitInfo();
  }

  void _getInitInfo() {
    photos = Photo.getPhotos();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBar(),
      endDrawer: endDrawer(context),
      body: Column(
        children: [
          heading(screenWidth, context, 'Top Suggestions'),
          const SizedBox(height: 30),
          _scrollSnapList(screenWidth),
          const SizedBox(height: 10),
          Button(onPressed: () {onPressed(context);},title: 'Select',),
          const SizedBox(height: 10),
          _imageDescription(),
        ],
      ),
    );
  }

  Column _imageDescription() {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          title: Text(
            "Taken On: ${photos[selectedPhotoIndex].dateTime}",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Roboto',
              color: Colors.black87,
            ),
          ),
        ),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          title: Text(
            "File Info: ${photos[selectedPhotoIndex].fileName}",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Roboto',
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> onPressed(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TopSuggestionSelected(
          selectedPhoto: photos[selectedPhotoIndex],
        ),
      ),
    );
  }

  Expanded _scrollSnapList(double screenWidth) {
    return Expanded(
      child: Center(
        child: ScrollSnapList(
          itemBuilder: _buildListItem,
          itemCount: photos.length,
          itemSize: screenWidth * 0.6,
          onItemFocus: (index) {
            setState(() {
              selectedPhotoIndex = index;
            });
          },
          dynamicItemSize: true,
          duration: 10,
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final photo = photos[index];
    final isFocused = index == selectedPhotoIndex;
    return SizedBox(
      width: screenWidth * 0.6,
      height: screenHeight * 0.8,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: isFocused
              ? const BorderSide(color: Colors.lightBlue, width: 3)
              : BorderSide.none,
        ),
        elevation: isFocused ? 15 : 5,
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
