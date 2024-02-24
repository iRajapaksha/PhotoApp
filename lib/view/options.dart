import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_app/components/navBar.dart';

class Options extends StatelessWidget {
  const Options({super.key});

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
                Text("Options"),
              ],
            ),
          ),
          SizedBox(
            height: 70,
          ),
          Container(
            child: Column(
              children: [
                Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 200, 200, 200),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Backup",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            
                          ),
                        ),
                      ),
                      Center(child: Icon(Icons.cloud , size: 100,)),
                      Center(
                        child: Container(
                          height: 50,
                          width: 250,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 233, 237, 235),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                              Padding(
                                padding: const EdgeInsets.only(left:10),
                                child: Text("Username"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:10),
                                child: Text("username@gmail.com"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {}, child: Text("Manage Account")),
                      ),
                      Center(
                        child: ElevatedButton(onPressed: () {},
                        child: Text("Backup", style: TextStyle(
                          color: Colors.white
                        ),  ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue, // Renamed backgroundColor to primary
                        
                        ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 200, 200, 200),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Settings",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize:20,
                          fontWeight: FontWeight.w500,
                          
                        ),
                        ),
                      ),
                      Center(child: Icon(Icons.settings, size: 100,)),
                      Center(child: ElevatedButton(onPressed: () {}, child: Text("Storage"))),
                      Center(child: ElevatedButton(onPressed: () {}, child: Text("About"))),
                      Center(child: ElevatedButton(onPressed: () {}, child: Text("Privacy"))),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
