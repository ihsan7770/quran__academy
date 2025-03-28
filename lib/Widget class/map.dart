import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MapImage extends StatelessWidget {
  const MapImage({Key? key}) : super(key: key);

  final String googleMapsUrl =
      "https://www.google.com/maps/place/Kannyala+shihab+thangal+thahfeelul+quran+academy/@11.0356634,76.24041,814m/data=!3m2!1e3!4b1!4m6!3m5!1s0x3ba633839095d5c7:0x5f5271d7c60b4817!8m2!3d11.0356581!4d76.2429849!16s%2Fg%2F11qnq_q7q2?entry=ttu&g_ep=EgoyMDI1MDEyOS4xIKXMDSoASAFQAw%3D%3D";

  Future<void> _launchMaps() async {
    final Uri url = Uri.parse(googleMapsUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open Google Maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image with curved decoration inside a Stack
        Stack(
          alignment: Alignment.bottomRight, // Position overlay at bottom-right
          children: [
            InkWell(
              onTap: _launchMaps,
              child: Container(
                width: 1400, // Adjust width as needed
                height: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), // Curved edges
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30), // Clip image to curved shape
                  child: Image.asset(
                    "assets/mp.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Overlay text on image
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10), // Curved overlay
                ),
                child: const Text(
                  "Tap to Open Map",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10), // Space between image and button
      ],
    );
  }
}
