// // import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class SignUpPage extends StatelessWidget {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   // Function to handle sign-up
//   Future<UserCredential> createUserWithEmailAndPassword(
//     String email,
//     String password,
//   ) async {
//     try {
//       // Create a new user with email and password using Firebase Auth
//       UserCredential userCredential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: email, password: password);
//       return userCredential;
//     } catch (e) {
//       throw Exception('Error creating user: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Sign Up')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(labelText: 'Email'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter an email';
//                   }
//                   return null; // Return null if input is valid
//                 },
//               ),
//               TextFormField(
//                 controller: passwordController,
//                 decoration: InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a password';
//                   } else if (value.length < 6) {
//                     return 'Password must be at least 6 characters';
//                   }
//                   return null; // Return null if input is valid
//                 },
//               ),
//               SizedBox(height: 20),


//               ElevatedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     // If the form is valid, proceed with user creation
//                     try {
//                       final email = _emailController.text;
//                       final password = passwordController.text;

//                       // Call createUserWithEmailAndPassword method
//                       UserCredential userCredential =
//                           await createUserWithEmailAndPassword(
//                         email,
//                         password,
//                       );

//                       // Show success message or navigate
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('User created successfully!')),
//                       );
//                     } catch (e) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Error: $e')),
//                       );
//                     }
//                   }
//                 },
//                 child: Text('Sign Up'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
