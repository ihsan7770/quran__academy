import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quran__academy/Admin/admin_home_phn.dart';
import 'package:quran__academy/Widget%20class/theme.dart';

class AdminSponsershipManagement extends StatefulWidget {
  const AdminSponsershipManagement({super.key});

  @override
  State<AdminSponsershipManagement> createState() => _AdminSponsershipManagementState();
}

class _AdminSponsershipManagementState extends State<AdminSponsershipManagement> {
  double totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateTotalDonations();
  }

  Future<void> _calculateTotalDonations() async {
    var snapshot = await FirebaseFirestore.instance.collection('sponsorships').get();
    double sum = snapshot.docs.fold(0, (total, doc) => total + (doc['amount'] ?? 0));
    setState(() {
      totalAmount = sum;
    });
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
        title: const Text("Sponsorships"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.greens,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Amount:",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "₹${totalAmount.toStringAsFixed(2)}",
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('sponsorships').orderBy('timestamp', descending: true).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No sponsorship records found."));
                }

                var sponsorships = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: sponsorships.length,
                  itemBuilder: (context, index) {
                    var data = sponsorships[index].data() as Map<String, dynamic>;
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ListTile(
                        title: Text(data['student_name'] ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Amount: ₹${data['amount']}", style: const TextStyle(color: Colors.green)),
                            Text("Card Holder: ${data['card_holder']}", style: const TextStyle(color: Colors.black54)),
                          ],
                        ),
                        trailing: Text(data['timestamp'] != null
                            ? (data['timestamp'] as Timestamp).toDate().toString()
                            : 'No date'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
