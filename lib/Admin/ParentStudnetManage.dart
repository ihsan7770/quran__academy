import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quran__academy/Admin/admin_home_phn.dart';
import 'package:quran__academy/Widget%20class/theme.dart';

class ParentStudentManaging extends StatefulWidget {
  const ParentStudentManaging({super.key});

  @override
  State<ParentStudentManaging> createState() => _ParentStudentManagingState();
}

class _ParentStudentManagingState extends State<ParentStudentManaging> {
  late Future<Map<String, dynamic>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = _fetchAllDetails();
  }

  /// Fetch Users and Students from Firestore and map them using `uid`
  Future<Map<String, dynamic>> _fetchAllDetails() async {
    Map<String, dynamic> userDataMap = {}; // Store users with their students

    try {
      // Fetch 'users' collection
      QuerySnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('user').get();

      for (var doc in userSnapshot.docs) {
        userDataMap[doc.id] = {
          "userData": doc.data(),
          "students": [],
        };
      }

      // Fetch 'students' collection
      QuerySnapshot studentSnapshot =
          await FirebaseFirestore.instance.collection('students').get();

      for (var doc in studentSnapshot.docs) {
        Map<String, dynamic> studentData = doc.data() as Map<String, dynamic>;
        String parentUid = studentData['uid'] ?? ""; // Parent UID stored in student

        if (userDataMap.containsKey(parentUid)) {
          userDataMap[parentUid]['students'].add(studentData);
        }
      }
    } catch (e) {
      print("Error fetching data: $e");
    }

    return userDataMap;
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
        title: const Text("Parent & Student Details"),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No data found"));
          }

          Map<String, dynamic> userDataMap = snapshot.data!;

          return ListView(
            padding: const EdgeInsets.all(8),
            children: userDataMap.entries.map((entry) {
              Map<String, dynamic> user = entry.value['userData'];
              List students = entry.value['students'];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ExpansionTile(
                  leading: const Icon(Icons.person, color: Colors.blue),
                  title: Text(
                    "${user['Name'] ?? 'No Name'}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Phone: ${user['Phone'] ?? 'N/A'}"),
                  children: students.isEmpty
                      ? [
                          const ListTile(
                            title: Text("No Students Registered"),
                          )
                        ]
                      : students.map((student) {
                          return ListTile(
                            leading: const Icon(Icons.school, color: Colors.green),
                            title: Text("${student['Name'] ?? 'No Name'}"),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (student.containsKey('standard'))
                                  Text("Standard: ${student['standard']}"),
                                if (student.containsKey('current_juzz'))
                                  Text("Juzz: ${student['current_juzz']}"),
                                if (student.containsKey('dob'))
                                  Text("DOB: ${student['dob']}"),
                                if (student.containsKey('address'))
                                  Text("Address: ${student['address']}"),
                              ],
                            ),
                          );
                        }).toList(),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
