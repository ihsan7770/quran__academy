import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:quran__academy/Widget%20class/AnnouncementCondainer.dart';

import 'package:quran__academy/Widget%20class/DrowerStudent.dart';
import 'package:quran__academy/Widget%20class/PhoneAnimationCondainer.dart';
import 'package:quran__academy/Widget%20class/theme.dart';
import 'package:quran__academy/Admin/AdminViewNotification.dart';
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
  String profileImageUrl = ""; // Default empty image
  File? _image;

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

  void _fetchStudentData(String uid) async {
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
      } else {
        setState(() {
          studentName = "No Name Found";
          studentJuzz = "N/A";
          studentStandard = "N/A";
          profileImageUrl = "";
        });
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

  // Future<void> _pickImage() async {
  //   final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = File(pickedFile.path);
  //     });
  //     await _uploadImage();
  //   }
  // }

  Future<void> _uploadImage() async {
    if (_image == null || userId == null) return;

    try {
      String filePath = 'profile_images/$userId.jpg';
      Reference ref = FirebaseStorage.instance.ref().child(filePath);
      UploadTask uploadTask = ref.putFile(_image!);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Update Firestore with the new image URL
      await FirebaseFirestore.instance.collection('students').doc(userId).update({
        'image_url': downloadUrl,
      });

      setState(() {
        profileImageUrl = downloadUrl;
      });
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      appBar: AppBar(
        backgroundColor: AppColors.lightGreen,
        title: const Text("Student Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, size: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StudentNotification()),
              );
            },
          ),
        ],
      ),
      drawer: const StudentDrower(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Stack(
              clipBehavior: Clip.none, // Allows overflow
              alignment: Alignment.center,
              children: [
                // Profile Card 
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
                        const SizedBox(height: 60), // Space for Avatar
                        Text(
                          studentName, // Dynamic student name
                          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const SizedBox(width: 80),
                            Column(
                              children: [
                                const Text(
                                  "Juzz",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                                Text(
                                  studentJuzz, // Dynamic Juzz value
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(width: 60),
                            Column(
                              children: [
                                const Text(
                                  "Standard",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                                Text(
                                  studentStandard, // Dynamic Standard value
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Positioned Circle Avatar with Edit Icon
                Positioned(
                  top: 0,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 90,
                        backgroundColor: Colors.blue,
                        backgroundImage: profileImageUrl.isNotEmpty
                            ? NetworkImage(profileImageUrl)
                            : null, // Load image from Firestore
                        child: profileImageUrl.isEmpty
                            ? const Text("IGI", style: TextStyle(color: Colors.white, fontSize: 20))
                            : null, // Hide text when image is present
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap:() {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => StudentProfileUpdate()));
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: AppColors.lightGreen,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(13),
                            child: Text("Profile",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        
            SizedBox(height: 20,),

            
               const Padding(
                    padding: EdgeInsets.only(left: 0, bottom: 10,right: 200),
                    child: Text(
                      "Announcements",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
            


           AnnouncementContainer(),
            SizedBox(height: 20,),

            const Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 10,right: 270),
                    child: Text(
                      "Programs",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  PhoneAnimationContainer()
        
        
       
        
        
        
        
        
          ],
        ),
      ),
    );
  }
}
