import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quran__academy/Widget%20class/container_green.dart';
import 'package:quran__academy/Widget%20class/theme.dart';
import 'package:quran__academy/other/Home/homeweb/webcharity/DonationPayWeb.dart';

class DonationWeb extends StatefulWidget {
  const DonationWeb({super.key});

  @override
  State<DonationWeb> createState() => _DonationWebState();
}

class _DonationWebState extends State<DonationWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        GreenCondainer(),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
        
          children: [
    Padding(
  padding: const EdgeInsets.all(30.0),
  child: Container(
    height: 540,
    width: 500,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(30), // Ensures the image follows the rounded corners
      child: Image.asset(
        "assets/buld.jpg",
        fit: BoxFit.cover,
      ),
    ),
  ),
),
Column(
  
  children: [
  

  Text("Empowering Lives Through Charity",
       style: TextStyle(fontSize: 50),),
       Text("Making a Difference Together",
       style: TextStyle(fontSize: 30),),
  SizedBox(height: 20,),
   SizedBox(
    width: 800,
    height: 300,
     child: Text(
                        "Kannyala Shihab Thangal Thahfeelul Quran Academy is a charitable educational institution "
                        "dedicated to providing free religious education and Hifz (Quran memorization) training to "
                        "students. Established in 2017 by the Shihab Thangal Charitable Trust, the academy operates with "
                        "the mission of supporting underprivileged students by offering quality Islamic education"
                        "without financial barriers. Through generous donations and community support, it ensures"
                        "access to religious learning while upholding the rich scholarly traditions of Kerala. The "
                        "institution emphasizes the values of charity, community service, and knowledge sharing,"
                        "fostering a new generation of scholars committed to both faith and social responsibility..",
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
                      ),
   ),

                    Padding(
                      padding: const EdgeInsets.only(left: 700,right: 10,bottom: 1,top: 1),
                      child: ElevatedButton(
                                      onPressed: () {
                        Navigator.push(
                                           context,
                                 MaterialPageRoute(builder: (context) => DonationPayWeb()),
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



],)
        
         
          
        
          ],
        )




      
      ],),
      
      



    );
  }
}