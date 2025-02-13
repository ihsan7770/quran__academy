import 'package:flutter/material.dart';
import 'package:quran__academy/other/Home/Home.dart';
import 'package:quran__academy/other/Home/homeweb/Home_web.dart';
import 'package:quran__academy/other/Home/homeweb/Web_Gallery.dart';
import 'package:quran__academy/other/Home/homeweb/webacademics/web_faculty.dart';
import 'package:quran__academy/other/Home/homeweb/webcharity/DonationPayWeb.dart';
import 'package:quran__academy/other/Home/homeweb/webcharity/DonationWeb.dart';
import 'package:quran__academy/other/Home/homeweb/webcharity/Web_charity.dart';
import 'package:quran__academy/other/Home/homeweb/web_about.dart';
import 'package:quran__academy/other/splash.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Set the font family globally
        fontFamily: 'Tino', // Apply Tinos font family globally
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: 'Home', // Ensure this matches the route below
      routes: {
        'Splash': (context) => Splash(),
        'Home': (context) => Home(),
        'HomeWeb': (context) => HomeWeb(),
        'About': (context) => About(),
        'Gallery_Web': (context) => Gallery_Web(),
        'CharityWeb':(context) => CharityWeb(),
        'DonationWeb':(context) => DonationWeb(),  
        'DonationPayWeb':(context) =>DonationPayWeb() ,
        // 'AcademicsWeb':(context) => AcademicsWeb(),
        'FacultyWeb':(context)=> FacultyWeb(),
       
      },
    );
  }
}
