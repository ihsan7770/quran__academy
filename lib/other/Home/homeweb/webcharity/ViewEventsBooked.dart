import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quran__academy/Widget%20class/container_green.dart';
import 'package:quran__academy/Widget%20class/theme.dart';
import 'package:quran__academy/other/Home/homeweb/webcharity/EventBookingFeild.dart';

class ViewEventBooked extends StatefulWidget {
  const ViewEventBooked({super.key});

  @override
  State<ViewEventBooked> createState() => _ViewEventBookedState();
}

class _ViewEventBookedState extends State<ViewEventBooked> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: Column(
        children: [
          const GreenCondainer(),
          const SizedBox(height: 8),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('event_bookings').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final bookings = snapshot.data?.docs ?? [];

                if (bookings.isEmpty) {
                  return const Center(child: Text('No event bookings available.'));
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 10,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6,
                      childAspectRatio: 1.3, // Reduced for a more compact layout
                    ),
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      final booking = bookings[index];
                      String eventType = booking['event_type'] ?? 'Unknown Event';
                      String date = booking['date'] ?? 'No Date';
                      String time = booking['time'] ?? 'No Time';

                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 1,
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              eventType,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 6),
                            Text("Date: $date", style: const TextStyle(fontSize: 14)),
                            const SizedBox(height: 4),
                            Text("Time: $time", style: const TextStyle(fontSize: 14)),
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
      floatingActionButton: FloatingActionButton.extended(
  onPressed: () {
   Navigator.push(context,
                               MaterialPageRoute(builder: (context) => EventBookingField()),
                                                                   );
  },
  label: const Text('Book Event',style: TextStyle( color: Colors.white),),
  icon: const Icon(Icons.event,color: Colors.white,),
  backgroundColor: AppColors.greens
),

    );
  }
}
