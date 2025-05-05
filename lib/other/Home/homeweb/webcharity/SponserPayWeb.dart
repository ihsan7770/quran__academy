import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:quran__academy/Widget%20class/container_green.dart';
import 'package:quran__academy/Widget%20class/theme.dart';

class SponserPayWeb extends StatefulWidget {
  final Map<String, dynamic> studentData;

  const SponserPayWeb({Key? key, required this.studentData}) : super(key: key);

  @override
  State<SponserPayWeb> createState() => _SponserPayWebState();
}

class _SponserPayWebState extends State<SponserPayWeb> {
  final double amount = 25000.0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool isProcessing = false;

  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController cardHolderNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: Stack(
        children: [
          Column(
            children: [
              GreenCondainer(),
              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'Sponsoring: ${widget.studentData['Name'] ?? 'No Name'}',
                          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                        ),
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
                        Form(
                          key: formKey,
                          child: SizedBox(
                            width: 450,
                            child: Column(
                              children: [
                                _buildTextField(
                                  cardNumberController,
                                  'Card Number',
                                  'XXXX XXXX XXXX XXXX',
                                  TextInputType.number,
                                  (value) => setState(() => cardNumber = value),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(19),
                                    _CardNumberInputFormatter(),
                                  ],
                                ),
                                _buildTextField(
                                  expiryDateController,
                                  'Expiry Date',
                                  'MM/YY',
                                  TextInputType.datetime,
                                  (value) => setState(() => expiryDate = value),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(5),
                                    _ExpiryDateInputFormatter(),
                                  ],
                                ),
                                _buildTextField(
                                  cvvController,
                                  'CVV',
                                  'XXX',
                                  TextInputType.number,
                                  (value) => setState(() => cvvCode = value),
                                  obscureText: true,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(3),
                                  ],
                                ),
                                _buildTextField(
                                  cardHolderNameController,
                                  'Cardholder Name',
                                  '',
                                  TextInputType.text,
                                  (value) => setState(() => cardHolderName = value),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: isProcessing
                                      ? null
                                      : () {
                                          if (formKey.currentState!.validate()) {
                                            _showConfirmationDialog();
                                          }
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.greens,
                                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                                  ),
                                  child: Text(
                                    "Donate ₹$amount",
                                    style: const TextStyle(color: Colors.white),
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
            ],
          ),
          if (isProcessing)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    String hint,
    TextInputType keyboardType,
    Function(String) onChanged, {
    bool obscureText = false,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Payment"),
        content: Text("Are you sure you want to donate ₹$amount?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _processPayment();
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }

  void _processPayment() async {
    setState(() => isProcessing = true);

    await FirebaseFirestore.instance.collection('sponsorships').add({
      'student_uid': widget.studentData['uid'] ?? '',
      'student_name': widget.studentData['Name'] ?? 'Unknown',
      'amount': amount,
      'card_holder': cardHolderName,
      'timestamp': FieldValue.serverTimestamp(),
    });

    setState(() => isProcessing = false);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Column(
          children: const [
            Icon(Icons.check_circle, color: Colors.green, size: 50),
            SizedBox(height: 10),
            Text("Payment Successful"),
          ],
        ),
        content: const Text("Your payment has been processed successfully."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}

// Optional: Card Number Formatter
class _CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'\D'), '');
    final newText = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i != 0 && i % 4 == 0) {
        newText.write(' ');
      }
      newText.write(text[i]);
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

// Optional: Expiry Date Formatter
class _ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'\D'), '');
    final newText = StringBuffer();
    for (int i = 0; i < text.length && i < 4; i++) {
      if (i == 2) newText.write('/');
      newText.write(text[i]);
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
