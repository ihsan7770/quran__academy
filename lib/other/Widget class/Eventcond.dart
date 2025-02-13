import 'package:flutter/material.dart';
import 'package:quran__academy/other/Widget%20class/theme.dart';

class Eventcond extends StatefulWidget {
  const Eventcond({super.key});

  @override
  State<Eventcond> createState() => _EventcondState();
}

class _EventcondState extends State<Eventcond> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 1500, // Updated width
        height: 400, // Updated height
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15), // Rounded corners for a cleaner look
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Light shadow color
              spreadRadius: 2, // Controls how far the shadow extends
              blurRadius: 10, // Controls the blur of the shadow
              offset: Offset(0, 5), // Controls the shadow's position (vertical offset)
            ),
          ], // Shadow effect for a lifted appearance
        ),
        child: Row(
          children: [
            // Image section
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ), // Rounded corners for image
              child: Image.asset(
                "assets/buld.jpg", // Replace with your actual image path
                width: 600, // Adjusted width to fit larger container
                height: 400, // Ensures the image covers the entire height
                fit: BoxFit.cover, // Ensure the image scales correctly
              ),
            ),
            // Content section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  
                  children: [
                    // Title text
                    Text(
                      "KANNYALA SHIHAB THANGAL THAHFEELUL QURAN ACADEMY",
                      style: TextStyle(
                        fontSize: 30, // Increased font size
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Description text
                    Text(
                      "An institution dedicated to Hifz education, following the traditions of Islamic scholar training in Kerala.",
                      style: TextStyle(fontSize: 20, color: Colors.black), // Increased font size
                    ),
                    SizedBox(height: 150),
                    // Date and Join Event button row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Date and time
                        Text(
                          "31 Jan 2025 | 10:30 AM",
                          style: TextStyle(fontSize: 16, color: Colors.black), // Increased font size
                        ),
                        // Join event button
                        ElevatedButton(
                          onPressed: () {

                             Navigator.pushNamed(context, 'About');
                            // Your action here
                          },
                          style: ElevatedButton.styleFrom(
                            
                            backgroundColor: AppColors.greens, // Green background
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5), // Rounded button edges
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30), // Adjust padding
                          ),
                          child: Text(
                            "Join Event",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18, // Increased font size
                              fontWeight: FontWeight.w400,
                            ), // White text for contrast
                          ),

                          
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
