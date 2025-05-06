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
  Timer? _timer;
  StreamSubscription<QuerySnapshot>? _subscription;

  @override
  void initState() {
    super.initState();
    _listenToNotifications(); // live updates
    _startAutoSwitching();
  }

  void _listenToNotifications() {
    _subscription = FirebaseFirestore.instance
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .limit(5)
        .snapshots()
        .listen((snapshot) {
      if (!mounted) return;

      final updatedAnnouncements = snapshot.docs
          .map((doc) => (doc['description'] ?? "No announcement").toString())
          .toList();

      setState(() {
        announcements = updatedAnnouncements.isNotEmpty
            ? updatedAnnouncements
            : ["No announcements yet!"];

        // Ensure currentIndex is within bounds after update
        if (currentIndex >= announcements.length) {
          currentIndex = 0;
        }
      });
    }, onError: (error) {
      if (mounted) {
        setState(() {
          announcements = ["Error loading announcements!"];
        });
      }
    });
  }

  void _startAutoSwitching() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted || announcements.isEmpty) {
        timer.cancel();
        return;
      }

      setState(() {
        isFading = false;
      });

      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted && announcements.isNotEmpty) {
          setState(() {
            currentIndex = (currentIndex + 1) % announcements.length;
            isFading = true;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _subscription?.cancel(); // stop listening to Firestore
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
                  announcements.isNotEmpty
                      ? announcements[currentIndex]
                      : "Loading...",
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
