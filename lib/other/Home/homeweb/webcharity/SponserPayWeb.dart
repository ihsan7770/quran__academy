import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter/services.dart';
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GreenCondainer(),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 1, child: _buildStudentDetails()),
                const SizedBox(width: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 250,
                        width: 450,
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
                          height: 370,
                          width: 450,
                          child: Column(
                            children: [
                              _buildTextField(
                                cardNumberController,
                                'Card Number',
                                'XXXX XXXX XXXX XXXX',
                                TextInputType.number,
                                (value) {
                                  setState(() {
                                    cardNumber = value;
                                  });
                                },
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
                                (value) {
                                  setState(() {
                                    expiryDate = value;
                                  });
                                },
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
                                (value) {
                                  setState(() {
                                    cvvCode = value;
                                  });
                                },
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
                                (value) {
                                  setState(() {
                                    cardHolderName = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 20),
                              isProcessing
                                  ? const CircularProgressIndicator(
                                      color: Colors.green,
                                    )
                                  : ElevatedButton(
                                      onPressed: _processPayment,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.greens,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 50,
                                          vertical: 15,
                                        ),
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
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    String hint,
    TextInputType inputType,
    Function(String) onChanged, {
    bool obscureText = false,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
        keyboardType: inputType,
        obscureText: obscureText,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildStudentDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: widget.studentData['image_url'] != null &&
                    widget.studentData['image_url'].isNotEmpty
                ? Image.network(
                    widget.studentData['image_url'],
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 200,
                    height: 200,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.person,
                      size: 100,
                      color: Colors.grey,
                    ),
                  ),
          ),
          const SizedBox(height: 20),
          Text(
            'Sponsoring: ${widget.studentData['Name'] ?? 'No Name'}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text("Standard: ${widget.studentData['standard'] ?? 'N/A'}"),
          Text("Juzz: ${widget.studentData['current_juzz'] ?? 'N/A'}"),
          Text("Phone: ${widget.studentData['Phone'] ?? 'N/A'}"),
        ],
      ),
    );
  }

 void _processPayment() {
  if (formKey.currentState!.validate()) {
    setState(() {
      isProcessing = true;
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isProcessing = false;
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Payment Successful'),
          content: Text('You have successfully sponsored the student for ₹$amount.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Pop out of the payment page
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
  }
}

}

class _CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll(RegExp(r'\s+'), '');
    var formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i % 4 == 0 && i != 0) {
        formatted += ' ';
      }
      formatted += text[i];
    }
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class _ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll(RegExp(r'\s+'), '');
    if (text.length >= 2 && !text.contains('/')) {
      text = text.substring(0, 2) + '/' + text.substring(2);
    }
    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
