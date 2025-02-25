import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';  // Import Font Awesome package

class Last_Container extends StatelessWidget {
  const Last_Container({Key? key}) : super(key: key);

   // Function to launch the URL for social media
  Future<void> _launchURL(String url) async {
    final Uri _url = Uri.parse(url);
    if (await canLaunch(_url.toString())) {
      await launch(_url.toString());
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {


    
    return Container(
      width: double.infinity,
      height: 360, // Adjusted height for better layout
      color: Colors.grey[850], // Dark grey color
      child: Row(
      
      
       // Center content horizontally
        children: [
          // First row with Image and Text
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Column with Image and Text
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    Row(
                      children: [
                        Image.asset(
                          "assets/qa.png",
                          height: 100, // Adjusted image size
                          width: 100,  // Adjusted image size
                        ),
                        SizedBox(
                          width: 300,
                          child: Text("KANNYALA SHIHAB THANGAL THAHFEELUL QURAN ACADEMY",style: TextStyle(
                            fontSize: 18, // Adjusted font size for better readability
                            fontWeight: FontWeight.w500,
                            color: Colors.green,
                          ),)),
                      ],
                    ),
                  
                  Padding(
                      padding: const EdgeInsets.only(right: 10,left: 100,bottom: 1,top: 1),
                      child: SizedBox(
                        
                        width: 300, // Limit text width
                        child: Text(
                          "Kannyala Shihab Thangal Thahfeelul Quran Academy is an educational institute of higher religious learning, the equivalent of north Indian madrasa.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 18, // Adjusted font size for better readability
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
////first area ends

          
          
          
          SizedBox(width:150), // Space between rows

          // Second row with Address Details
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    // Address Column
    Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Center the content inside the column
      children: [
        SizedBox(height: 40), // Space between top and "Contact Us"
        
        // Contact Us Text
        Text(
          "Contact Us",
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold, // Add boldness to make it stand out
          ),
        ),
        
        // Divider with defined width
        Container(
          width: 200, // Set width of the divider
          child: Divider(
            color: Colors.white,
            thickness: 2, // Reduced thickness for a more subtle look
            endIndent: 50, // Add some end indent to keep the divider shorter
            indent: 50, // Add some start indent to keep the divider shorter
          ),
        ),
        
        SizedBox(height: 20), // Space between divider and address

        // Location Row (Icon and Address)
        Row(
          mainAxisAlignment: MainAxisAlignment.start, 
          crossAxisAlignment: CrossAxisAlignment.start,// Center the content in the row
          children: [
            Icon(
              Icons.location_on,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(width: 10),
            SizedBox(width: 300,
              child: Text(
                "Kolakkampara Road, Pandikkad Road, Pattikkad, Kerala 679325", // Replace with actual location
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),//location
        SizedBox(height: 10,),

                Row(
          mainAxisAlignment: MainAxisAlignment.start, 
          crossAxisAlignment: CrossAxisAlignment.start,// Center the content in the row
          children: [
            Icon(
              Icons.phone_android_outlined,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(width: 10),
            Text(
              "+91 9633751618", // Replace with actual location
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),//number  
             SizedBox(height: 10,),

                Row(
          mainAxisAlignment: MainAxisAlignment.start, 
          crossAxisAlignment: CrossAxisAlignment.start,// Center the content in the row
          children: [
            Icon(
              Icons.mail,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(width: 10),
            Text(
              "hifzqurancollegekanniyala@gmail.com", // Replace with actual location
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),//mail





      ],
    ),
  ],
),//second row ends



          SizedBox(width:150),// Space between rows

//Social media area start
 Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40), // Space between top and "Social Media"
              Text(
                "Social Media",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              // Divider with defined width
              Container(
                width: 200,
                child: Divider(
                  color: Colors.white,
                  thickness: 2,
                  endIndent: 50,
                  indent: 50,
                ),
              ),
              SizedBox(height: 20),

              // Instagram Row
              InkWell(
                 hoverColor: Colors.amber,
                 onTap: () => _launchURL('https://www.instagram.com/'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      FontAwesomeIcons.instagram, // Instagram icon
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Instagram",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

              // Facebook Row
              InkWell(
                 onTap: () => _launchURL('https://www.instagram.com/'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      FontAwesomeIcons.facebook, // Facebook icon
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Facebook",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

              // Twitter Row
              InkWell(
                onTap: () => _launchURL('https://www.instagram.com/'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Icon(
                      FontAwesomeIcons.twitter, // Twitter icon
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Twitter",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                
                  ],
                ),
              ),
            ],
          ),
        ],
      ),//social media ends






          
        ],
      ),
    );
  }
}
