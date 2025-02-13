import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPhone extends StatefulWidget {
  const LoginPhone({super.key});

  @override
  State<LoginPhone> createState() => _LoginPhoneState();
}

class _LoginPhoneState extends State<LoginPhone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
       
        
        children: [
          
          SizedBox(height: 70,),
          Padding(
            padding: const EdgeInsets.only(left: 5,right: 1,top: 1,bottom: 1),
            child: Image.asset("assets/qa.png",height: 200,width: 200,),
          ),

          Text("Welcome to Quran Academy",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          Text("In the name of your Lord",style: TextStyle(color: Colors.grey),),
          SizedBox(height: 50,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                decoration: InputDecoration(
                  
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.black54), // Hint text color
                  filled: true,
                  fillColor: Colors.grey[300], // Light grey background
                   border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30), // Fully rounded shape
                  borderSide: BorderSide.none, // No border
                ),// No border
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16), // Padding inside
                ),
              ),
          ),

           Padding(
            padding:  EdgeInsets.all(8.0),
            child: TextFormField(
                decoration: InputDecoration(
                  
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.black54), // Hint text color
                  filled: true,
                  fillColor: Colors.grey[300], // Light grey background
                   border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30), // Fully rounded shape
                  borderSide: BorderSide.none, // No border
                ),// No border
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16), // Padding inside
                ),
              ),
          ),

         Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
          onPressed: () {
      // Add your button action here
           },
           style: ElevatedButton.styleFrom(
           backgroundColor: Colors.green, // Set button color to green
           shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(30), // Rounded borders
           ),
           padding: EdgeInsets.symmetric(horizontal: 159, vertical: 13), // Adjust size
           elevation: 5, // Shadow effect
           ),
            child: Text(
            "Login",
             style: TextStyle(fontSize: 18, color: Colors.white),
             ),
             ),
             ),
             SizedBox(height: 120),

Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [

  Text("Don't have an account?"),
  SizedBox(width: 5,),
  Text("Register",style:TextStyle(color:Colors.green,fontWeight: FontWeight.w600))

],)






        ],
      ),




    );
  }
}