import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'package:quran__academy/Admin/admin_home_phn.dart';
import 'package:quran__academy/Widget%20class/theme.dart';

class AdminHomeWork extends StatefulWidget {
  const AdminHomeWork({super.key});

  @override
  State<AdminHomeWork> createState() => _AdminHomeWorkState();
}

class _AdminHomeWorkState extends State<AdminHomeWork> {
  /// Predefined order of tasks
  final List<String> prayerOrder = [
    "Quran Reading Morning",
    "Tahajud Prayer",
    "Subhi Prayer",
    "Luha Prayer",
    "Sunnah Prayer Before Dhuhur",
    "Dhuhur Prayer",
    "Sunnah Prayer After Dhuhur",
    "Sunnah Prayer Before Asr",
    "Asr Prayer",
    "Sunnah Prayer After Asr",
    "Sunnah Prayer Before Maghrib",
    "Maghrib Prayer",
    "Sunnah Prayer After Maghrib",
    "Sunnah Prayer Before Isha",
    "Hudad Reading",
    "Isha Prayer",
    "Sunnah Prayer After Isha",
    "Quran Reading Night"
  ];

  /// Function to delete a homework record
  void _deleteHomework(String documentId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Deletion"),
        content: const Text("Are you sure you want to delete this homework record?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              await FirebaseFirestore.instance.collection('homework').doc(documentId).delete();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Homework record deleted"), backgroundColor: Colors.red),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Delete"),
          ),
        ],
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
          icon: const Icon(Icons.arrow_back, size: 30),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AdminHomePhn()),
            );
          },
        ),
        title: const Text("HomeWorks"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('homework').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Error loading data"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No homework records found"));
          }

          List<DocumentSnapshot> homeworkDocs = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: homeworkDocs.length,
            itemBuilder: (context, index) {
              var homeworkData = homeworkDocs[index].data() as Map<String, dynamic>;
              String documentId = homeworkDocs[index].id;
              String userName = homeworkData['userName'] ?? "Unknown User";
              String studentName = homeworkData['studentName'] ?? "Unknown Student";
              String studentStandard = homeworkData['studentStandard'] ?? "N/A";
              Map<String, dynamic> tasks = homeworkData['tasks'] ?? {};

              /// Convert Firestore timestamp to formatted DateTime
              Timestamp? timestamp = homeworkData['timestamp'];
              String formattedDate = timestamp != null
                  ? DateFormat('yyyy-MM-dd hh:mm a').format(timestamp.toDate())
                  : "Unknown Date";

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Student Information Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("👨‍👩‍👧 Parent: $userName", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                Text("🎓 Student: $studentName", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                Text("📚 Standard: $studentStandard", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                Text("📅 Submitted: $formattedDate", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue)),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteHomework(documentId),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      /// Homework Status Section
                      ExpansionTile(
                        title: const Text("📋 Homework Status", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        children: prayerOrder.map((prayer) {
                          String status = tasks[prayer] ?? "Not Done"; // Default "Not Done" if not found
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    prayer,
                                    style: const TextStyle(fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  status == "Done" ? "✅ Done" : "❌ Not Done",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: status == "Done" ? Colors.green : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
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
