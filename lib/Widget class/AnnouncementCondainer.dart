import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class AnnouncementContainer extends StatefulWidget {
  const AnnouncementContainer({super.key});

  @override
  State<AnnouncementContainer> createState() => _AnnouncementContainerState();
}

class _AnnouncementContainerState extends State<AnnouncementContainer> {
  List<String> announcements = [];
  int currentIndex = 0;
  bool isFading = true;
  Timer? _timer; // Store the timer reference

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
    _startAutoSwitching();
  }

  Future<void> _fetchNotifications() async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('notifications')
          .orderBy('timestamp', descending: true)
          .limit(5)
          .get();

      if (snapshot.docs.isNotEmpty && mounted) { // Check if widget is still in tree
        setState(() {
          announcements = snapshot.docs
              .map((doc) => (doc['description'] ?? "No announcement available").toString())
              .toList();
        });
      } else if (mounted) {
        setState(() {
          announcements = ["No announcements yet!"];
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          announcements = ["Error loading announcements!"];
        });
      }
    }
  }

  void _startAutoSwitching() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (announcements.isNotEmpty) {
        setState(() {
          isFading = false;
        });

        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            setState(() {
              currentIndex = (currentIndex + 1) % announcements.length;
              isFading = true;
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 305,
      width: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              "assets/ann.jpg",
              height: 305,
              width: 350,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 130,
            left: 90,
            right: 40,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: isFading ? 1.0 : 0.0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  announcements.isNotEmpty ? announcements[currentIndex] : "Loading...",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
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
