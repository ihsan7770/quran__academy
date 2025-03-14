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
                            "Kannyala Shihab Thangal Thahfeelul Quran Academy is a dedicated Hifz college offering a"
                            "comprehensive four-year course for students aspiring to become Hafiz. The structured curriculum "
                            "ensures that students complete the memorization of the Quran progressively, with 8 Juz’ in the first"
                            "year, 10 Juz’ in the second year, and 12 Juz’ in the third year. The fourth year is dedicated to revision and "
                            "reinforcement of memorization. Alongside Quranic studies, the academy also provides formal school "
                            "education, ensuring academic growth. Students are encouraged to participate in arts and sports,"
                            "fostering a well-rounded personality. The academy also emphasizes leadership and communication"
                            "skills, training students to become Imams for Jumu’ah and Taraweeh prayers. Personality development is"
                            "a key focus, helping students gain confidence and discipline. The institution nurtures moral values, "
                            "etiquette, and social responsibility. Highly experienced teachers provide guidance, ensuring quality"
                            "education. The serene and disciplined learning environment enhances concentration and commitment."
                            "Graduates emerge as confident individuals, well-versed in both religious and academic knowledge."
                            ,
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
                          ),
                ),

                SizedBox(width:   100,),
   Container(
               height: 390,
               width: 350,
               decoration: BoxDecoration(
              //  color: Colors.amber,
               borderRadius: BorderRadius.circular(30),
               image: DecorationImage(
               image: AssetImage('assets/oth.jpg'), // Replace with your image path
               fit: BoxFit.cover, // Adjust the fit as needed
                       ),
                  ),
            )

               
                   
              ],
            ),


          ],)

        
   
         
        
       
        ],
      ), 
      

    );
  }
}