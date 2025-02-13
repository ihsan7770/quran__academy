import 'package:flutter/material.dart';
import 'package:quran__academy/other/Widget%20class/container_green.dart';
import 'package:quran__academy/other/Widget%20class/theme.dart';

class ResultWeb extends StatefulWidget {
  const ResultWeb({super.key});

  @override
  State<ResultWeb> createState() => _ResultWebState();
}

class _ResultWebState extends State<ResultWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,

      body: Column(
        children: [
          GreenCondainer(),

          Column(
            children: [

              Text("RESULT",style: TextStyle(fontSize: 20),)
            ],
          )


        ],
      ),



    );
  }
}