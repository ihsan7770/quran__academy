import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PhoneAnimationContainer extends StatefulWidget {
  const PhoneAnimationContainer({super.key});

  @override
  State<PhoneAnimationContainer> createState() => _PhoneAnimationContainerState();
}

class _PhoneAnimationContainerState extends State<PhoneAnimationContainer> {
  final PageController _pageController = PageController();
  List<Map<String, dynamic>> _events = [];
  int _currentIndex = 0;
  Timer? _timer;
  StreamSubscription<QuerySnapshot>? _eventSubscription;

  @override
  void initState() {
    super.initState();
    _listenToEvents(); // live updates
  }

  // Listen for real-time updates from Firestore
  void _listenToEvents() {
    _eventSubscription = FirebaseFirestore.instance
        .collection('events')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      setState(() {
        _events = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
        _currentIndex = 0;
      });

      if (_events.isNotEmpty) {
        _startAutoScroll();
      }
    }, onError: (error) {
      print("Error listening to events: $error");
    });
  }

  // Start auto-scrolling through events
  void _startAutoScroll() {
    _timer?.cancel(); // clear any previous timer
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_events.isNotEmpty && _pageController.hasClients) {
        _currentIndex = (_currentIndex + 1) % _events.length;
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    _eventSubscription?.cancel(); // stop listening to Firestore
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 305,
      width: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: _events.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                itemCount: _events.length,
                itemBuilder: (context, index) {
                  final event = _events[index];
                  return _buildEventContent(event);
                },
              ),
            ),
    );
  }

  Widget _buildEventContent(Map<String, dynamic> event) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            width: 600,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              image: event['imageUrl'] != null && event['imageUrl'].isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(event['imageUrl']),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: event['imageUrl'] == null || event['imageUrl'].isEmpty
                ? const Center(
                    child: Icon(Icons.image, size: 50, color: Colors.grey),
                  )
                : null,
          ),
        ),
        Text(
          event['title'] ?? "No Title",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(event['date'] ?? "No Date"),
      ],
    );
  }
}
