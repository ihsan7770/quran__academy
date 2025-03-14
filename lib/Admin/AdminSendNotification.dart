import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quran__academy/Admin/admin_home_phn.dart';
import 'package:quran__academy/Widget%20class/theme.dart';
import 'package:quran__academy/Admin/AdminViewNotification.dart';

class AdminSendNotification extends StatefulWidget {
  const AdminSendNotification({super.key});

  @override
  State<AdminSendNotification> createState() => _AdminSendNotificationState();
}

class _AdminSendNotificationState extends State<AdminSendNotification> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _notificationController = TextEditingController();
  bool _isLoading = false;

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
        title: const Text("Send Announcements "),
        actions: [Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(onPressed: () {

              Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const StudentNotification()),
            );

            
            
          }, child: Text("Details")),
        )],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Description Field
              TextFormField(
                controller: _notificationController,
                decoration: _inputDecoration("Description"),
                maxLines: 4,
                validator: (value) => value == null || value.isEmpty
                    ? 'Description cannot be empty'
                    : null,
              ),
              const SizedBox(height: 20),

              // Send Button
              ElevatedButton(
                onPressed: _isLoading ? null : _sendNotification,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.greens,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Send",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Send notification function
  Future<void> _sendNotification() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await FirebaseFirestore.instance.collection('notifications').add({
          'description': _notificationController.text,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Clear the form and show a success message
        _notificationController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Notification sent successfully!")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminHomePhn()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to send notification: $e")),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Input decoration
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey[300],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
    );
  }
}
