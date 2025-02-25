import 'package:flutter/material.dart';
import 'package:quran__academy/other/Home/homephone/Login_Phone.dart';


class Drawer_Whiter extends StatefulWidget {
  const Drawer_Whiter({super.key});

  @override
  State<Drawer_Whiter> createState() => _Drawer_WhiterState();
}

class _Drawer_WhiterState extends State<Drawer_Whiter> {
  @override
  Widget build(BuildContext context) {
    return// Drawer widget
       Drawer(
        backgroundColor: Colors.white,
        
        child: ListView(
          children: <Widget>[
            SizedBox(height: 30,),
            // Drawer header could be added here if necessary
          
            ListTile(
              title: Text('Home'),
              onTap: () {
                // Add actions for drawer items here
              },
            ),
              Divider(
              endIndent: 30,
              ),


            ListTile(
              title: Text('About'),
              onTap: () {
                // Add actions for drawer items here
              },
            ),
              Divider(
              endIndent: 30,
              ),
            ListTile(
              title: Text('Academics'),
              onTap: () {
                // Add actions for drawer items here
              },
            ),
               Divider(
              endIndent: 30,
              ),

            ListTile(
              title: Text('Charity'),
              onTap: () {
                // Add actions for drawer items here
              },
            ),
              Divider(
              endIndent: 30,
              ),
            ListTile(
              title: Text('Gallery'),
              onTap: () {
                // Add actions for drawer items here
              },
            ),

             Divider(
              endIndent: 30,
              ),

            ListTile(
              title: Text('Login'),
              onTap: () {
                    Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPhone()),
                          );
              },
            ),
            Divider(
              
              endIndent: 30,
              
            ),
          ],
        ),
      );
  }
}