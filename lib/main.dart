import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quran__academy/Admin/Admin_View_Complaints.dart';
import 'package:quran__academy/other/Home/homephone/Home_Phone.dart';
import 'package:quran__academy/other/Home/homephone/Login_Phone.dart';
import 'package:quran__academy/other/Home/homephone/Register_student_phn.dart';
import 'package:quran__academy/other/Home/homephone/Student_profile_phn.dart';
import 'package:quran__academy/other/Home/homeweb/webcharity/WebSponsership.dart';

import 'firebase_options.dart';





// Importing screens
import 'package:quran__academy/Admin/AddEvents.dart';
import 'package:quran__academy/Admin/admin_home_phn.dart';
import 'package:quran__academy/other/Home/Home.dart';
import 'package:quran__academy/other/Home/homeweb/Home_web.dart';
import 'package:quran__academy/other/Home/homeweb/Web_Gallery.dart';
import 'package:quran__academy/other/Home/homeweb/webacademics/web_faculty.dart';
import 'package:quran__academy/other/Home/homeweb/webcharity/DonationPayWeb.dart';
import 'package:quran__academy/other/Home/homeweb/webcharity/DonationWeb.dart';
import 'package:quran__academy/other/Home/homeweb/webcharity/Web_charity.dart';
import 'package:quran__academy/other/Home/homeweb/web_about.dart';
import 'package:quran__academy/other/splash.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
 
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Tino', // Ensure the font is added in pubspec.yaml
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: 'Home', // Ensure this matches a valid route
      routes: {
        'Splash': (context) => Splash(),
        'Home': (context) => Home(),
        'HomeWeb': (context) => HomeWeb(),
        'Home_Phone':(context) => Home_Phone(),
        'About': (context) => About(),
        'Gallery_Web': (context) => Gallery_Web(),  
        'CharityWeb': (context) => CharityWeb(),
        'DonationWeb': (context) => DonationWeb(),
        'DonationPayWeb': (context) => DonationPayWeb(),
        'FacultyWeb': (context) => FacultyWeb(),
        'AdminHomePhn': (context) => AdminHomePhn(),
        'AddEvents': (context) => AddEvents(),
        'LoginPhone':(context) =>  LoginPhone(),
        'StudentRegistration':(context) => StudentRegistration() ,
        'StudentProfile':(context) => StudentProfile(),
        'AdminComplaints':(context) => AdminComplaints(),
        'SponsershipWeb':(context) => SponsershipWeb(),


        
        
      },
    );
  }
}
