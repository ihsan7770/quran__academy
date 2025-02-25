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
                          backgroundColor: Colors.amberAccent,
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
                            "Kannyala Shihab Thangal Thahfeelul Quran Academy is a Hifz college or an educational "
                            "institution of higher religious learning, equivalent to a North Indian madrasa, located at "
                            "Kannyala Pattikkad, near Perinthalmanna in the Malappuram district of Kerala. "
                            "Established in 2017 by the Shihab Thangal Charitable Trust, the academy was affiliated with "
                            "Jamia Nooriya Arabiyya in 2022. It became the fifth affiliated Hifz college under Jamia Nooriya Arabiyya. "
                            "The academy is a premier orthodox Sunni-Shafi'i institution for the training of Islamic scholars in Kerala. "
                            "It upholds the old Ponnani tradition of scholar training. The Nizami curriculum employed at Jamia Nooriya "
                            "is a modified version of the syllabus used at the al-Baqiyyat-us-Salihat College in Vellore, with Shafi'i Law replacing Hanafi Law.",
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
                          radius: 150,
                          backgroundColor: Colors.amberAccent,
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
                            "Kannyala Shihab Thangal Thahfeelul Quran Academy is a Hifz college or an educational "
                            "institution of higher religious learning, equivalent to a North Indian madrasa, located at "
                            "Kannyala Pattikkad, near Perinthalmanna in the Malappuram district of Kerala. "
                            "Established in 2017 by the Shihab Thangal Charitable Trust, the academy was affiliated with "
                            "Jamia Nooriya Arabiyya in 2022. It became the fifth affiliated Hifz college under Jamia Nooriya Arabiyya. "
                            "The academy is a premier orthodox Sunni-Shafi'i institution for the training of Islamic scholars in Kerala. "
                            "It upholds the old Ponnani tradition of scholar training. The Nizami curriculum employed at Jamia Nooriya "
                            "is a modified version of the syllabus used at the al-Baqiyyat-us-Salihat College in Vellore, with Shafi'i Law replacing Hanafi Law.",
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