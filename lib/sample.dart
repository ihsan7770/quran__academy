// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:quran__academy/Admin/admin_home_phn.dart';
// import 'package:quran__academy/Widget%20class/theme.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';

// class AdminDonatedAmounts extends StatefulWidget {
//   const AdminDonatedAmounts({super.key});

//   @override
//   State<AdminDonatedAmounts> createState() => _AdminDonatedAmountsState();
// }

// class _AdminDonatedAmountsState extends State<AdminDonatedAmounts> {
//   double totalAmount = 0.0;

//   // 🔥 Calculate Total Donations
//   double _calculateTotal(List<QueryDocumentSnapshot> donations) {
//     double total = 0.0;
//     for (var doc in donations) {
//       total += double.tryParse(doc['amount'].toString()) ?? 0.0;
//     }
//     return total;
//   }

//   // 🧾 Generate PDF from Donations List
//   Future<pw.Document> _generatePdf(List<QueryDocumentSnapshot> donations) async {
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.MultiPage(
//         build: (pw.Context context) => [
//           pw.Header(
//             level: 0,
//             child: pw.Text('Donation Report',
//                 style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
//           ),
//           pw.Table.fromTextArray(
//             headers: ['No.', 'Donor Name', 'Amount (₹)', 'Date'],
//             data: List.generate(donations.length, (index) {
//               final donation = donations[index];
//               final name = donation['cardHolderName'] ?? 'N/A';
//               final amount = donation['amount']?.toString() ?? '0';
//               final date = donation['timestamp'] != null
//                   ? (donation['timestamp'] as Timestamp).toDate().toString().split(' ').first
//                   : 'N/A';
//               return [index + 1, name, amount, date];
//             }),
//           ),
//           pw.SizedBox(height: 20),
//           pw.Text(
//             'Total Donations: ${_calculateTotal(donations).toStringAsFixed(2)} Rs',
//             style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
//           ),
//         ],
//       ),
//     );

//     return pdf;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.lightGreen,
//       appBar: AppBar(
//         backgroundColor: AppColors.lightGreen,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, size: 30),
//           onPressed: () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => AdminHomePhn()),
//             );
//           },
//         ),
//         title: const Text("Donated Amounts"),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('donations')
//             .orderBy('timestamp', descending: true)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text("No donations yet."));
//           }

//           final donations = snapshot.data!.docs;
//           totalAmount = _calculateTotal(donations);

//           return Column(
//             children: [
//               // 🔥 Total Donation Display
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Container(
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: AppColors.greens,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         "Total Donations:",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         "₹${totalAmount.toStringAsFixed(2)}",
//                         style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               // 🧾 PDF Download Button
//               Padding(
//                 padding: const EdgeInsets.only(right: 16.0, bottom: 10),
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: ElevatedButton.icon(
//                     icon: const Icon(Icons.picture_as_pdf),
//                     label: const Text("Download Report"),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.greens,
//                       foregroundColor: Colors.white,
//                     ),
//                     onPressed: () async {
//                       final pdf = await _generatePdf(donations);
//                       await Printing.layoutPdf(
//                           onLayout: (format) => pdf.save());
//                     },
//                   ),
//                 ),
//               ),

//               // 📜 Donations List
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: donations.length,
//                   itemBuilder: (context, index) {
//                     var donation = donations[index];
//                     return Card(
//                       margin: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 8),
//                       elevation: 4,
//                       child: ListTile(
//                         leading: const Icon(Icons.card_giftcard,
//                             color: AppColors.greens),
//                         title: Text(
//                             "Donated by: ${donation['cardHolderName'] ?? 'N/A'}"),
//                         subtitle:
//                             Text("Amount Donated: ₹${donation['amount']}"),
//                         trailing: Text(
//                           donation['timestamp'] != null
//                               ? (donation['timestamp'] as Timestamp)
//                                   .toDate()
//                                   .toString()
//                               : 'N/A',
//                           style: const TextStyle(
//                               fontSize: 12, color: Colors.grey),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
