import 'package:flutter/material.dart';
import 'package:quran__academy/Widget%20class/drawer_white.dart';
import 'package:quran__academy/Widget%20class/theme.dart';


class Home_Phone extends StatefulWidget {
  const Home_Phone({super.key});

  @override
  State<Home_Phone> createState() => _Home_PhoneState();
}

class _Home_PhoneState extends State<Home_Phone> {
  // Create a GlobalKey to manage the Scaffold state
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Drawer widget
      drawer: Drawer_Whiter(),
      key: _scaffoldKey, // Assign the key to the Scaffold
      backgroundColor: AppColors.lightGreen,

      // Set up the Drawer Button in the AppBar
      body: Column(
        children: [
          SizedBox(height: 30,),
          Container(
            height: 90,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                // GestureDetector to open the Drawer when tapped
                GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState?.openDrawer(); // Open the drawer
                  },
                  child: Icon(Icons.menu, size: 30, color: Colors.black), // Drawer icon
                ),
                
                SizedBox(width: 10), // Space between the drawer icon and the text

                // Expanded Row for content
                Expanded(
                  child: Row(
                    children: [
                      Image.asset("assets/qa.png", width: 70), // Adjust image size
                    
                      Column(
                        children: [
                          SizedBox(height: 22,),
                          Text(
                            "KANNYALA SHIHAB THANGAL",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis, // Handle overflow text
                          ),
                          Text("   THAHFEELUL QURAN ACADEMY",style: TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis, )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    
    );
  }
}
