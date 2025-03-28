import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quran__academy/Widget%20class/container_green.dart';
import 'package:quran__academy/Widget%20class/theme.dart';

class FacultyWeb extends StatefulWidget {
  const FacultyWeb({super.key});

  @override
  State<FacultyWeb> createState() => _FacultyWebState();
}

class _FacultyWebState extends State<FacultyWeb> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: Column(
        children: [
          GreenCondainer(),
          
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
              
                  Row(
                    children: [
                     Padding(
                       padding: EdgeInsets.all(20.0),
                       child: CircleAvatar(
                         radius: 150,
                         backgroundImage: AssetImage('assets/m11.png'),
                       ),
                             ),

              
              
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 3,right: 1,top: 50,bottom: 10),
                            child: Text("Hafil Suhail Wafy",style: TextStyle(fontSize: 50),),
              
                          ),
              
                            SizedBox(
                          width: 800,
                          child: Text(
                            "Hafil Suhail Wafy is a dedicated educator currently serving as a teacher at Kannyala Shihab Thangal"
                            "Thahfeelul Quran Academy, where he specializes in teaching Hifz (Quran memorization). With a strong "
                            "academic background, he completed his higher studies at Jamia Nooriya, gaining in-depth knowledge "
                            "in Islamic studies. His passion for education and leadership led him to take on the roles of both a "
                            "principal and a teacher, guiding students with wisdom and commitment. Through his experience and "
                            "dedication, he continues to inspire and shape the next generation of scholars ",
                           
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
                          ),
                        ),
              
                        ],
                      ),
                        
                      
              
                    ],
                  ),
              
              
                   Row(
                    children: [
                       Padding(
                       padding: EdgeInsets.all(20.0),
                       child: CircleAvatar(
                         radius: 140,
                         backgroundImage: AssetImage('assets/m22.png'),
                       ),
                             ),
              
              
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 3,right: 1,top: 50,bottom: 10),
                            child: Text("Mohammed Saleem",style: TextStyle(fontSize: 50),),
              
                          ),
              
                            SizedBox(
                          width: 800,
                          child: Text(
                            "Mohammed Saleem is a dedicated teacher who plays a vital role in educating students in both academic "
                            "and religious studies. He teaches school subjects as well as Hifz and other Madrasa classes, ensuring a "
                            "well-rounded education for his students. With a strong foundation in Islamic studies, he graduated from "
                            "Nandhi Darusalam, equipping himself with the knowledge and skills needed to guide and mentor young "
                            "learners. His commitment to education and his passion for teaching make him a respected and valued "
                            "educator in his community. ",
                           
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
                          ),
                        ),
              
                        ],
                      ),
                        
                      
              
                    ],
                  ),

                   Row(
                    children: [
                       Padding(
                       padding: EdgeInsets.all(20.0),
                       child: CircleAvatar(
                         radius: 140,
                         backgroundImage: AssetImage('assets/m33.png'),
                       ),
                             ),
              
              
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 3,right: 1,top: 50,bottom: 10),
                            child: Text("KP Azeez",style: TextStyle(fontSize: 50),),
              
                          ),
              
                            SizedBox(
                          width: 800,
                          child: Text(
                            "KP Azeez is the financial manager at Kannyala Shihab Thangal Thahfeelul Quran Academy, responsible "
                            "for overseeing all financial transactions, including incoming and outgoing funds. With his expertise in"
                            "financial management, he ensures the academy's resources are utilized efficiently and transparently. His "
                            "role is crucial in budgeting, expense tracking, and maintaining financial stability, allowing the institution"
                            "to function smoothly and continue its mission of providing quality education. Through his dedication"
                            "and meticulous management, he plays a vital role in the academy’s growth and sustainability ",
                           
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
                          ),
                        ),
              
                        ],
                      ),
                        
                      
              
                    ],
                  )













              
              
                ],
              ),
            ),
          )




        ],


      ),
    );
  }
}