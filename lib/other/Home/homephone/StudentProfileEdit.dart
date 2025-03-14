import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:quran__academy/Widget%20class/theme.dart';
import 'package:quran__academy/other/Home/homephone/Student_profile_phn.dart';

class StudentProfileEdit extends StatefulWidget {
  const StudentProfileEdit({super.key});

  @override
  State<StudentProfileEdit> createState() => _StudentProfileEditState();
}

class _StudentProfileEditState extends State<StudentProfileEdit> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _standardController = TextEditingController();
  final TextEditingController _juzzController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  
  String? userId;
  String? studentDocId; // Store the Firestore document ID
  File? _image;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _fetchStudentDetails();
  }

  /// Fetch student details and store the correct document ID
  Future<void> _fetchStudentDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    userId = user.uid;
    try {
      QuerySnapshot studentQuery = await FirebaseFirestore.instance
          .collection('students')
          .where('uid', isEqualTo: userId)
          .limit(1)
          .get();

      if (studentQuery.docs.isNotEmpty) {
        var studentDoc = studentQuery.docs.first;
        var studentData = studentDoc.data() as Map<String, dynamic>;
        
        setState(() {
          studentDocId = studentDoc.id; // Store the document ID
          _nameController.text = studentData['Name'] ?? '';
          _standardController.text = studentData['standard']?.toString() ?? '';
          _juzzController.text = studentData['current_juzz']?.toString() ?? '';
          _dobController.text = studentData['dob'] ?? '';
          _addressController.text = studentData['address'] ?? '';
          _imageUrl = studentData['image_url'];
        });
      } else {
        print("Student document not found.");
      }
    } catch (e) {
      print("Error fetching student details: $e");
    }
  }

  /// Update only the student document
  Future<void> _updateProfile() async {
    if (studentDocId == null) {
      print("No student document found for update.");
      return;
    }

    String? imageUrl = _imageUrl;
    if (_image != null) {
      final ref = FirebaseStorage.instance.ref().child('profile_images/$userId.jpg');
      await ref.putFile(_image!);
      imageUrl = await ref.getDownloadURL();
    }

    try {
      await FirebaseFirestore.instance.collection('students').doc(studentDocId).update({
        'Name': _nameController.text,
        'standard': _standardController.text,
        'current_juzz': _juzzController.text,
        'dob': _dobController.text,
        'address': _addressController.text,
        if (imageUrl != null) 'image_url': imageUrl,
      });

      Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentProfile()));
    } catch (e) {
      print("Error updating profile: $e");
    }
  }

  /// Pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentProfile()));
          },
        ),
        title: const Text("Profile Editing"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: _image != null
                      ? FileImage(_image!) as ImageProvider<Object>
                      : (_imageUrl != null && _imageUrl!.isNotEmpty
                          ? NetworkImage(_imageUrl!) as ImageProvider<Object>
                          : null), // No default image
                  child: (_image == null && (_imageUrl == null || _imageUrl!.isEmpty))
                      ? const Icon(Icons.camera_alt, size: 40, color: Colors.grey) // Always show camera icon
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField("Student Name", _nameController),
              _buildTextField("Standard", _standardController),
              _buildTextField("Juzz", _juzzController),
              _buildTextField("Date of Birth", _dobController),
              _buildTextField("Address", _addressController, maxLines: 4),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Save", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/// Reusable TextField Widget with optional maxLines
Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: TextField(
      controller: controller,
      maxLines: maxLines, // Allows multi-line input for Address
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black54),
        filled: true,
        fillColor: Colors.grey[300],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    ),
  );
}

