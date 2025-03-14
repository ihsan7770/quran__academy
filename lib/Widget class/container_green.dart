import 'package:flutter/material.dart';
import 'package:quran__academy/other/Home/homeweb/AdmissionWeb/AdmissionWeb.dart';
import 'package:quran__academy/other/Home/homeweb/Home_web.dart';
import 'package:quran__academy/other/Home/homeweb/Web_Gallery.dart';
import 'package:quran__academy/other/Home/homeweb/web_about.dart';
import 'package:quran__academy/other/Home/homeweb/webacademics/CourseWeb.dart';
import 'package:quran__academy/other/Home/homeweb/webacademics/FacilityWeb.dart';
import 'package:quran__academy/other/Home/homeweb/webacademics/web_faculty.dart';
import 'package:quran__academy/other/Home/homeweb/webcharity/Web_charity.dart';

import 'package:quran__academy/Widget%20class/theme.dart';


class GreenCondainer extends StatefulWidget {
  const GreenCondainer({super.key});

  @override
  State<GreenCondainer> createState() => _GreenCondainerState();
}

class _GreenCondainerState extends State<GreenCondainer> {
   double size= 25;
   String DropDownValue ='Academics';
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            height: 90,
            width: double.infinity,
            child: Row(children: [
              Image.asset("assets/qa.png"),
              Text("KANNYALA SHIHAB THANGAL THAHFEELUL QURAN ACADEMY",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20 ),),

            

              


            
            ],),
          ),
          



          Container(
            color: AppColors.greens, 
            width: double.infinity,
            height: 30,
            alignment: Alignment.center, // Center content
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Align text to center
              children:  [
                
               
                Row(  mainAxisAlignment: MainAxisAlignment.center,
                  
                  children: [

                    InkWell(
                      onTap: () {
                         Navigator.pushNamed(context, 'Home_Web');
                        
                      },
                      child: InkWell(
                        onTap: () {

                           Navigator.push(
                                         context,
                               MaterialPageRoute(builder: (context) => HomeWeb()),
                                                                   );
                          
                          
                        },
                        child: Text(
                          "Home",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(width:size),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => About()),
                          );
                        },
                        child: Text(
                        "About",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                                            ),
                      ),
                    
                                   SizedBox(width: size,),

                                      InkWell(
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) =>CourseWeb ()),
                          );
                        },
                        child: Text(
                        "Courses",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                                            ),
                      ),
                       SizedBox(width: size,),
                                     InkWell(
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) =>FacultyWeb()),
                          );
                        },
                        child: Text(
                        "Faculty",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                                            ),
                      ),
                          SizedBox(width: size,),
                                     InkWell(
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => FacilityWeb()),
                          );
                        },
                        child: Text(
                        "Facility",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                                            ),
                      ),


                                  

                        
                              
             
                     
                    
                      SizedBox(width: size,),
                      InkWell(
                        onTap: () {
                           Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CharityWeb()),
                          );
                          

                        },
                        child: Text(
                        "Charity",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                                            ),
                      ),

                      SizedBox(width: size,),
                      InkWell(
                        hoverColor: Colors.amberAccent,
                        onTap: () {
                          Navigator.push(
                                         context,
                               MaterialPageRoute(builder: (context) => Gallery_Web()),
                                                                   );
                          
                        },
                        child: Text(
                        "Gallery",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                                            ),
                      ),




                  ],
                ),




              ],
            ),
          ),
        ],
      );
  }
}










