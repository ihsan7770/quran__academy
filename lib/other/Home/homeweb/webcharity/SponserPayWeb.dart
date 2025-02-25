import 'package:flutter/material.dart';
import 'package:quran__academy/Widget%20class/container_green.dart';

class SponserPayWeb extends StatefulWidget {
  const SponserPayWeb({super.key});

  @override
  State<SponserPayWeb> createState() => _SponserPayWebState();
}

class _SponserPayWebState extends State<SponserPayWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        GreenCondainer(),
        Column(children: [
          Text('sposnsership stident details')


        
        
        ],)



      ],),




    );
  }
}