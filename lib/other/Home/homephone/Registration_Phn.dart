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

//registration function
  void _register() async {
  _usersModel = UsersModel(
    Email: _emailController.text,
    Password: _passwordController.text,
    Name: _nameController.text,
    Phone: _phoneController.text, // Include the phone number
    Status: 1,
    CreatedAt: DateTime.now(),
  );

  try {
    await Future.delayed(Duration(seconds: 1));

    final userdata = await _authentication.registerUser(_usersModel);
    if (userdata != null) {
      Navigator.pushNamedAndRemoveUntil(context, 'StudentRegistration', (route) => false);
    }
  } on FirebaseAuthException catch (e) {
    List err = e.toString().split("]");
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(err[1])));
  }
}

//end





  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _obscurePassword = true;


 UsersModel _usersModel=UsersModel();
 Authentication _authentication =Authentication();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      appBar: AppBar(
        backgroundColor: AppColors.lightGreen,
        title: Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _nameController,
                   decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(color: Colors.black54),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        floatingLabelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                    validator: (value) =>
                        value!.isEmpty ? "Please enter your name" : null,
                  ),
                ),
            
            
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.black54),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        floatingLabelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value!.isEmpty || !value.contains('@')
                        ? "Enter a valid email"
                        : null,
                  ),
                ),
            
            
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _passwordController,
                   decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black54),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        floatingLabelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  
                        
                  suffixIcon: IconButton(
                        icon: Icon(_obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                  
                  
                  
                      ),
                    obscureText: _obscurePassword,
                    validator: (value) => value!.length < 8
                        ? "Password must be at least 8 characters"
                        : null,
                  ),
                ),
            
            
            
            
            
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _phoneController,
                   decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(color: Colors.black54),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        floatingLabelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                    keyboardType: TextInputType.phone,
                    validator: (value) => value!.length != 10
                        ? "Enter a valid 10-digit phone number"
                        : null,
                  ),
                ),
            
            
                SizedBox(height: 20),
                ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, proceed with user creation
                  _register();


                  }
                },
                child: Text('Sign Up'),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
