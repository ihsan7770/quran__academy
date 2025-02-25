import 'package:flutter/material.dart';
import 'package:quran__academy/Widget%20class/container_green.dart';
import 'package:quran__academy/Widget%20class/theme.dart';

class FacilityWeb extends StatefulWidget {
  const FacilityWeb({super.key});

  @override
  State<FacilityWeb> createState() => _FacilityWebState();
}

class _FacilityWebState extends State<FacilityWeb> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.lightGreen,

      body: Column(
        children: [
          GreenCondainer(),

          Column(
            children: [

              Text("Facility",style: TextStyle(fontSize: 20),)
            ],
          )


        ],
      ),



    );
  }
}