import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quran__academy/other/Home/homeweb/webcharity/EventBookingFeild.dart';
import 'package:quran__academy/other/Home/homeweb/webcharity/DonationWeb.dart';
import 'package:quran__academy/Widget%20class/container_green.dart';
import 'package:quran__academy/Widget%20class/theme.dart';
import 'package:quran__academy/other/Home/homeweb/webcharity/ViewEventsBooked.dart';
import 'package:quran__academy/other/Home/homeweb/webcharity/WebSponsership.dart';

class CharityWeb extends StatefulWidget {
  const CharityWeb({super.key});

  @override
  State<CharityWeb> createState() => _CharityWebState();
}

class _CharityWebState extends State<CharityWeb> {
  @override
  Widget build(BuildContext context) {
    return 
Scaffold(
   backgroundColor: AppColors.lightGreen,
      body: Column(children: [
       const GreenCondainer(),
      
      
       
       Expanded(
         child: SingleChildScrollView(
           child: Column(
             children: [
              Row(children: [
                  SizedBox(width: 150,),
                //Image condainer starts
                     
                     
                   Column(
                children: [
                  SizedBox(
                     width: 700,
                     height: 600,
                     child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [
                  SizedBox(height: 60,),
                  
              
                   Padding(
                     padding: const EdgeInsets.only(right: 1,left: 30,bottom: 1,top: 1),
                     child: Text("Charity",style:TextStyle(fontSize: 50) ,),
                   ),

                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Expanded(
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
                  ),
                  SizedBox(width: 800,
                  
                  ),
                 
                  Padding(
                    padding: const EdgeInsets.only(left: 40,right: 20,bottom: 1,top: 1),
                    child: ElevatedButton(
                              onPressed: () {

                        Navigator.push(context,
                               MaterialPageRoute(builder: (context) => ViewEventBooked()),
                                                                   );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.greens, // Button color (change to your desired color)
                                shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero, // Square corners
                                ),
                              ),
                              child: Text(
                                "Book Event",
                                style: TextStyle(
                            color: Colors.white, // Text color
                            fontSize: 27
                                ),
                              ),
                            ),
                  ),
                     
                     
                     
                     
                     
                     
                ],
                     ),
                  ),
                     
                  
                ],
                     ),
                     
                               //Image condainer starts
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    height:450,
                    width: 450,
                    
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(30)),
                  
                  ),
                ),//image condainer end           
                     
                     
                     
                     
                     
               ],),
                     



              //second row
               Row(children: [
                  SizedBox(width: 150,),
                //Image condainer starts
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Container(
                    height:450,
                    width: 450,
                    
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(30)),
                  
                  ),
                ),//image condainer end
                     
                   Column(
                children: [
                  SizedBox(
                     width: 700,
                     height: 400,
                     child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
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
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child:ElevatedButton(
                onPressed: () {
                      Navigator.push(
                                         context,
                               MaterialPageRoute(builder: (context) => DonationWeb()),
                                                                   );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.greens, // Button color (change to your desired color)
                  shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.zero, // Square corners
                  ),
                ),
                child: Text(
                  "Donate",
                  style: TextStyle(
                     color: Colors.white, // Text color
                     fontSize: 27
                  ),
                ),
                     ),
                     
                  ),
                ],
                     ),
                  ),
                ],
                     )
                     
                          
                     
                     
                     
                     
                     
               ],) ,// secondrow donation
                     
                     
             Row(children: [
                  SizedBox(width: 150,),
                //Image condainer starts
                     
                     
                   Column(
                children: [
                  SizedBox(
                     width: 700,
                     height: 490,
                     child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [
                  
              
                   

                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Expanded(
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
                  ),
                  SizedBox(width: 800,
                  
                  ),
                 
                  Padding(
                    padding: const EdgeInsets.only(left: 40,right: 20,bottom: 1,top: 1),
                    child: ElevatedButton(
                              onPressed: () {
                                 Navigator.push(context,
                               MaterialPageRoute(builder: (context) => SponsershipWeb()),
                                                                   ); // Add your donate button action here
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.greens, // Button color (change to your desired color)
                                shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero, // Square corners
                                ),
                              ),
                              child: Text(
                                "Sponsership",
                                style: TextStyle(
                            color: Colors.white, // Text color
                            fontSize: 27
                                ),
                              ),
                            ),
                  ),
                     
                     
                     
                     
                     
                     
                ],
                     ),
                  ),
                     
                  
                ],
                     ),
                     
                               //Image condainer starts
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    height:450,
                    width: 450,
                    
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(30)),
                  
                  ),
                ),//image condainer end           
                     
                     
                     
                     
                     
               ],),
                     
             ],
           ),
         ),
       ) ,// first  row donation
             
      
      
      
       
      
      
      ],),



    );
  }
}