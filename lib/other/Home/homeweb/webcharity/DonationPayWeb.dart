import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  // 🔥 Text Controllers
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
        'cardNumber': cardNumber.replaceAll(RegExp(r'\D'), '').replaceRange(0, 12, '************'), // Masked
        'expiryDate': expiryDate,
        'cardHolderName': cardHolderName,
        'cvv': '****', // Masked CVV
        'amount': amount,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("❌ Error saving payment details: $e");
    }
  }

  void _resetForm() {
    setState(() {
      cardNumber = '';
      expiryDate = '';
      cardHolderName = '';
      cvvCode = '';
      amount = '';

      amountController.clear();
      cardNumberController.clear();
      expiryDateController.clear();
      cvvController.clear();
      cardHolderNameController.clear();
    });
  }

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
                _resetForm();
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
      body: Column(
        children: [
          GreenCondainer(), // Header

          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  width: 700,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Credit Card Display
                      SizedBox(
                        height: 260,
                        width: 500,
                        child: CreditCardWidget(
                          cardNumber: cardNumber,
                          expiryDate: expiryDate,
                          cardHolderName: cardHolderName,
                          cvvCode: cvvCode,
                          showBackView: isCvvFocused,
                          onCreditCardWidgetChange: (brand) {},
                        ),
                      ),

                      SizedBox(height: 20),

                      // Form
                      SizedBox(
                        height: 450,
                        width: 450,
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              // Amount
                              TextFormField(
                                controller: amountController,
                                decoration: InputDecoration(
                                  labelText: 'Donation Amount',
                                  hintText: 'Enter amount in Rs',
                                  prefixIcon: Icon(Icons.currency_rupee),
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) => value!.isEmpty ? 'Enter a valid amount' : null,
                                onChanged: (value) => setState(() => amount = value),
                              ),
                              SizedBox(height: 10),

                              // Card Number
                              TextFormField(
                                controller: cardNumberController,
                                decoration: InputDecoration(
                                  labelText: 'Card Number',
                                  hintText: 'XXXX XXXX XXXX XXXX',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(19),
                                  _CardNumberInputFormatter(),
                                ],
                                onChanged: (value) => setState(() => cardNumber = value),
                              ),
                              SizedBox(height: 10),

                              // Expiry Date
                              TextFormField(
                                controller: expiryDateController,
                                decoration: InputDecoration(
                                  labelText: 'Expiry Date',
                                  hintText: 'MM/YY',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(5),
                                  _ExpiryDateInputFormatter(),
                                ],
                                onChanged: (value) => setState(() => expiryDate = value),
                              ),
                              SizedBox(height: 10),

                              // CVV
                              TextFormField(
                                controller: cvvController,
                                decoration: InputDecoration(
                                  labelText: 'CVV',
                                  hintText: 'XXX',
                                  border: OutlineInputBorder(),
                                ),
                                obscureText: true,
                                keyboardType: TextInputType.number,
                                inputFormatters: [LengthLimitingTextInputFormatter(4)],
                                onChanged: (value) => setState(() => cvvCode = value),
                              ),
                              SizedBox(height: 10),

                              // Card Holder Name
                              TextFormField(
                                controller: cardHolderNameController,
                                decoration: InputDecoration(
                                  labelText: 'Cardholder Name',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) => value!.isEmpty ? 'Enter cardholder name' : null,
                                onChanged: (value) => setState(() => cardHolderName = value),
                              ),
                              SizedBox(height: 20),

                              // Submit Button
                              ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    _showProcessingDialog();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                                ),
                                child: Text(
                                  "Donate ₹${amount.isEmpty ? '0' : amount}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll(RegExp(r'\s+'), '');
    var formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i % 4 == 0 && i != 0) formatted += ' ';
      formatted += text[i];
    }
    return newValue.copyWith(text: formatted, selection: TextSelection.collapsed(offset: formatted.length));
  }
}

class _ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll(RegExp(r'\s+'), '');
    if (text.length >= 2 && !text.contains('/')) text = text.substring(0, 2) + '/' + text.substring(2);
    return newValue.copyWith(text: text, selection: TextSelection.collapsed(offset: text.length));
  }
}
