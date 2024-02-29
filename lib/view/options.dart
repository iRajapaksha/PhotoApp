import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_app/components/nav_bar.dart';

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
                const BoxDecoration(color: Color.fromARGB(255, 200, 200, 200)),
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
                const Text("Options"),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 200, 200, 200),
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
                          fontSize: 20,
                          fontWeight: FontWeight.w500,

                        ),
                      ),
                    ),
                    const Center(child: Icon(Icons.cloud , size: 75,)),
                    Center(
                      child: Container(
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 233, 237, 235),
                          borderRadius: BorderRadius.circular(7.5)
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Padding(
                              padding: EdgeInsets.only(left:15),
                              child: Text("Username"),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left:15),
                              child: Text("username@gmail.com"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                          onPressed: () {}, style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Adjust the radius here
                        ),
                      ), child: const Text("Manage Account"),),
                    ),
                    Center(
                      child: ElevatedButton(onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Renamed backgroundColor to primary

                      ),
                      child: const Text("Backup", style: TextStyle(
                        color: Colors.white
                      ),  ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 285,
                width: 300,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 200, 200, 200),
                  borderRadius: BorderRadius.circular(7.5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Settings",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize:20,
                        fontWeight: FontWeight.w500,

                      ),
                      ),
                    ),
                    const Center(child: Icon(Icons.settings, size: 75,)),
                    Center(child: ElevatedButton(onPressed: () {},style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Adjust the radius here
                      ),
                    ), child: const Text("Storage"),)),
                    Center(child: ElevatedButton(onPressed: () {},style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Adjust the radius here
                      ),
                    ), child: const Text("About"),)),
                    Center(child: ElevatedButton(onPressed: () {},style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Adjust the radius here
                      ),
                    ), child: const Text("Privacy"),)),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
