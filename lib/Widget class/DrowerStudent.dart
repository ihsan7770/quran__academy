import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quran__academy/Widget%20class/theme.dart';
import 'package:quran__academy/other/Home/homephone/Homework.dart';
import 'package:quran__academy/other/Home/homephone/Login_Phone.dart';
import 'package:quran__academy/other/Home/homephone/StudentComplaints_phn.dart';

class StudentDrower extends StatefulWidget {
  const StudentDrower({super.key});

  @override
  State<StudentDrower> createState() => _StudentDrowerState();
}

class _StudentDrowerState extends State<StudentDrower> {

     String? userName;
    String? userEmail;
 

    Future<void> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        DocumentSnapshot users = await FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .get();

        if (users.exists) {
          setState(() {
            userName = users['Name'] ?? "No Name Found";
            userEmail = users['Email'] ?? "No Email Found";
          });
        } else {
          setState(() {
            userName = "No Name Found";
            userEmail = "No Email Found";
          });
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Call the function here to load user data
  }







  // Logout Function
  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPhone()),
        );
      }
    } catch (error) {
      print("Error signing out: $error");
    }
  }


  
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: AppColors.greens),
              accountName: Text(
                userName ?? '',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              accountEmail: Text(
                userEmail ?? '',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text("Complaints"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StudentComplaints()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text("Home Work"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeWork()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Logout"),
              onTap: () => _logout(context),
            ),
          ],
        ),
      );
  }
}