import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quran__academy/Widget%20class/theme.dart';
import 'package:quran__academy/other/Home/homephone/Student_profile_phn.dart';

class StudentComplaints extends StatefulWidget {
  const StudentComplaints({super.key});

  @override
  State<StudentComplaints> createState() => _StudentComplaintsState();
}

class _StudentComplaintsState extends State<StudentComplaints> {
  final TextEditingController _complaintController = TextEditingController();
  final _complaintKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  Future<void> _submitComplaint() async {
    if (_complaintController.text.isEmpty) {
      print('Please enter your complaint.');
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      String? userName;
      
      if (currentUser != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('user')
            .doc(currentUser.uid)
            .get();
        if (userDoc.exists) {
          userName = userDoc['Name'];
        }
      }

      if (userName == null) {
        print('User not found.');
        setState(() {
          _isSubmitting = false;
        });
        return;
      }

      await FirebaseFirestore.instance.collection('complaints').add({
        'complaint': _complaintController.text,
        'userName': userName,
        'userId': currentUser?.uid,
        'createdAt': Timestamp.now(),
      });

      setState(() {
        _isSubmitting = false;
        _complaintController.clear();
      });

      _showSuccessDialog();
    } catch (e) {
      print('Error occurred while submitting complaint: $e');
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Complaint Submitted'),
          content: const Text('Your complaint has been submitted successfully.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
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
        backgroundColor:AppColors.lightGreen,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 30),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => StudentProfile()));
          },
        ),
        title: Text("Complaints"),
      ),
      body: _isSubmitting
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Form(
                    key: _complaintKey,
                    child: TextFormField(
                      maxLines: 4,
                      controller: _complaintController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        hintText: "Enter your complaint.",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Complaint cannot be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_complaintKey.currentState?.validate() == true) {
                        _submitComplaint();
                      }
                    },
                    child: const Text('Submit'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}