import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quran__academy/other/Widget%20class/container_green.dart';
import 'package:quran__academy/other/Widget%20class/theme.dart';


class Gallery_Web extends StatefulWidget {
  const Gallery_Web({super.key});

  @override
  State<Gallery_Web> createState() => _Gallery_WebState();
}

class _Gallery_WebState extends State<Gallery_Web> with TickerProviderStateMixin {
    late AnimationController _controllerLeft;
  late AnimationController _controllerRight;
  late Animation<Offset> _animationLeft;
  late Animation<Offset> _animationRight;

  @override
  void initState() {
    super.initState();

    _controllerLeft = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _controllerRight = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animationLeft = Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controllerLeft, curve: Curves.easeInOut));

    _animationRight = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controllerRight, curve: Curves.easeInOut));

    _controllerLeft.forward();
    _controllerRight.forward();
  }

  @override
  void dispose() {
    _controllerLeft.dispose();
    _controllerRight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: AppColors.lightGreen,
      body: Column(
        
        children: [
          GreenCondainer(),
          
          
         
      
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                    children: [
                      Container(
                        height: 550,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/buld.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 550,
                        width: double.infinity,
                        color: Colors.black.withOpacity(0.7),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SlideTransition(
                              position: _animationLeft,
                              child: const Text(
                                "EXPLORE OUR STUNNING",
                                style: TextStyle(fontSize: 40, color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SlideTransition(
                              position: _animationRight,
                              child: const Text(
                                "GALLERY",
                                style: TextStyle(fontSize: 40, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
         
                     
              //end 
              SizedBox(height: 100,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: [

                   Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                    height: 450,
                    width: 450,
                    decoration: BoxDecoration(
                   color: Colors.amber,
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                    image: AssetImage('assets/buld.jpg'), // Replace with your image path
                    fit: BoxFit.cover, // Ensures the image covers the container
                     ),
                           ),
                               ),
                                    ),
        

                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                    height: 450,
                    width: 450,
                    decoration: BoxDecoration(
                   color: Colors.amber,
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                    image: AssetImage('assets/buld.jpg'), // Replace with your image path
                    fit: BoxFit.cover, // Ensures the image covers the container
                     ),
                           ),
                               ),
                                    ),
                  

                       Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                    height: 450,
                    width: 450,
                    decoration: BoxDecoration(
                   color: Colors.amber,
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                    image: AssetImage('assets/buld.jpg'), // Replace with your image path
                    fit: BoxFit.cover, // Ensures the image covers the container
                     ),
                           ),
                               ),
                                    ),
        
                              
                     
              
              ],),
            ],
          ),




          
        ),
      )
      
      
      
      
      ],),




    );
  }
}