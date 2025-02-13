import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Custom TextFormField')),
        body: Center(
          child: SizedBox(
            width: 200, // Adjust width as needed
            height: 60, // Adjust height as needed
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter text',
                hintStyle: TextStyle(color: Colors.black54), // Hint text color
                filled: true,
                fillColor: Colors.grey[300], // Light grey background
                border: InputBorder.none, // No border
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16), // Padding inside
              ),
            ),
          ),
        ),
      ),
    );
  }
}
