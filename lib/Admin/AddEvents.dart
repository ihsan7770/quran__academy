import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:quran__academy/Admin/AdminAllEvents.dart';
import 'package:quran__academy/Admin/admin_home_phn.dart';
import 'package:quran__academy/Widget%20class/theme.dart';

class AddEvents extends StatefulWidget {
  const AddEvents({super.key});

  @override
  State<AddEvents> createState() => _AddEventsState();
}

class _AddEventsState extends State<AddEvents> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  File? _selectedImage;
  bool _isLoading = false; // Loading state

  // Function to pick an image
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // Image upload function
  Future<String?> _uploadImage(File imageFile) async {
    try {
      String fileName = 'events/${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference ref = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = ref.putFile(imageFile);

      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print("Image upload failed: $e");
      return null;
    }
  }

  // Function to save event data to Firestore
  Future<void> _saveEvent() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      String? imageUrl;
      if (_selectedImage != null) {
        imageUrl = await _uploadImage(_selectedImage!);
        if (imageUrl == null || imageUrl.isEmpty) {
          setState(() {
            _isLoading = false; // Hide loading indicator
          });
          return;
        }
      }

      await FirebaseFirestore.instance.collection('events').add({
        'title': _titleController.text,
        'description': _descriptionController.text,
        'location': _locationController.text,
        'date': _dateController.text,
        'time': _timeController.text,
        'imageUrl': imageUrl ?? '',
        'createdAt': Timestamp.now(),
      });

      setState(() {
        _isLoading = false; // Hide loading indicator
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Event Created Successfully!')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminHomePhn()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      appBar: AppBar(
        backgroundColor: AppColors.lightGreen,
        title: Text("Add Event"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 30),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminHomePhn()),
            );
          },
        ),
          actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: () {


               Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => EventMangement()));
              
            
                    }, child: Text("All Events")),
          )],



      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              _buildTextField(_titleController, "Title"),
              _buildTextField(_descriptionController, "Description", maxLines: 4),
              _buildDateTimePicker(_dateController, "Select Date", isDate: true),
              _buildDateTimePicker(_timeController, "Select Time", isDate: false),
              _buildTextField(_locationController, "Location"),
              
              // Image Picker
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _selectedImage != null
                        ? Image.file(_selectedImage!, height: 150, width: 150, fit: BoxFit.cover)
                        : Container(
                            height: 150,
                            width: 150,
                            color: Colors.grey[300],
                            child: Icon(Icons.image, size: 50, color: Colors.grey[700]),
                          ),
                    SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: _pickImage,
                      icon: Icon(Icons.camera_alt),
                      label: Text("Pick Image"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Submit Button with Loading Indicator
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveEvent,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 100, vertical: 13),
                    elevation: 5,
                  ),
                  child: _isLoading
                      ? SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : Text(
                          "Create Event",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to build text fields
  Widget _buildTextField(TextEditingController controller, String label, {int maxLines = 1}) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: _inputDecoration(label),
        maxLines: maxLines,
        validator: (value) => value == null || value.isEmpty ? '$label cannot be empty' : null,
      ),
    );
  }

  // Helper function for date and time picker fields
  Widget _buildDateTimePicker(TextEditingController controller, String label, {required bool isDate}) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: _inputDecoration(label),
        readOnly: true,
        onTap: () async {
          if (isDate) {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null) {
              setState(() {
                controller.text = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
              });
            }
          } else {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (pickedTime != null) {
              setState(() {
                controller.text = "${pickedTime.hour}:${pickedTime.minute}";
              });
            }
          }
        },
        validator: (value) => value == null || value.isEmpty ? '$label cannot be empty' : null,
      ),
    );
  }

  // Helper function for input decoration
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey[300],
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
    );
  }
}


