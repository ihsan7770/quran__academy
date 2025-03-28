import 'package:cloud_firestore/cloud_firestore.dart';
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
        backgroundColor: AppColors.lightGreen,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StudentProfile()),
            );
          },
        ),
        title: const Text("Invitations"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('event_bookings').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final invitations = snapshot.data?.docs ?? [];

          if (invitations.isEmpty) {
            return const Center(child: Text("No invitations available."));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: invitations.length,
            itemBuilder: (context, index) {
              final invitation = invitations[index];
              String eventName = invitation['event_type'] ?? 'Unknown Event';
              String eventDate = invitation['date'] ?? 'No Date';
              String eventTime = invitation['time'] ?? 'No Time';

              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 3,
                child: ListTile(
                  title: Text(
                    eventName,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Date: $eventDate • Time: $eventTime"),
                  leading: const Icon(Icons.event, color: Colors.blue),
                  tileColor: Colors.white,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
