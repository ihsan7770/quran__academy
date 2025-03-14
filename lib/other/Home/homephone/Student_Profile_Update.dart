import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quran__academy/other/Home/homephone/StudentProfileEdit.dart';
import 'package:quran__academy/Widget%20class/theme.dart';
import 'package:quran__academy/other/Home/homephone/Student_profile_phn.dart';

class StudentProfileUpdate extends StatefulWidget {
  const StudentProfileUpdate({super.key});

  @override
  State<StudentProfileUpdate> createState() => _StudentProfileUpdateState();
}

class _StudentProfileUpdateState extends State<StudentProfileUpdate> {
  late Future<Map<String, dynamic>> _dataFuture;
  String? currentUserId;

  @override
  void initState() {
    super.initState();
    _dataFuture = _fetchStudentDetails();
  }

  /// Fetch student details using Firebase Authentication (auto-fetch `uid`)
  Future<Map<String, dynamic>> _fetchStudentDetails() async {
    Map<String, dynamic> userDataMap = {}; // Store student & parent data

    try {
      // Get current logged-in user
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("User not logged in");
      }

      currentUserId = user.uid; // Get logged-in user's UID

      // Fetch student details from Firestore where 'uid' matches
      QuerySnapshot studentQuery = await FirebaseFirestore.instance
          .collection('students')
          .where('uid', isEqualTo: currentUserId)
          .limit(1)
          .get();

      if (studentQuery.docs.isNotEmpty) {
        Map<String, dynamic> studentData =
            studentQuery.docs.first.data() as Map<String, dynamic>;
        userDataMap['student'] = studentData;

        // Fetch parent details using 'uid' from the `user` collection
        DocumentSnapshot parentDoc = await FirebaseFirestore.instance
            .collection('user')
            .doc(currentUserId)
            .get();

        if (parentDoc.exists) {
          userDataMap['parent'] = parentDoc.data();
        }
      }
    } catch (e) {
      print("Error fetching data: $e");
    }

    return userDataMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      appBar: AppBar(
        backgroundColor: AppColors.lightGreen,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const StudentProfile()));
          },
        ),
        title: const Text("Student Profile"),
      ),

      /// Display data using FutureBuilder
      body: FutureBuilder<Map<String, dynamic>>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No student data found"));
          }

          Map<String, dynamic> userData = snapshot.data!;
          Map<String, dynamic>? studentData = userData['student'];
          Map<String, dynamic>? parentData = userData['parent'];

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Profile Image with Pencil Icon
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: studentData?['image_url'] != null
                            ? NetworkImage(studentData!['image_url'])
                            : const AssetImage("assets/default_avatar.png")
                                as ImageProvider,
                        child: studentData?['image_url'] == null
                            ? const Icon(Icons.person, size: 80, color: Colors.grey)
                            : null,
                      ),

                      /// Pencil Icon Overlay for Editing
                      Positioned(
                        bottom: 10,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentProfileEdit()));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.edit, color: Colors.white, size: 24),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// Student Name
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      studentData?['Name'] ?? 'No Name',
                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// Row 1: Standard & Juzz
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildInfoBox("Standard", studentData?['standard']?.toString() ?? 'N/A'),
                    _buildInfoBox("Juzz", studentData?['current_juzz']?.toString() ?? 'N/A'),
                  ],
                ),

                /// Row 2: Date of Birth
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildInfoBox("Date of Birth", studentData?['dob']?.toString() ?? 'N/A'),
                  ],
                ),

                /// Parent Details Section
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(
                    "Parent Details",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),

                /// Row 3: Parent Name & Phone
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildInfoBox("Parent Name", parentData?['Name']?.toString() ?? 'N/A'),
                    _buildInfoBox("Phone", parentData?['Phone']?.toString() ?? 'N/A'),
                  ],
                ),

                /// Row 4: Email & Address
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildInfoBox("Email", parentData?['Email']?.toString() ?? 'N/A'),
                    _buildInfoBox("Address", studentData?['address']?.toString() ?? 'N/A'),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Helper function to create info boxes
  Widget _buildInfoBox(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 150,
        width: 170,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
