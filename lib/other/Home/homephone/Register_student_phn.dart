import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quran__academy/Widget%20class/theme.dart';
import 'package:quran__academy/other/Home/homephone/Student_profile_phn.dart';

class StudentRegistration extends StatefulWidget {
  const StudentRegistration({super.key});

  @override
  State<StudentRegistration> createState() => _StudentRegistrationState();
}

class _StudentRegistrationState extends State<StudentRegistration> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _standardController = TextEditingController();
  final TextEditingController _juzzController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  
  File? _image;
  final ImagePicker _picker = ImagePicker();

  String? _userName;
  String? _userPhone;
  String? _userUID;

  bool _isLoading = false; // Loading state

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  /// Fetch logged-in user's data from Firestore
  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _userUID = user.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(_userUID)
          .get();

      if (userDoc.exists) {
        setState(() {
          _userName = userDoc['Name'];
          _userPhone = userDoc['Phone'];
        });
      }
    }
  }

  /// Function to pick image
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  /// Function to upload image to Firebase
  Future<String?> _uploadImageToFirebase(File image) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref =
          FirebaseStorage.instance.ref().child('student_images/$fileName');
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print("Image upload error: $e");
      return null;
    }
  }

  /// Save student data to Firestore
  Future<void> _saveToFirestore() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true; // Show loading indicator
    });

    String? imageUrl;
    if (_image != null) {
      imageUrl = await _uploadImageToFirebase(_image!);
    }

    Map<String, dynamic> studentData = {
      'uid': _userUID,
      'registered_by': _userName,
      'Phone': _userPhone,
      'Name': _studentNameController.text,
      'standard': _standardController.text,
      'current_juzz': _juzzController.text,
      'dob': _dateController.text,
      'address': _addressController.text,
      'image_url': imageUrl ?? '',
      'timestamp': FieldValue.serverTimestamp(),
    };

    try {
      await FirebaseFirestore.instance.collection('students').add(studentData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Student Registered Successfully')),
      );
      _clearForm();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => StudentProfile(),
        ),
      );
    } catch (e) {
      print("Firestore error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error registering student')),
      );
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  /// Clear form after submission
  void _clearForm() {
    _studentNameController.clear();
    _standardController.clear();
    _juzzController.clear();
    _dateController.clear();
    _addressController.clear();
    setState(() {
      _image = null;
    });
  }

  /// Text field widget
  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    bool isNumber = false,
    bool isDate = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        readOnly: isDate,
        maxLines: maxLines,
        onTap: isDate
            ? () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  setState(() {
                    controller.text =
                        "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                  });
                }
              }
            : null,
        validator: (value) =>
            (value == null || value.isEmpty) ? '$label cannot be empty' : null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black54),
          filled: true,
          fillColor: Colors.grey[300],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      appBar: AppBar(
        backgroundColor: AppColors.lightGreen,
        title: const Text("Register Student"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? const Icon(Icons.camera_alt, size: 40, color: Colors.grey)
                      : null,
                ),
              ),

              const SizedBox(height: 10),

              _buildTextField(_studentNameController, "Student Name"),
              _buildTextField(_standardController, "Standard"),
              _buildTextField(_juzzController, "Current Juzz", isNumber: true),
              _buildTextField(_dateController, "Date of Birth", isDate: true),
              _buildTextField(_addressController, "Address", maxLines: 4),

              const SizedBox(height: 20),

              // Show Circular Progress Indicator when loading
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _saveToFirestore,
                      child: const Text("Submit"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
