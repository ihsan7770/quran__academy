import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran__academy/Widget%20class/container_green.dart';
import 'package:quran__academy/Widget%20class/theme.dart';

class AdmissionWeb extends StatefulWidget {
  const AdmissionWeb({super.key});

  @override
  State<AdmissionWeb> createState() => _AdmissionWebState();
}

class _AdmissionWebState extends State<AdmissionWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,

      body: Column(
        children: [
          GreenCondainer(),

          Column(
            children: [

              Text("Admission",style: TextStyle(fontSize: 20),)
            ],
          )


        ],
      ),



    );
  }
}