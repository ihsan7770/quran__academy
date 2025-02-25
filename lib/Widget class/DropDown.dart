import 'package:flutter/material.dart';
import 'package:quran__academy/other/Home/homeweb/webacademics/CourseWeb.dart';
import 'package:quran__academy/other/Home/homeweb/webacademics/FacilityWeb.dart';

import 'package:quran__academy/other/Home/homeweb/webacademics/web_faculty.dart';

class AcademicDropdownMenu extends StatefulWidget {
  @override
  _AcademicDropdownMenuState createState() => _AcademicDropdownMenuState();
}

class _AcademicDropdownMenuState extends State<AcademicDropdownMenu> {
  final List<String> academicItems = ["Faculty", "Facility", "Course"];
  bool _isDropdownOpen = false;
  OverlayEntry? _overlayEntry;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_isDropdownOpen) {
          _overlayEntry?.remove();
        } else {
          _showDropdownMenu(context);
        }
        setState(() {
          _isDropdownOpen = !_isDropdownOpen;
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Academics",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          Icon(
            _isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            color: Colors.white, // Arrow color
          ),
        ],
      ),
    );
  }

  void _showDropdownMenu(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero); // Position of the "Academics" text
    final double width = renderBox.size.width; // Width of the text to match the dropdown width

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + renderBox.size.height, // Position below the "Academics" text
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: width, // Match the width of the "Academics" text
            color: Colors.blueGrey[900], // Dropdown background color
            child: Column(
              children: academicItems.map((String item) {
                return InkWell(
                  onTap: () {
                    _navigateToPage(item);
                    _overlayEntry?.remove();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      item,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );

    // Insert the overlay
    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void _navigateToPage(String value) {
    switch (value) {
     
      case "Faculty":
        Navigator.push(context, MaterialPageRoute(builder: (context) => const FacultyWeb()));
        break;
      case "Facility":
        Navigator.push(context, MaterialPageRoute(builder: (context) => FacilityWeb ()));
        break;
      case "Course":
        Navigator.push(context, MaterialPageRoute(builder: (context) => CourseWeb()));
        break;
    }
  }
}
