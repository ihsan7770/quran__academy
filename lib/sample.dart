// import 'dart:io';
// import 'package:flutter/material.dart';
// // import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';

// class UploadImage extends StatefulWidget {
//   const UploadImage({super.key});

//   @override
//   State<UploadImage> createState() => _UploadImageState();
// }

// class _UploadImageState extends State<UploadImage> {
//   File? _image;
//   bool _isUploading = false;
//   String? _uploadedImageUrl;

//   // Function to pick an image from gallery
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   // Function to upload image to Firebase Storage
//   Future<void> _uploadImage() async {
//     if (_image == null) return;

//     setState(() {
//       _isUploading = true;
//     });

//     try {
//       String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//       final storageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');

//       await storageRef.putFile(_image!);

//       String downloadUrl = await storageRef.getDownloadURL();
//       setState(() {
//         _uploadedImageUrl = downloadUrl;
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Upload Successful!')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Upload Failed: $e')),
//       );
//     } finally {
//       setState(() {
//         _isUploading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Upload Image')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             _image != null
//                 ? Image.file(_image!, height: 200)
//                 : const Placeholder(fallbackHeight: 200),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: const Text('Select Image'),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _isUploading ? null : _uploadImage,
//               child: _isUploading
//                   ? const CircularProgressIndicator(color: Colors.white)
//                   : const Text('Upload Image'),
//             ),
//             const SizedBox(height: 20),
//             if (_uploadedImageUrl != null)
//               Text('Image URL: $_uploadedImageUrl'),
//           ],
//         ),
//       ),
//     );
//   }
// }
