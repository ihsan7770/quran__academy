import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quran__academy/Admin/admin_home_phn.dart';
import 'package:quran__academy/Widget%20class/theme.dart';

class AdminComplaints extends StatefulWidget {
  const AdminComplaints({super.key});

  @override
  State<AdminComplaints> createState() => _AdminComplaintsState();
}

class _AdminComplaintsState extends State<AdminComplaints> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      appBar: AppBar(
        backgroundColor: AppColors.lightGreen,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => AdminHomePhn()));
          },
        ),
        title: const Text("Received Complaints"),
      ),
    body: StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance.collection('complaints').snapshots(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      print("Loading complaints...");
      return const Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
      print("Firestore Error: ${snapshot.error}");
      return Center(child: Text('Error: ${snapshot.error}'));
    }

    final complaints = snapshot.data?.docs ?? [];
    print("Complaints fetched: ${complaints.length}");

    if (complaints.isEmpty) {
      print("No complaints found!");
      return const Center(child: Text('No complaints available.'));
    }

    return ListView.builder(
      itemCount: complaints.length,
      itemBuilder: (context, index) {
        final complaint = complaints[index];
        print("Complaint Data: ${complaint.data()}"); // Debugging

        String userName = complaint['userName'] ?? 'Unknown User';
        String complaintText = complaint['complaint'] ?? 'No complaint provided';

        return Card(
          margin: const EdgeInsets.all(10),
          elevation: 3,
          child: ListTile(
            title: Text(
              userName,
              style: const TextStyle(fontSize: 20, color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                complaintText,
                style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  },
),

    );
  }
}
