import 'package:flutter/material.dart';
import 'package:photo_app/components/button.dart';
import 'package:photo_app/components/heading.dart';
import 'package:photo_app/components/nav_bar.dart';
import 'package:photo_app/models/caption.dart';
import 'package:photo_app/models/photo.dart';
import 'package:photo_app/view/share_on.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:share_plus/share_plus.dart';

class TopSuggestionSelected extends StatefulWidget {
  final Photo selectedPhoto;
  const TopSuggestionSelected({super.key, required this.selectedPhoto});

  @override
  State<TopSuggestionSelected> createState() => _TopSuggestionSelectedState();
}

class _TopSuggestionSelectedState extends State<TopSuggestionSelected> {
  TextEditingController textController = TextEditingController();
  bool _isEditing = false;
  String caption = "";
  int selectedCaptionIndex = 0;
  List<Caption> captions = [];

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    _getInfo();
  }

  Future<void> _getInfo() async {
    var loadedCaptions = await Caption.getCaptions();
    if (loadedCaptions.isNotEmpty) {
      setState(() {
        captions = loadedCaptions;
        caption = captions[selectedCaptionIndex].description;
        textController.text = caption;
      });
    }
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBar(),
      endDrawer: endDrawer(context),
      body: captions.isEmpty
          ? Center(child: CircularProgressIndicator())
          : buildContent(screenWidth, screenHeight),
    );
  }

  Widget buildContent(double screenWidth, double screenHeight) {
    return SingleChildScrollView(
      child: Column(
        children: [
          heading(screenWidth, context, 'Sharing content'),
          SizedBox(height: 15),
          _imageContainer(),
          SizedBox(height: 10),
          _subHeading(),
          SizedBox(height: 10),
          _scrollSnapList(screenHeight),
          _editingContainer(screenWidth),
          SizedBox(height: 5),
          Button(onPressed: () => onPressed(context), title: 'Share')
        ],
      ),
    );
  }

  Text _subHeading() => const Text("Select a Caption",
      textAlign: TextAlign.left,
      style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
          color: Colors.black));

  Widget _editingContainer(double screenWidth) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(12.0),
      width: screenWidth * 0.95,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _isEditing
              ? Expanded(child: TextField(controller: textController))
              : Expanded(child: Text(caption)),
          GestureDetector(
              onTap: _toggleEdit,
              child: Icon(_isEditing ? Icons.check : Icons.edit))
        ],
      ),
    );
  }

  void _toggleEdit() {
    setState(() {
      if (_isEditing) {
        caption = textController.text;
      }
      _isEditing = !_isEditing;
      textController.text = caption;
    });
  }

  SizedBox _scrollSnapList(double screenHeight) {
    return SizedBox(
      height: 160,
      child: ScrollSnapList(
        itemBuilder: _buildListItem,
        itemCount: captions.length,
        itemSize: screenHeight * 0.07,
        onItemFocus: onCaptionSelect,
        dynamicItemSize: true,
        scrollDirection: Axis.vertical,
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
            child:
                Text(captions[index].description, textAlign: TextAlign.center)),
      ),
    );
  }

  void onCaptionSelect(int index) {
    setState(() {
      selectedCaptionIndex = index;
      caption = captions[index].description;
      textController.text = caption;
    });
  }

  void onPressed(BuildContext context) async {
    await Share.share(textController.text);
    // return Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ShareOn(
    //       selectedPhoto: widget.selectedPhoto,
    //       selectedCaption: textController.text
    //     )));
  }

  SizedBox _imageContainer() {
    return SizedBox(
      height: 300,
      child: Image.asset(widget.selectedPhoto.filePath, fit: BoxFit.cover),
    );
  }
}
