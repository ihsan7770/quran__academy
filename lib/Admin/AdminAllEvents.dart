import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:quran__academy/Admin/admin_home_phn.dart';
import 'package:quran__academy/Widget%20class/theme.dart';

class EventMangement extends StatefulWidget {
  const EventMangement({super.key});

  @override
  State<EventMangement> createState() => _EventMangementState();
}

class _EventMangementState extends State<EventMangement> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to delete an event
  Future<void> _deleteEvent(String eventId, String? imageUrl) async {
    bool confirmDelete = await _showDeleteConfirmation();
    if (!confirmDelete) return;

    try {
      // Delete event image from Firebase Storage (if exists)
      if (imageUrl != null && imageUrl.isNotEmpty) {
        await FirebaseStorage.instance.refFromURL(imageUrl).delete();
      }

      // Delete event document from Firestore
      await _firestore.collection('events').doc(eventId).delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Event deleted successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting event: $e')),
      );
    }
  }

  // Show delete confirmation dialog
  Future<bool> _showDeleteConfirmation() async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Deletion"),
        content: const Text("Are you sure you want to delete this event?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    ) ?? false;
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
                context, MaterialPageRoute(builder: (context) => AdminHomePhn()));
          },
        ),
        title: const Text("Total Events"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('events').orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Error fetching events!"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No events available."));
          }

          var events = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: events.length,
            itemBuilder: (context, index) {
              var eventDoc = events[index];
              var eventData = eventDoc.data() as Map<String, dynamic>;

              return GestureDetector(
                onLongPress: () => _deleteEvent(eventDoc.id, eventData['imageUrl']),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display Event Image (if available)
                      eventData['imageUrl'] != null && eventData['imageUrl'] != ''
                          ? ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                              child: Image.network(
                                eventData['imageUrl'],
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(child: Text("Image Not Available"));
                                },
                              ),
                            )
                          : Container(
                              height: 200,
                              width: double.infinity,
                              color: Colors.grey[300],
                              child: const Icon(Icons.image_not_supported, size: 50),
                            ),

                      // Event Details
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              eventData['title'] ?? 'No Title',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(eventData['description'] ?? 'No Description',
                                style: const TextStyle(fontSize: 14, color: Colors.black87)),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.location_on, color: Colors.red),
                                const SizedBox(width: 5),
                                Text(eventData['location'] ?? 'No Location'),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(Icons.calendar_today, color: Colors.blue),
                                const SizedBox(width: 5),
                                Text(eventData['date'] ?? 'No Date'),
                                const SizedBox(width: 10),
                                const Icon(Icons.access_time, color: Colors.green),
                                const SizedBox(width: 5),
                                Text(eventData['time'] ?? 'No Time'),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Delete Button
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteEvent(eventDoc.id, eventData['imageUrl']),
                        ),
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
