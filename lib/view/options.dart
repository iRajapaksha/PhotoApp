import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_app/components/button.dart';
import 'package:photo_app/components/heading.dart';
import 'package:photo_app/components/nav_bar.dart';

class Options extends StatelessWidget {
  const Options({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: appBar(),
        endDrawer: endDrawer(context),
        body: Stack(
          children: [
            Container(
              decoration:const  BoxDecoration(
               
                  image:  DecorationImage(
                      image: AssetImage('assets/icons/background.jpg'),
                      fit: BoxFit.cover)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                heading(screenWidth, context, 'Options'),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Container(
                      height: screenHeight*0.4,
                      width: screenWidth*0.8,
                      decoration: BoxDecoration(
                         border:  Border.all(
                                  color: const Color.fromRGBO(144, 224, 239, 1)
                                ),
                        color: Colors.blueAccent.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(7.5),
                        
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Backup",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Center(
                              child: Icon(
                            Icons.cloud,
                            size: 100,
                          )),
                          Center(
                            child: Container(
                              height: 50,
                              width: 250,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color.fromRGBO(144, 224, 239, 1)
                                ),
                                  color:
                                      Colors.blueAccent.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(7.5)),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text("Username"),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text("username@gmail.com"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                fixedSize: Size(screenWidth*0.7, screenHeight*0.05),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      30), // Adjust the radius here
                                ),
                              ),
                              child: const Text("Manage Account", style: TextStyle(
                                color: Colors.black,
                                fontSize: 18
                              ),),
                            ),
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                fixedSize: Size(screenWidth*0.7, screenHeight*0.05),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)
                                ),
                                backgroundColor: Colors.white 
                              ),
                              child: const Text(
                                "Backup",
                                style: TextStyle(color: Colors.black,fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: screenHeight*0.4,
                      width: screenWidth*0.8,
                      decoration: BoxDecoration(
                      border:  Border.all(
                                  color: const Color.fromRGBO(144, 224, 239, 1)
                                ),
                        color: Colors.blueAccent.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(7.5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Settings",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Center(
                              child: Icon(
                            Icons.settings,
                            size: 100,
                          )),
                          Center(
                              child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              fixedSize: Size(screenWidth*0.7, screenHeight*0.05),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    30), // Adjust the radius here
                              ),
                            ),
                            child: const Text("Storage",style: TextStyle(
                              color: Colors.black,
                              fontSize: 18
                            ),),
                          )),
                          Center(
                              child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              fixedSize: Size(screenWidth*0.7, screenHeight*0.05),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    30), 
                              ),
                            ),
                            child: const Text("Privacy",style: TextStyle(
                              color: Colors.black,
                              fontSize: 18
                            ),),
                          )
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ));
  }
}
