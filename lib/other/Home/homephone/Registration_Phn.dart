import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quran__academy/Models/auth_service.dart';
import 'package:quran__academy/Models/user_models.dart';
import 'package:quran__academy/Widget%20class/theme.dart';

class RegistrationPhone extends StatefulWidget {
  const RegistrationPhone({super.key});

  @override
  State<RegistrationPhone> createState() => _RegistrationPhoneState();
}

class _RegistrationPhoneState extends State<RegistrationPhone> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  
  bool _obscurePassword = true;
  bool _isLoading = false; // Loading state

  UsersModel _usersModel = UsersModel();
  Authentication _authentication = Authentication();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Registration function with loading indicator
  void _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true; // Show loading indicator
    });

    _usersModel = UsersModel(
      Email: _emailController.text,
      Password: _passwordController.text,
      Name: _nameController.text,
      Phone: _phoneController.text,
      Status: 1,
      CreatedAt: DateTime.now(),
    );

    try {
      final userdata = await _authentication.registerUser(_usersModel);
      if (userdata != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, 'StudentRegistration', (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Registration failed. Please try again.";

      if (e.code == "email-already-in-use") {
        errorMessage = "This email is already registered. Please log in.";
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      appBar: AppBar(
        backgroundColor: AppColors.lightGreen,
        title: Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(_nameController, "Name", TextInputType.text, (value) {
                  return value!.isEmpty ? "Please enter your name" : null;
                }),
                _buildTextField(_emailController, "Email", TextInputType.emailAddress, (value) {
                  return value!.isEmpty || !value.contains('@') ? "Enter a valid email" : null;
                }),
                _buildPasswordField(),
                _buildTextField(_phoneController, "Phone Number", TextInputType.phone, (value) {
                  return value!.length != 10 ? "Enter a valid 10-digit phone number" : null;
                }),

                SizedBox(height: 20),

                // Show Circular Progress Indicator when loading
                _isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _register,
                        child: Text('Sign Up'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Common function for text fields
  Widget _buildTextField(TextEditingController controller, String label, TextInputType type, String? Function(String?) validator) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[300],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        validator: validator,
      ),
    );
  }

  // Password field with toggle visibility
  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: 'Password',
          filled: true,
          fillColor: Colors.grey[300],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          suffixIcon: IconButton(
            icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
        ),
        obscureText: _obscurePassword,
        validator: (value) {
          return value!.length < 8 ? "Password must be at least 8 characters" : null;
        },
      ),
    );
  }
}
