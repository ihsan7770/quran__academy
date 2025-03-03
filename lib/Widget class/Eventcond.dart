import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quran__academy/Widget%20class/theme.dart';

class Eventcond extends StatefulWidget {
  const Eventcond({super.key});

  @override
  State<Eventcond> createState() => _EventcondState();
}

class _EventcondState extends State<Eventcond> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('events').orderBy('createdAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Show loading indicator
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No Events Available", style: TextStyle(fontSize: 18, color: Colors.black)));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var eventData = snapshot.data!.docs[index].data() as Map<String, dynamic>;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Image section
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                      child: eventData['imageUrl'] != null && eventData['imageUrl'] != ''
                          ? Image.network(
                              eventData['imageUrl'],
                              width: 400,
                              height: 400,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              "assets/buld.jpg", // Fallback image
                              width: 400,
                              height: 400,
                              fit: BoxFit.cover,
                            ),
                    ),
                    // Content section
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Event Title
                            Text(
                              eventData['title'] ?? "Event Title",
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),

                            // Event Description
                            Text(
                              eventData['description'] ?? "No description available",
                              style: TextStyle(fontSize: 18, color: Colors.black),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),

                            SizedBox(height: 10),
                            Text(
                              "Location: ${eventData['location'] ?? 'Not specified'}",
                              style: TextStyle(fontSize: 18, color: Colors.black),
                            ),

                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Date and Time
                                Text(
                                  "${eventData['date'] ?? 'Unknown'} | ${eventData['time'] ?? 'N/A'}",
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                ),
                                // Join Event Button
                               
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
