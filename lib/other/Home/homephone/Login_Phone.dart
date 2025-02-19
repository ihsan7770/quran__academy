import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran__academy/Admin/Registration_Phn.dart';
import 'package:quran__academy/Admin/admin_home_phn.dart';
import 'package:quran__academy/other/Home/homephone/Models/auth_service.dart';
import 'package:quran__academy/other/Home/homephone/Models/user_models.dart';
import 'package:quran__academy/other/Widget%20class/theme.dart';

class LoginPhone extends StatefulWidget {
  const LoginPhone({super.key});

  @override
  State<LoginPhone> createState() => _LoginPhoneState();
}

class _LoginPhoneState extends State<LoginPhone> {

    final String _adminEmail = 'admin@gmail.com';
  final String _adminPassword = 'admin1234';

  UsersModel _usersModel=UsersModel();
  Authentication _authentication =Authentication();

    bool _obscurePassword=true ;

    //login function ends
  
  void _login()async{
  try{
    _usersModel=UsersModel(
      Email: _emailController.text,
      Password: _passwordController.text,
      );
    
    final data = await _authentication.loginUser(_usersModel);
     if(data!=null){
      Navigator.pushNamedAndRemoveUntil(context, 'Home_Phone', (route) => false);
     }

  }on FirebaseAuthException catch (e){
  List err=e.toString().split("]");
  ScaffoldMessenger.of(context)
  .showSnackBar(SnackBar(content: Text(err[1])));
}  }

//login function ends


  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: AppColors.lightGreen,
      body: SingleChildScrollView(
        child: Form( // Wrap with Form widget
          key: _formKey, 
          child: Column(
            children: [
              SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 1, top: 1, bottom: 1),
                child: Image.asset("assets/qa.png", height: 200, width: 200),
              ),
              Text(
                "Welcome to Quran Academy",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                "In the name of your Lord",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 50),

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

              // Login Button



              ElevatedButton(onPressed: () {

                  
                    if (_formKey.currentState!.validate()) {

                              if (_emailController.text == _adminEmail &&
                               _passwordController.text == _adminPassword) {
      
                               Navigator.pushReplacementNamed(context, 'AdminHomePhn');
                              } else {

                             _login();
         
                              }
                     





                               }
                  
                
                               }, child: Text("Login")),
           

                
                  
                  
             

              SizedBox(height: 120),

              // Register Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      
             Navigator.push(context, MaterialPageRoute(builder: (context) =>RegistrationPhone()));
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
