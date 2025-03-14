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
                        "Kannyala Shihab Thangal Thahfeelul Quran Academy warmly welcomes all invitations for special "
                        "occasions hosted in your homes. Whether it is a joyous marriage celebration, a blessed Iftar gathering "
                        "during Ramadan, or any other religious or social event, the academy appreciates being part of these "
                        "memorable moments. The students and faculty value these invitations as opportunities to strengthen "
                        "community bonds and share in the blessings of such occasions. Participating in these events allows the "
                        "students to experience the warmth of togetherness and contribute through their prayers and recitations. "
                        "The academy believes in fostering strong relationships with the community and cherishes every chance "
                        "to be involved in meaningful gatherings.",
                         textAlign: TextAlign.justify,
                    
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(width: 600,
                  
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
                                "Invite for Event",
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
                     
                               Padding(
  padding: const EdgeInsets.all(40.0),
  child: Container(
    height: 450,
    width: 450,
    decoration: BoxDecoration(
      color: Colors.amber,
      borderRadius: BorderRadius.circular(30),
      image: DecorationImage(
        image: AssetImage("assets/prayer.jpg"), // Replace with your actual asset path
        fit: BoxFit.cover, // Adjust how the image fits
      ),
    ),
  ),
),
//image condainer end         
                     
                     
                     
                     
                     
               ],),
                     



              //second row
               Row(children: [
                  SizedBox(width: 150,),
                //Image condainer starts
          Padding(
  padding: const EdgeInsets.all(40.0),
  child: Container(
    height: 450,
    width: 450,
    decoration: BoxDecoration(
      color: Colors.amber,
      borderRadius: BorderRadius.circular(30),
      image: DecorationImage(
        image: AssetImage("assets/money.jpg"), // Replace with your actual asset path
        fit: BoxFit.cover, // Adjust how the image fits
      ),
    ),
  ),
),
//image condainer end
                     
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
                      "Giving donations to the students of Kannyala Shihab Thangal Thahfeelul Quran Academy is a noble way "
                      "to support their education and well-being. Many students come from financially struggling families and "
                      "rely on generous contributions to continue their studies. Donations help provide essential needs such as "
                      "food, accommodation, study materials, and other necessities. The academy focuses on Quran "
                      "memorization along with academic education, shaping students into future scholars and community "
                      "leaders. Your support enables them to study without financial burdens and strengthens their connection "
                      "to faith. Every contribution, big or small, plays a vital role in their educational journey. Helping these "
                      "students is a great act of charity and ensures continuous rewards (Sadaqah Jariyah). The academy "
                      "emphasizes community support, encouraging kindness and generosity.",
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
                        "Sponsoring a student at Kannyala Shihab Thangal Thahfeelul Quran Academy for a year is a generous "
                        "act that covers all their educational and living expenses. Your sponsorship will provide them with food, "
                        "accommodation, study materials, and other essentials. This support allows the student to focus fully on "
                        "memorizing the Quran and their studies without any financial worries. By taking responsibility for one "
                        "student, you are directly shaping their future and contributing to their spiritual and academic growth. "
                        "Sponsorship ensures that they receive quality education in a nurturing environment. It is a great act of "
                        "charity and brings immense blessings to the donor. This noble gesture helps in producing future "
                        "scholars, imams, and leaders for the community. The academy values every sponsor’s contribution in "
                        "building an educated and pious generation",
                        
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
  padding: const EdgeInsets.all(40.0),
  child: Container(
    height: 450,
    width: 450,
    decoration: BoxDecoration(
      color: Colors.amber,
      borderRadius: BorderRadius.circular(30),
      image: DecorationImage(
        image: AssetImage("assets/spon.jpg"), // Replace with your actual asset path
        fit: BoxFit.cover, // Adjust how the image fits
      ),
    ),
  ),
),
//image condainer end        
                     
                     
                     
                     
                     
               ],),
                     
             ],
           ),
         ),
       ) ,// first  row donation
             
      
      
      
       
      
      
      ],),



    );
  }
}