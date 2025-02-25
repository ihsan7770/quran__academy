import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quran__academy/Widget%20class/container_green.dart';
import 'package:quran__academy/Widget%20class/theme.dart';
import 'package:quran__academy/firebase_options.dart';


class DonationPayWeb extends StatefulWidget {
  const DonationPayWeb({super.key});

  @override
  State<DonationPayWeb> createState() => _DonationPayWebState();
}

class _DonationPayWebState extends State<DonationPayWeb> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  String amount = '';
  bool isCvvFocused = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // 🔥 Text Controllers to Clear Inputs
  final TextEditingController amountController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController cardHolderNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void onCreditCardModelChange(CreditCardModel data) {
    setState(() {
      cardNumber = data.cardNumber;
      expiryDate = data.expiryDate;
      cardHolderName = data.cardHolderName;
      cvvCode = data.cvvCode;
      isCvvFocused = data.isCvvFocused;
    });
  }

  Future<void> _storePaymentDetails() async {
    try {
      await FirebaseFirestore.instance.collection('donations').add({
        'cardNumber': cardNumber.replaceAll(RegExp(r'\D'), '').replaceRange(0, 12, '************'), // Mask card number
        'expiryDate': expiryDate,
        'cardHolderName': cardHolderName,
        'amount': amount,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("❌ Error saving payment details: $e");
    }
  }

  // 🔄 Clear Fields After Donation
  void _resetForm() {
    setState(() {
      cardNumber = '';
      expiryDate = '';
      cardHolderName = '';
      cvvCode = '';
      amount = '';

      // Clear the text controllers
      amountController.clear();
      cardNumberController.clear();
      expiryDateController.clear();
      cvvController.clear();
      cardHolderNameController.clear();
    });
  }

  // 🎉 Show Payment Success Dialog
  void _showSuccessDialog() async {
    await _storePaymentDetails();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Successful! 🎉'),
          content: Text('Thank you for your donation of ₹$amount.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetForm(); // Clear form after success
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showProcessingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Processing Payment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Please wait...'),
            ],
          ),
        );
      },
    );

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pop(context);
      _showSuccessDialog();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GreenCondainer(),

            Container(
              width: 700,
              child: CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                onCreditCardWidgetChange: (brand) {},
              ),
            ),
            Form(
              key: formKey,
              child: Container(
                width: 700,
                child: Column(
                  children: [
                    // 💰 Amount Input Field
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: amountController,
                        decoration: InputDecoration(
                          labelText: 'Donation Amount',
                          hintText: 'Enter amount in Rs',
                          prefixIcon: Icon(Icons.currency_rupee),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid amount';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            amount = value;
                          });
                        },
                      ),
                    ),
                    // Card Number
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: cardNumberController,
                        decoration: InputDecoration(
                          labelText: 'Card Number',
                          hintText: 'XXXX XXXX XXXX XXXX',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            cardNumber = value;
                          });
                        },
                      ),
                    ),
                    // Expiry Date
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: expiryDateController,
                        decoration: InputDecoration(
                          labelText: 'Expiry Date',
                          hintText: 'MM/YY',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.datetime,
                        onChanged: (value) {
                          setState(() {
                            expiryDate = value;
                          });
                        },
                      ),
                    ),
                    // CVV
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: cvvController,
                        decoration: InputDecoration(
                          labelText: 'CVV',
                          hintText: 'XXX',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            cvvCode = value;
                          });
                        },
                      ),
                    ),
                    // Cardholder Name
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: cardHolderNameController,
                        decoration: InputDecoration(
                          labelText: 'Cardholder Name',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            cardHolderName = value;
                          });
                        },
                      ),
                    ),
                    // Submit Button
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          _showProcessingDialog();
                        }
                      },
                      child: Text(
                        "Donate ₹${amount.isEmpty ? '0' : amount}",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.greens,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
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
