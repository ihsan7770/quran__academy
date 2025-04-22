import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quran__academy/Admin/admin_home_phn.dart';
import 'package:quran__academy/Widget%20class/theme.dart';

class AdminSponsershipManagement extends StatefulWidget {
  const AdminSponsershipManagement({super.key});

  @override
  State<AdminSponsershipManagement> createState() =>
      _AdminSponsershipManagementState();
}

class _AdminSponsershipManagementState
    extends State<AdminSponsershipManagement> {
  double totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateTotalDonations();
  }

  Future<void> _calculateTotalDonations() async {
    var snapshot =
        await FirebaseFirestore.instance.collection('sponsorships').get();
    double sum = snapshot.docs
        .fold(0, (total, doc) => total + (doc['amount'] ?? 0.0));
    setState(() {
      totalAmount = sum;
    });
  }

  void _showDeleteConfirmation(BuildContext context, String docId) {
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          content: const Text(
              "Are you sure you want to remove this sponsorship record?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text("Remove"),
              onPressed: () async {
                Navigator.of(context).pop();
                await FirebaseFirestore.instance
                    .collection('sponsorships')
                    .doc(docId)
                    .delete();

                _calculateTotalDonations(); // Update total after deletion
              },
            ),
          ],
        );
      },
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
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "₹${totalAmount.toStringAsFixed(2)}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('sponsorships')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                      child: Text("No sponsorship records found."));
                }

                var sponsorships = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: sponsorships.length,
                  itemBuilder: (context, index) {
                    var data =
                        sponsorships[index].data() as Map<String, dynamic>;
                    Timestamp? timestamp = data['timestamp'];
                    DateTime? expiryDate =
                        timestamp?.toDate().add(const Duration(days: 365));

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: ListTile(
                        title: Text(
                          "Sponsored By: ${data['card_holder'] ?? 'Unknown'}",
                          style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Student Name: ${data['student_name'] ?? 'Unknown'}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("Amount: ₹${data['amount']}",
                                style: const TextStyle(color: Colors.green)),
                            if (timestamp != null)
                              Text(
                                "Date: ${timestamp.toDate().toLocal().toString().split(' ')[0]}",
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.black54),
                              ),
                            if (expiryDate != null)
                              Text(
                                "Expiry Date: ${expiryDate.toLocal().toString().split(' ')[0]}",
                                style: const TextStyle(color: Colors.redAccent),
                              ),
                          ],
                        ),
                        trailing: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12),
                          ),
                          onPressed: () {
                            _showDeleteConfirmation(
                                context, sponsorships[index].id);
                          },
                          child: const Text(
                            "Remove",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
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
