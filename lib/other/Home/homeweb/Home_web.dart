import 'package:flutter/material.dart';

import 'package:quran__academy/Widget%20class/animation_up_event.dart';
import 'package:quran__academy/Widget%20class/container_green.dart';
import 'package:quran__academy/Widget%20class/last_condainer.dart';
import 'package:quran__academy/Widget%20class/map.dart';
import 'package:quran__academy/Widget%20class/theme.dart';


//"com.example.quran_academy"

class HomeWeb extends StatefulWidget {
  const HomeWeb({super.key});

  @override
  State<HomeWeb> createState() => _HomeWebState();
}

class _HomeWebState extends State<HomeWeb> with TickerProviderStateMixin {
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
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: Column(
        children: [
          const GreenCondainer(),

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
                                "KANNYALA SHIHAB THANGAL THAHFEELUL",
                                style: TextStyle(fontSize: 40, color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SlideTransition(
                              position: _animationRight,
                              child: const Text(
                                "QURAN ACADEMY",
                                style: TextStyle(fontSize: 40, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  Container(
                    color: AppColors.lightGreen,
                    height: 180,
                    width: screenWidth > 1500 ? 1500 : screenWidth * 0.95,
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
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

                  const SizedBox(width: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 17),
                      const Text(
                        "Events",
                        style: TextStyle(fontSize: 60, fontWeight: FontWeight.w100),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, 'About');
                    },
                    child:  AnimatedEventList(),//Event animation
                  ),
                  const SizedBox(height: 200),

                  // Horizontal Scrolling Section
                  Container(
                    
                    decoration: BoxDecoration(
                              color: AppColors.wtgreen,
                              borderRadius: BorderRadius.circular(25),
                            ),
                    width: 1400,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            
                            height: 500,
                            width: 600,
                            decoration: BoxDecoration(
                              color: AppColors.brown,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: CircleAvatar(
                                radius: 180,
                                backgroundColor: Colors.white,
                                child: Image.asset("assets/qa.png"),
                              ),
                            ),
                          ),
                          const SizedBox(width: 200),
                          SizedBox(
                            width: 530, // Fixed width for text
                            child: const Padding(
                              padding: EdgeInsets.all(45.0),
                              child: Text(
                                "Kannyala Shihab Thangal Thahfeelul Quran Academy is committed to developing well-rounded "
                                "leaders who excel in both religious and secular realms. The college’s "
                                "unique blend of Qur'anic education and academic excellence "
                                "empowers students to become confident, knowledgeable, and "
                                "spiritually grounded individuals, ready to face the challenges of the "
                                "modern world.\n\n"
                                "By fostering a strong sense of faith, academic achievement, and "
                                "personal integrity, Kannyala Shihab Thangal Thahfeelul Quran Academy  "
                                "continues to shape the future of Islamic scholarship and leadership.",
                                textAlign: TextAlign.justify,
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 200),

                   MapImage(),//google map code
                   const SizedBox(height: 200),
                   Last_Container(),




                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
