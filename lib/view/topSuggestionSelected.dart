import 'package:flutter/material.dart';
import 'package:photo_app/components/navBar.dart';
import 'package:photo_app/models/Caption.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class TopSuggestionSelected extends StatefulWidget {
  const TopSuggestionSelected({super.key});

  @override
  State<TopSuggestionSelected> createState() => _TopSuggestionSelectedState();
}

class _TopSuggestionSelectedState extends State<TopSuggestionSelected> {
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
          Container(
            height: 300,
            //decoration: BoxDecoration(color: Colors.amberAccent),
            child: Image.asset("assets/images/2.png", fit: BoxFit.cover,),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Select a Caption",
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 10,),
          SizedBox(
            height: 150,
            child: ScrollSnapList(
                itemBuilder: _buildListItem,
                itemCount: captions.length,
                itemSize: 60,
                onItemFocus: (index) {},
                dynamicItemSize: true,
                scrollDirection: Axis.vertical,),
          ),
          TextField(),
          SizedBox(height: 15,),
          ElevatedButton(
            onPressed: (){},
            child: Text("Share",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),),
            style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                minimumSize: const Size(120, 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)))
                    )
        ],
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
          child: Text(caption.description, textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}
