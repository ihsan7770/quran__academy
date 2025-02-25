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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: Column(
        children: [
          GreenCondainer(), // Header widget

          // Fetch and display student details from Firestore
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
                  return const Center(child: Text("No student details available."));
                }

                // Display student details in a grid
          return Padding(
  padding: const EdgeInsets.all(16.0),
  child: GridView.builder(
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 250, // Adjust grid width dynamically
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      childAspectRatio: 3 / 4, // Card size ratio
    ),
    itemCount: snapshot.data!.docs.length,
    itemBuilder: (context, index) {
      var studentData = snapshot.data!.docs[index].data() as Map<String, dynamic>;

      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display student image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
              child: studentData['image_url'] != null && studentData['image_url'] != ''
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
                      child: const Icon(Icons.person, size: 80, color: Colors.grey),
                    ),
            ),
            // Display student details
            Expanded( // Prevent overflow by adjusting the height
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      studentData['Name'] ?? 'No Name',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
                    FittedBox( // Prevent overflow for the button
                      child: ElevatedButton(
                        onPressed: () {
                               Navigator.push(context,
                               MaterialPageRoute(builder: (context) => SponserPayWeb()),
                                                                   );
                        },
                        child: const Text('Sponsor'),
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
