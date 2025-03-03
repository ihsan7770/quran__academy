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

  // Function to pick an image
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  //image upload

Future<String?> _uploadImage(File imageFile) async {
  try {
    String fileName = 'events/${DateTime.now().millisecondsSinceEpoch}.jpg';
    Reference ref = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = ref.putFile(imageFile);

    // Monitor the upload progress
    uploadTask.snapshotEvents.listen((event) {
      print("Upload Progress: ${(event.bytesTransferred / event.totalBytes) * 100}%");
    });

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    print("Image uploaded successfully: $downloadUrl");
    return downloadUrl;
  } catch (e) {
    print("Image upload failed: $e");
    return null;
  }
}


  // Function to save event data to Firestore
 Future<void> _saveEvent() async {
  if (_formKey.currentState!.validate()) {
    String? imageUrl;

    if (_selectedImage != null) {
      imageUrl = await _uploadImage(_selectedImage!);
      if (imageUrl == null || imageUrl.isEmpty) {
        print("Image upload failed. Not saving to Firestore.");
        return;
      }
    }

    await FirebaseFirestore.instance.collection('events').add({
      'title': _titleController.text,
      'description': _descriptionController.text,
      'location': _locationController.text,
      'date': _dateController.text,
      'time': _timeController.text,
      'imageUrl': imageUrl ?? '',  // Ensure empty string only if upload fails
      'createdAt': Timestamp.now(),
    });

    print("Event saved successfully with image: $imageUrl");
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: () {


               Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => EventMangement()));
              
            
                    }, child: Text("All Events")),
          )],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 30),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminHomePhn()),
            );
          },
        ),
        title: Text("Add Event"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20),

              // Title Field
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _titleController,
                  decoration: _inputDecoration("Title"),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Title cannot be empty' : null,
                ),
              ),

              // Description Field
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _descriptionController,
                  decoration: _inputDecoration("Description"),
                  maxLines: 4,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Description cannot be empty' : null,
                ),
              ),

              // Date Field
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _dateController,
                  decoration: _inputDecoration("Select Date"),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _dateController.text = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                      });
                    }
                  },
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Date cannot be empty' : null,
                ),
              ),

              // Time Field
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _timeController,
                  decoration: _inputDecoration("Select Time"),
                  readOnly: true,
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        _timeController.text = "${pickedTime.hour}:${pickedTime.minute}";
                      });
                    }
                  },
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Time cannot be empty' : null,
                ),
              ),

              // Location Field
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _locationController,
                  decoration: _inputDecoration("Location"),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Location cannot be empty' : null,
                ),
              ),

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

              // Submit Button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: _saveEvent,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 100, vertical: 13),
                    elevation: 5,
                  ),
                  child: Text(
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

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey[300],
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
    );
  }
}
