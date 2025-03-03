import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quran__academy/Widget%20class/DrowerStudent.dart';
import 'package:quran__academy/Widget%20class/theme.dart';
import 'package:quran__academy/other/Home/homephone/StudentNotification.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  String? userId;

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
      icon: const Icon(Icons.notifications, size: 30), // Notification icon
      onPressed: () {
        // Add your notification screen navigation here
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StudentNotification()), // Replace with your notification screen
        );
      },
    ),
  ],
),

      drawer: StudentDrower(),

      
      





      body: userId == null
          ? const Center(child: CircularProgressIndicator())
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('students')
                  .where('uid', isEqualTo: userId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error fetching data"),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("No student details found"),
                  );
                }

                var studentData = snapshot.data!.docs.first;

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView(
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: studentData['image_url'] != ''
                                  ? NetworkImage(studentData['image_url'])
                                  : const AssetImage('assets/nasru.png')
                                      as ImageProvider,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildDetailRow("Name", studentData['Name']),
                          _buildDetailRow("Standard", studentData['standard']),
                          _buildDetailRow(
                              "Current Juzz", studentData['current_juzz']),
                          _buildDetailRow("Date of Birth", studentData['dob']),
                          _buildDetailRow("Phone", studentData['Phone']),
                          _buildDetailRow("Address", studentData['address']),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
