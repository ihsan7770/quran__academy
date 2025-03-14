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
              
            Column(
              
              children: [
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 170,),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text("Facility",style:TextStyle(fontSize: 50) ,),
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
                            "Kannyala Shihab Thangal Thahfeelul Quran Academy provides a nurturing and well-equipped"
                            "environment for its 20 students, ensuring their complete academic and spiritual development. The "
                            "academy offers full residential facilities, including comfortable accommodations designed to create a "
                            "peaceful atmosphere for Quranic studies. Each student is provided with essential amenities, ensuring a "
                            "stress-free and focused learning experience. The academy also includes a well-maintained dining hall  "
                            "where students receive nutritious and balanced meals daily. Special attention is given to hygiene and "
                            "dietary requirements to promote good health. A spacious and serene masjid is located within the "
                            "premises, allowing students to perform their daily prayers and engage in spiritual activities without any "
                            "distractions. Beyond religious education, the academy fosters discipline, character building, and "
                            "leadership skills, preparing students to take on roles such as imams and scholars. The presence of "
                            "experienced mentors and scholars ensures high-quality education and moral guidance. Additionally, the "
                            "academy integrates modern educational subjects alongside Hifz training, ensuring a well-rounded "
                            "curriculum. The environment is designed to cultivate a deep connection with the Quran while also"
                            "fostering personal and academic growth. With dedicated teachers, structured schedules, and supportive"
                            "infrastructure, the academy stands as a model institution for those pursuing both religious and worldly"
                            "knowledge."
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
               image: AssetImage('assets/palli.jpg'), // Replace with your image path
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