import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quran__academy/Widget%20class/container_green.dart';
import 'package:quran__academy/Widget%20class/theme.dart';
import 'package:quran__academy/other/Home/homeweb/webcharity/SponserPayWeb.dart';

class SponsershipWeb extends StatefulWidget {
  const SponsershipWeb({super.key});

  @override
  State<SponsershipWeb> createState() => _SponsershipWebState();
}

class _SponsershipWebState extends State<SponsershipWeb> {
  Set<String> sponsoredStudentUids = {}; // Store UIDs of sponsored students

  @override
  void initState() {
    super.initState();
   _listenSponsoredStudents();
  }

  /// Fetch all sponsored students' UIDs from Firestore
 /// Listen for changes in sponsored students' UIDs from Firestore
void _listenSponsoredStudents() {
  FirebaseFirestore.instance.collection('sponsorships').snapshots().listen(
    (snapshot) {
      setState(() {
        sponsoredStudentUids =
            snapshot.docs.map((doc) => doc['student_uid'] as String).toSet();
      });
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: Column(
        children: [
          GreenCondainer(), // Header Section

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('students')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                      child: Text("No student details available."));
                }

                var studentDocs = snapshot.data!.docs.toList();

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 250,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: studentDocs.length,
                    itemBuilder: (context, index) {
                      var studentDoc = studentDocs[index];
                      var studentData =
                          studentDoc.data() as Map<String, dynamic>;
                      String studentUid = studentData['uid']; // Fetch from 'uid' field
                      bool isSponsored =
                          sponsoredStudentUids.contains(studentUid); // Check if sponsored

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(15)),
                              child: studentData['image_url'] != null &&
                                      studentData['image_url'] != ''
                                  ? Image.network(
                                      studentData['image_url'],
                                      width: double.infinity,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      width: double.infinity,
                                      height: 150,
                                      color: Colors.grey[300],
                                      child: const Icon(Icons.person,
                                          size: 80, color: Colors.grey),
                                    ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      studentData['Name'] ?? 'No Name',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Standard: ${studentData['standard'] ?? 'N/A'}",
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Juzz: ${studentData['current_juzz'] ?? 'N/A'}",
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Phone: ${studentData['Phone'] ?? 'N/A'}",
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const Spacer(),
                                    isSponsored
                                        ? Text(
                                            "Sponsored",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green[700]),
                                          )
                                        : ElevatedButton(
                                            onPressed: () async {
                                              bool? result =
                                                  await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SponserPayWeb(
                                                          studentData:
                                                              studentData),
                                                ),
                                              );
                                    
                                              if (result == true) {
                                               _listenSponsoredStudents();
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.blueAccent),
                                            child: const Text(
                                              'Sponsor',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
