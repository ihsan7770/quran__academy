import 'package:flutter/material.dart';
import 'package:quran__academy/Widget%20class/container_green.dart';
import 'package:quran__academy/Widget%20class/theme.dart';

class CourseWeb extends StatefulWidget {
  const CourseWeb({super.key});

  @override
  State<CourseWeb> createState() => _CourseWebState();
}

class _CourseWebState extends State<CourseWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: AppColors.lightGreen,
      body: Column(
        children: [
          GreenCondainer(),

          Column(
        
            
            children: [
              
            Column(
              
              children: [
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 170,),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text("Courses",style:TextStyle(fontSize: 50) ,),
                    ),
                  ],
                ),
              ],
            ),

            Row(
              children: [
                SizedBox(width: 180,),
                SizedBox(
                  width: 700,
                  height: 400,
                  child: Text(
                            "Kannyala Shihab Thangal Thahfeelul Quran Academy is a Hifz college or an educational "
                            "institution of higher religious learning, equivalent to a North Indian madrasa, located at "
                            "Kannyala Pattikkad, near Perinthalmanna in the Malappuram district of Kerala. "
                            "Established in 2017 by the Shihab Thangal Charitable Trust, the academy was affiliated with "
                            "Jamia Nooriya Arabiyya in 2022. It became the fifth affiliated Hifz college under Jamia Nooriya Arabiyya. "
                            "The academy is a premier orthodox Sunni-Shafi'i institution for the training of Islamic scholars in Kerala. "
                            "It upholds the old Ponnani tradition of scholar training. The Nizami curriculum employed at Jamia Nooriya "
                            "is a modified version of the syllabus used at the al-Baqiyyat-us-Salihat College in Vellore, with Shafi'i Law replacing Hanafi Law."
                             "The academy is a premier orthodox Sunni-Shafi'i institution for the training of Islamic scholars in Kerala. "
                            "It upholds the old Ponnani tradition of scholar training. The Nizami curriculum employed at Jamia Nooriya "
                            ,
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
                          ),
                ),

                SizedBox(width:   100,),

                 Container(
                    height:390,
                    width: 350,
                    
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(30)),
                  
                  ),

               
                   
              ],
            ),


          ],)

        
   
         
        
       
        ],
      ), 
      

    );
  }
}