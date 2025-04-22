import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran__academy/Admin/AddEvents.dart';
import 'package:quran__academy/Admin/AdminHomeWork.dart';
import 'package:quran__academy/Admin/AdminSendNotification.dart';
import 'package:quran__academy/Admin/AdminSponsershipMannage.dart';
import 'package:quran__academy/Admin/AdminStudentManage.dart';
import 'package:quran__academy/Admin/Admin_View_Bookings.dart';
import 'package:quran__academy/Admin/Admin_View_Complaints.dart';
import 'package:quran__academy/Admin/Admin_View_DonatedAmount.dart';
import 'package:quran__academy/Admin/ParentStudnetManage.dart';
import 'package:quran__academy/other/Home/homephone/Login_Phone.dart';
import 'package:quran__academy/Widget%20class/theme.dart';

class AdminHomePhn extends StatefulWidget {
  const AdminHomePhn({super.key});

  @override
  State<AdminHomePhn> createState() => _AdminHomePhnState();
}

class _AdminHomePhnState extends State<AdminHomePhn> {
  // Function to create admin buttons dynamically
  Widget buildAdminButton(String title, IconData icon, Widget destination) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => destination));
        },
        child: Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade300, Colors.green.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(4, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      appBar: AppBar(
        backgroundColor: AppColors.lightGreen,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 30, color: Colors.black),
          onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPhone()));
          },
        ),
        title: Text("Admin Panel", style: TextStyle(color: Colors.black)),
       
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              buildAdminButton("Add Events", Icons.event, AddEvents()),
              buildAdminButton("View Complaints", Icons.warning_amber_rounded, AdminComplaints()),
              buildAdminButton("View Invitations", Icons.card_giftcard, AdminViewBookings()),
              buildAdminButton("Send Announcements", Icons.notifications, AdminSendNotification()),
              buildAdminButton("Donated Amount", Icons.attach_money, AdminDonatedAmounts()),
              buildAdminButton("Home Work", Icons.book, AdminHomeWork()),
              buildAdminButton("Parent Details", Icons.people, ParentStudentManaging()),
              buildAdminButton("Student Management", Icons.school, AdminStudentManage()),
              buildAdminButton("Sponsorship Management", Icons.volunteer_activism, AdminSponsershipManagement()),
            ],
          ),
        ),
      ),
    );
  }
}
