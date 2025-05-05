import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:quran__academy/Widget%20class/AnnouncementCondainer.dart';
import 'package:quran__academy/Widget%20class/DrowerStudent.dart';
import 'package:quran__academy/Widget%20class/PhoneAnimationCondainer.dart';
import 'package:quran__academy/Widget%20class/theme.dart';
import 'package:quran__academy/other/Home/homephone/Student_Profile_Update.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  String? userId;
  String studentName = "Loading...";
  String studentJuzz = "Loading...";
  String studentStandard = "Loading...";
  String profileImageUrl = "";
  bool isSponsored = false;
  StreamSubscription? _sponsorshipSubscription; // Real-time subscription

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
  }

  void _fetchCurrentUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid;
      });
      _fetchStudentData(user.uid);
    }
  }

  Future<void> _fetchStudentData(String uid) async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('students')
          .where('uid', isEqualTo: uid)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        var studentData = snapshot.docs.first;

        setState(() {
          studentName = studentData['Name'] ?? "No Name";
          studentJuzz = studentData['current_juzz'] ?? "N/A";
          studentStandard = studentData['standard'] ?? "N/A";
          profileImageUrl = studentData['image_url'] ?? "";
        });

        _checkSponsorshipStatus(uid); // Start live monitoring
      }
    } catch (e) {
      setState(() {
        studentName = "Error Loading";
        studentJuzz = "N/A";
        studentStandard = "N/A";
        profileImageUrl = "";
      });
    }
  }

  // 🔁 Real-time sponsorship listener
  void _checkSponsorshipStatus(String uid) {
    _sponsorshipSubscription?.cancel(); // Cancel previous if any
    _sponsorshipSubscription = FirebaseFirestore.instance
        .collection('sponsorships')
        .where('student_uid', isEqualTo: uid)
        .snapshots()
        .listen((snapshot) {
      setState(() {
        isSponsored = snapshot.docs.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _sponsorshipSubscription?.cancel(); // Clean up listener
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      appBar: AppBar(
        backgroundColor: AppColors.lightGreen,
        title: const Text("Student Profile"),
      ),
      drawer: const StudentDrower(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 100),
                    width: 350,
                    padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 60),
                        Text(
                          studentName,
                          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const SizedBox(width: 80),
                            Column(
                              children: [
                                const Text("Juzz", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                Text(studentJuzz, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(width: 60),
                            Column(
                              children: [
                                const Text("Standard", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                Text(studentStandard, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        if (isSponsored)
                          Container(
                            height: 64,
                            width: double.infinity,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 1,
                                  right: 1,
                                  child: Image.asset(
                                    "assets/sponser.png",
                                    height: 70,
                                    width: 70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 90,
                        backgroundColor: Colors.white,
                        backgroundImage: profileImageUrl.isNotEmpty ? NetworkImage(profileImageUrl) : null,
                        child: profileImageUrl.isEmpty
                            ? const Text("Null", style: TextStyle(color: Colors.white, fontSize: 20))
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => StudentProfileUpdate()),
                            );
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: AppColors.lightGreen,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(13),
                            child: const Text(
                              "Profile",
                              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 0, bottom: 10, right: 200),
              child: Text("Announcements", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            AnnouncementContainer(),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 10, right: 270),
              child: Text("Programs", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            PhoneAnimationContainer(),
          ],
        ),
      ),
    );
  }
}
