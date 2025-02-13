
import 'package:flutter/material.dart';
import 'package:quran__academy/other/Widget%20class/container_green.dart';


class DonationPayWeb extends StatefulWidget {
  const DonationPayWeb({super.key});

  @override
  State<DonationPayWeb> createState() => _DonationPayWebState();
}

class _DonationPayWebState extends State<DonationPayWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GreenCondainer(),
            const SizedBox(height: 20),
            const Text(
              "Payment Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              height: 540,
              width: 500,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(40),
              ),
              child:Text("gy7g") // Razorpay Payment Button
            ),
          ],
        ),
      ),
    );
  }
}

