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
          userDataMap[parentUid]['students'].add({"id": doc.id, ...studentData});
        }
      }
    } catch (e) {
      print("Error fetching data: $e");
    }

    return userDataMap;
  }

  void _deleteParentAndStudents(String parentId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Deletion", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        content: const Text("Are you sure you want to delete this parent and all associated students? This action cannot be undone.",
          style: TextStyle(fontSize: 16)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.green, fontSize: 16)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await FirebaseFirestore.instance.collection('user').doc(parentId).delete();
              QuerySnapshot studentSnapshot = await FirebaseFirestore.instance
                  .collection('students')
                  .where('uid', isEqualTo: parentId)
                  .get();
              for (var doc in studentSnapshot.docs) {
                await doc.reference.delete();
              }
              setState(() {
                _dataFuture = _fetchAllDetails();
              });
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
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
              String parentId = entry.key;
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
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteParentAndStudents(parentId),
                  ),
                  children: students.isEmpty
                      ? [const ListTile(title: Text("No Students Registered"))]
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
