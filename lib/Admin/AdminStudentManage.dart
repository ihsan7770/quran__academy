import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quran__academy/Admin/admin_home_phn.dart';
import 'package:quran__academy/Widget%20class/theme.dart';

class AdminStudentManage extends StatefulWidget {
  const AdminStudentManage({super.key});

  @override
  State<AdminStudentManage> createState() => _AdminStudentManageState();
}

class _AdminStudentManageState extends State<AdminStudentManage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Show Update Dialog to Modify Juzz & Standard
  void _showUpdateDialog(String studentId, String currentJuzz, String currentStandard) {
    TextEditingController juzzController = TextEditingController(text: currentJuzz);
    TextEditingController standardController = TextEditingController(text: currentStandard);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Update Student Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: juzzController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Current Juzz"),
              ),
              TextFormField(
                controller: standardController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Standard"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                await _firestore.collection('students').doc(studentId).update({
                  "current_juzz": juzzController.text.trim(),
                  "standard": standardController.text.trim(),
                });

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Student details updated successfully!")),
                );
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  /// Show full-screen image dialog when user clicks on the profile image
  void _showFullImage(String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
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
        title: const Text("Manage Students"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminHomePhn()));
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('students').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No students found"));
          }

          List<QueryDocumentSnapshot> students = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: students.length,
            itemBuilder: (context, index) {
              var student = students[index];
              String studentId = student.id;
              String name = student['Name'] ?? 'No Name';
              String phone = student['Phone'] ?? 'N/A';
              String standard = student['standard'] ?? 'N/A';
              String juzz = student['current_juzz'] ?? 'N/A';
              String imageUrl = student['image_url'] ?? ''; // Fetch image URL

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  leading: GestureDetector(
                    onTap: () {
                      if (imageUrl.isNotEmpty) {
                        _showFullImage(imageUrl);
                      }
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: imageUrl.isNotEmpty
                          ? NetworkImage(imageUrl) as ImageProvider
                          : const AssetImage('assets/default_avatar.png'),
                    ),
                  ),
                  title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Phone: $phone"),
                      Text("Standard: $standard"),
                      Text("Juzz: $juzz"),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.green),
                    onPressed: () => _showUpdateDialog(studentId, juzz, standard),
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
