import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quran__academy/Widget%20class/Eventcond.dart';
import 'package:quran__academy/Widget%20class/animation_up_event.dart';
import 'package:quran__academy/Widget%20class/map.dart';
import 'package:quran__academy/Widget%20class/theme.dart';
import 'package:quran__academy/other/Home/homeweb/Home_web.dart';
import 'package:quran__academy/other/Home/homeweb/Web_Gallery.dart';
import 'package:quran__academy/other/Home/homeweb/web_about.dart';
import 'package:quran__academy/other/Home/homeweb/webacademics/CourseWeb.dart';
import 'package:quran__academy/other/Home/homeweb/webacademics/FacilityWeb.dart';
import 'package:quran__academy/other/Home/homeweb/webacademics/web_faculty.dart';
import 'package:quran__academy/other/Home/homeweb/webcharity/Web_charity.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart'; 




class Home_Phone extends StatefulWidget {
  const Home_Phone({super.key});

  @override
  State<Home_Phone> createState() => _Home_PhoneState();
}

class _Home_PhoneState extends State<Home_Phone> with TickerProviderStateMixin {
  double spacing = 25;
  double fontSize = 15;

  late AnimationController _slideController;
  late Animation<Offset> _animationLeft;
  late Animation<Offset> _animationRight;

  late ScrollController _scrollController;
  late AnimationController _scrollControllerAuto;
  late Animation<double> _scrollAnimation;

  @override
  void initState() {
    super.initState();

    // Slide Animation
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _animationLeft = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeInOut));

    _animationRight = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeInOut));

    _slideController.forward();

    // Auto Scroll Setup
    _scrollController = ScrollController();
    _scrollControllerAuto = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );

    _scrollAnimation = Tween<double>(
      begin: 0.0,
      end: 1000.0, // Adjust as needed
    ).animate(CurvedAnimation(
      parent: _scrollControllerAuto,
      curve: Curves.linear,
    ))
      ..addListener(() {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_scrollAnimation.value);
        }
      });

    _startAutoScroll();
  }

  void _startAutoScroll() {
    _scrollControllerAuto.forward().whenComplete(() {
      _scrollControllerAuto.reset();
      _startAutoScroll();
    });
  }

  void _pauseScroll() {
    _scrollControllerAuto.stop();
  }

  void _resumeScroll() {
    _scrollControllerAuto.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _scrollController.dispose();
    _scrollControllerAuto.dispose();
    super.dispose();
  }

  Widget _buildNavItem(String title, Widget page) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: fontSize),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),

            // Top Banner
            Container(
              height: 90,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Image.asset("assets/qa.png", width: 70),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "KANNYALA SHIHAB THANGAL THAHFEELUL QURAN ACADEMY",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Navigation
            Container(
              color: AppColors.greens,
              height: 30,
              alignment: Alignment.center,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildNavItem("Home", HomeWeb()),
                    SizedBox(width: spacing),
                    _buildNavItem("About", About()),
                    SizedBox(width: spacing),
                    _buildNavItem("Courses", CourseWeb()),
                    SizedBox(width: spacing),
                    _buildNavItem("Faculty", FacultyWeb()),
                    SizedBox(width: spacing),
                    _buildNavItem("Facility", FacilityWeb()),
                    SizedBox(width: spacing),
                    _buildNavItem("Charity", CharityWeb()),
                    SizedBox(width: spacing),
                    _buildNavItem("Gallery", Gallery_Web()),
                  ],
                ),
              ),
            ),

            // Background Image with Animated Text
            Stack(
              children: [
                Container(
                  height: 400,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/buld.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 400,
                  color: Colors.black.withOpacity(0.7),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SlideTransition(
                          position: _animationLeft,
                          child: const Text(
                            "KANNYALA SHIHAB THANGAL THAHFEELUL",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SlideTransition(
                          position: _animationRight,
                          child: const Text(
                            "QURAN ACADEMY",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Description
            Container(
              color: AppColors.lightGreen,
              padding: const EdgeInsets.all(16.0),
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
              ),
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(width: 17),
                Text(
                  "Events",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w100),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Animated Event List
            Container(
              color: AppColors.lightGreen,
              width: double.infinity,
              height: 200,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ClipRect(
                child: ListView.builder(
                  controller: _scrollController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10, // Adjust this number based on actual events
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTapDown: (_) => _pauseScroll(),
                      onTapUp: (_) => _resumeScroll(),
                      child:
                      const events(), // Custom widget
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 40),

              Container(
  decoration: BoxDecoration(
    color: AppColors.wtgreen,
    borderRadius: BorderRadius.circular(20), // reduced radius
  ),
  width: double.infinity, // make it adapt to screen size instead of fixed 400
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0), // a bit more padding
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 180, // reduced height
          width: 180,  // reduced width
          decoration: BoxDecoration(
            color: AppColors.brown,
            borderRadius: BorderRadius.circular(20), // reduced radius
          ),
          child: Center(
            child: CircleAvatar(
              radius: 70, // smaller circle
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0), // padding inside avatar
                child: Image.asset("assets/qa.png", fit: BoxFit.contain),
              ),
            ),
          ),
        ),
        const SizedBox(width: 20), // smaller gap
        
        Expanded(
          child: SizedBox(
            // no fixed width
            child: const Padding(
              padding: EdgeInsets.all(16.0), // lighter padding
              child: Text(
                "Kannyala Shihab Thangal Thahfeelul Quran Academy is committed to developing well-rounded "
                "leaders who excel in both religious and secular realms. The college’s "
                "unique blend of Qur'anic education and academic excellence "
                "empowers students to become confident, knowledgeable, and "
                "spiritually grounded individuals, ready to face the challenges of the "
                "modern world."
                "By fostering a strong sense of faith, academic achievement, and "
                "personal integrity, Kannyala Shihab Thangal Thahfeelul Quran Academy  "
                "continues to shape the future of Islamic scholarship and leadership.",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w500, color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    ),
  ),
),
SizedBox(height: 40),

    MapImage(),











          ],
        ),
      ),
    );
  }
}











class events extends StatefulWidget {
  const events({super.key});

  @override
  State<events> createState() => _eventsState();
}

class _eventsState extends State<events> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('events').orderBy('createdAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No Events Available", style: TextStyle(fontSize: 18, color: Colors.black)));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var eventData = snapshot.data!.docs[index].data() as Map<String, dynamic>;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                      child: eventData['imageUrl'] != null && eventData['imageUrl'] != ''
                          ? Image.network(
                              eventData['imageUrl'],
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              "assets/buld.jpg",
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              eventData['title'] ?? "Event Title",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              eventData['description'] ?? "No description available",
                              style: TextStyle(fontSize: 18, color: Colors.black),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Location: ${eventData['location'] ?? 'Not specified'}",
                              style: TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${eventData['date'] ?? 'Unknown'} | ${eventData['time'] ?? 'N/A'}",
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}


