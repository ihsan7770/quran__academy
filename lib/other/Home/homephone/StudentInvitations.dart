import 'package:flutter/material.dart';
import 'package:quran__academy/Widget%20class/theme.dart';
import 'package:quran__academy/other/Home/homephone/Student_profile_phn.dart';

class StudentInvitations extends StatefulWidget {
  const StudentInvitations({super.key});

  @override
  State<StudentInvitations> createState() => _StudentInvitationsState();
}

class _StudentInvitationsState extends State<StudentInvitations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: AppColors.lightGreen,
        appBar: AppBar(
        backgroundColor:AppColors.lightGreen,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 30),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => StudentProfile()));
          },
        ),
        title: Text("Invitations"),
      ),



    );
  }
}