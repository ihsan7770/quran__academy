import 'package:flutter/material.dart';
import 'package:quran__academy/other/Home/homephone/Home_Phone.dart';
import 'package:quran__academy/other/Home/homephone/Login_Phone.dart';
import 'package:quran__academy/other/Home/homeweb/Home_web.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return  LayoutBuilder(
      builder: (context,constraints){
        if(constraints.maxWidth>950){
          return HomeWeb();
        }
        else {
          return LoginPhone();


        }


    }
    );


  }
}