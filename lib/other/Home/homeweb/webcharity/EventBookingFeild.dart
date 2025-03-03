import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quran__academy/Widget%20class/container_green.dart';
import 'package:quran__academy/Widget%20class/theme.dart';

class EventBookingField extends StatefulWidget {
  const EventBookingField({super.key});

  @override
  State<EventBookingField> createState() => _EventBookingFieldState();
}

class _EventBookingFieldState extends State<EventBookingField> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  // Dropdown event types
  String? _selectedEventType;
  final List<String> _eventTypes = [
    "Marriage",
    "House Warming",
    "Iftar Meet"
  ];

  /// Function to select date
  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        _dateController.text =
            "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      });
    }
  }

  /// Function to select time
  Future<void> _selectTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _timeController.text = pickedTime.format(context);
      });
    }
  }

  /// Function to show confirmation dialog before booking
  Future<bool> _showConfirmationDialog() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Confirm Booking"),
            content: const Text("Are you sure you want to book this event?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Confirm", style: TextStyle(color: Colors.green)),
              ),
            ],
          ),
        ) ??
        false;
  }

  /// Function to save event booking details to Firestore and pop out
  Future<void> _bookEvent() async {
    if (_formKey.currentState!.validate()) {
      bool confirmBooking = await _showConfirmationDialog();
      if (!confirmBooking) return; // Cancel if user selects "Cancel"

      try {
        await FirebaseFirestore.instance.collection('event_bookings').add({
          'name': _nameController.text.trim(),
          'phone': _phoneController.text.trim(),
          'event_type': _selectedEventType, // Use selected event type
          'date': _dateController.text.trim(),
          'time': _timeController.text.trim(),
          'location': _locationController.text.trim(),
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Event Booked Successfully')),
        );

        // Delay pop-out slightly to let the user see the message
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pop(context);
        });

        // Clear fields after booking
        _nameController.clear();
        _phoneController.clear();
        _dateController.clear();
        _timeController.clear();
        _locationController.clear();
        setState(() {
          _selectedEventType = null; // Reset dropdown selection
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  /// Reusable text field widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool isNumber = false,
    bool isDate = false,
    bool isTime = false,
  }) {
    return Container(
      width: 500,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: controller,
        readOnly: isDate || isTime,
        keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
        onTap: isDate
            ? _selectDate
            : isTime
                ? _selectTime
                : null,
        validator: (value) =>
            (value == null || value.isEmpty) ? '$label cannot be empty' : null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black54),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          filled: true,
          fillColor: Colors.grey[300],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  /// Dropdown field for selecting event type
  Widget _buildDropdownField() {
    return Container(
      width: 500,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: DropdownButtonFormField<String>(
        value: _selectedEventType,
        items: _eventTypes.map((type) {
          return DropdownMenuItem<String>(
            value: type,
            child: Text(type),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedEventType = value;
          });
        },
        validator: (value) => value == null ? "Please select an event type" : null,
        decoration: InputDecoration(
          labelText: "Event Type",
          filled: true,
          fillColor: Colors.grey[300],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const GreenCondainer(),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  _buildTextField(controller: _nameController, label: "Name"),
                  _buildTextField(
                      controller: _phoneController,
                      label: "Phone Number",
                      isNumber: true),
                  _buildDropdownField(), // Dropdown for Event Type
                  _buildTextField(
                      controller: _dateController, label: "Date", isDate: true),
                  _buildTextField(
                      controller: _timeController, label: "Time", isTime: true),
                  _buildTextField(
                      controller: _locationController, label: "Location"),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _bookEvent,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      backgroundColor: AppColors.greens,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Book Event",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
