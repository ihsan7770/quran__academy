// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class CheckMatchingUIDs extends StatefulWidget {
//   const CheckMatchingUIDs({super.key});

//   @override
//   State<CheckMatchingUIDs> createState() => _CheckMatchingUIDsState();
// }

// class _CheckMatchingUIDsState extends State<CheckMatchingUIDs> {
//   List<String> studentUIDs = [];
//   List<String> sponsoredUIDs = [];
//   List<String> matchingUIDs = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchAndCompareUIDs();
//   }

//   Future<void> _fetchAndCompareUIDs() async {
//     try {
//       // Fetch UIDs from students collection (taking from 'uid' field)
//       QuerySnapshot studentSnapshot =
//           await FirebaseFirestore.instance.collection('students').get();
//       List<String> students = studentSnapshot.docs
//           .map((doc) => doc['uid'] as String) // Fetching from 'uid' field
//           .toList();

//       // Fetch student_uid from sponsorships collection
//       QuerySnapshot sponsorshipSnapshot =
//           await FirebaseFirestore.instance.collection('sponsorships').get();
//       List<String> sponsorships = sponsorshipSnapshot.docs
//           .map((doc) => doc['student_uid'] as String) // Fetching from 'student_uid' field
//           .toList();

//       // Find matching UIDs
//       List<String> matched =
//           students.where((uid) => sponsorships.contains(uid)).toList();

//       setState(() {
//         studentUIDs = students;
//         sponsoredUIDs = sponsorships;
//         matchingUIDs = matched;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       print("Error fetching data: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("UID Comparison")),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text("Students Collection UIDs:", style: TextStyle(fontWeight: FontWeight.bold)),
//                   studentUIDs.isNotEmpty
//                       ? Column(children: studentUIDs.map((uid) => Text(uid)).toList())
//                       : const Text("No UIDs found in Students collection", style: TextStyle(color: Colors.red)),

//                   const SizedBox(height: 20),
//                   const Text("Sponsorships Collection UIDs:", style: TextStyle(fontWeight: FontWeight.bold)),
//                   sponsoredUIDs.isNotEmpty
//                       ? Column(children: sponsoredUIDs.map((uid) => Text(uid)).toList())
//                       : const Text("No UIDs found in Sponsorships collection", style: TextStyle(color: Colors.red)),

//                   const SizedBox(height: 20),
//                   const Text("Matching UIDs:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
//                   matchingUIDs.isNotEmpty
//                       ? Column(children: matchingUIDs.map((uid) => Text(uid)).toList())
//                       : const Text("No matching UIDs found", style: TextStyle(color: Colors.red)),
//                 ],
//               ),
//             ),
//     );
//   }
// }
